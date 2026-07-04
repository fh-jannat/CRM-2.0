import {
  HttpException,
  HttpStatus,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { ILike, In, Repository } from 'typeorm';
import { CreateUserDto, UpdateUserDto } from '../dtos';
import { DynamicDto } from '../dtos/dynamic.dto';
import { User } from '../entity';
import * as bcrypt from 'bcrypt';
import * as generator from 'generate-password';
import { MailsenderService } from '@/modules/shared/mailsender';
import { Role } from '@/modules/enums/role.enum';

@Injectable()
export class UserCurdService {
  constructor(
    @InjectRepository(User)
    private readonly userRepo: Repository<User>,
    private readonly mailService: MailsenderService,
  ) {}

  async create(user: CreateUserDto): Promise<User> {
    const existingUser = await this.userRepo.findOne({
      where: { email: user.email },
    });
    if (existingUser) {
      throw new HttpException('User already exists', HttpStatus.CONFLICT);
    }
    const password = generator.generate({ length: 12 });
    user.password = await bcrypt.hash(password, 10);

    const createdUser = this.userRepo.create({
      ...user,
      provider: 'local',
      isVerified: true,
      role: user.role,
    });
    await this.userRepo.save(createdUser);
    this.mailService.sendWelcomeEmail({
      to: createdUser.email,
      subject: 'Welcome to the application',
      text: `${password}`,
    });
    return createdUser;
  }

  async resendAuthMail(user: CreateUserDto): Promise<User> {
    const existingUser = await this.userRepo.findOne({
      where: { email: user.email },
    });
    if (!existingUser) {
      return await this.create(user);
    } else {
      const password = generator.generate({ length: 12 });
      existingUser.password = await bcrypt.hash(password, 10);
      await this.userRepo.save(existingUser);
      this.mailService.sendWelcomeEmail({
        to: user.email,
        subject: 'Welcome to the application',
        text: `${password}`,
      });
      return existingUser;
    }
  }

  async count(queryParams: DynamicDto): Promise<number> {
    const { where = {} } = queryParams?.query || {};
    const whereBuilder = {};
    for (const key in where) {
      if (key == 'fullName' && where['fullName'] !== '') {
        whereBuilder[key] = ILike(`%${where[key]}%`);
      }
      if (key == 'email' && where['email'] !== '') {
        whereBuilder[key] = ILike(`%${where[key]}%`);
      }
      if (key == 'role' && where['role'] !== '') {
        whereBuilder[key] = In(where[key]);
      }
    }

    const count = await this.userRepo.count({
      where: whereBuilder,
    });
    const studentCount = await this.userRepo.count({
      where: { role: In([Role.STUDENT]) },
    });
    return count - studentCount;
  }

  async getRoleOption(
    user: User,
    stage: string,
    branchSpecificApplication = false,
  ) {
    const roles = [
      Role.ADMIN,
      Role.MANAGER,
      Role.COUNSELLOR,
      Role.APPLICATION,
      Role.COMPLIANCE,
      Role.TEACHER,
    ];

    const roleFetchers = roles.map((role) => {
      if (branchSpecificApplication) {
        return this.userRepo.find({
          where: { role, branchName: user.branchName },
        });
      } else {
        return this.userRepo.find({ where: { role } });
      }
    });

    const [admins, managers, counsellors, applications, compliances, teacher] =
      await Promise.all(roleFetchers);

    const createOptions = (users, role) =>
      users.map((user) => ({
        label: `${user.fullName}(${role.toLowerCase()})(${user.branchName})`,
        value: user.id,
      }));

    const optionsMap = {
      [Role.ADMIN]: createOptions(admins, 'admin'),
      [Role.MANAGER]: createOptions(managers, 'manager'),
      [Role.COUNSELLOR]: createOptions(counsellors, 'counsellor'),
      [Role.APPLICATION]: createOptions(applications, 'application'),
      [Role.COMPLIANCE]: createOptions(compliances, 'compliance'),
      [Role.TEACHER]: createOptions(teacher, 'teacher'),
    };

    let options = [];
    if (user.role.includes(Role.ADMIN)) {
      if (stage === 'lead') {
        options = [
          ...optionsMap[Role.ADMIN],
          ...optionsMap[Role.MANAGER],
          ...optionsMap[Role.COUNSELLOR],
        ];
      } else if (stage === 'potential') {
        options = [
          ...optionsMap[Role.ADMIN],
          ...optionsMap[Role.MANAGER],
          ...optionsMap[Role.APPLICATION],
        ];
      } else if (stage === 'admission') {
        options = [
          ...optionsMap[Role.ADMIN],
          ...optionsMap[Role.MANAGER],
          ...optionsMap[Role.COMPLIANCE],
        ];
      } else if (stage === 'compliance') {
        options = [];
      } else {
        options = [
          ...optionsMap[Role.ADMIN],
          ...optionsMap[Role.MANAGER],
          ...optionsMap[Role.COUNSELLOR],
          ...optionsMap[Role.APPLICATION],
          ...optionsMap[Role.COMPLIANCE],
          ...optionsMap[Role.TEACHER],
        ];
      }
    } else if (user.role.includes(Role.MANAGER)) {
      if (stage === 'lead') {
        options = [...optionsMap[Role.MANAGER], ...optionsMap[Role.COUNSELLOR]];
      } else if (stage === 'potential') {
        options = [
          ...optionsMap[Role.MANAGER],
          ...optionsMap[Role.APPLICATION],
        ];
      } else if (stage === 'admission') {
        options = [...optionsMap[Role.MANAGER], ...optionsMap[Role.COMPLIANCE]];
      } else if (stage === 'compliance') {
        options = [];
      } else {
        options = [
          ...optionsMap[Role.MANAGER],
          ...optionsMap[Role.COUNSELLOR],
          ...optionsMap[Role.APPLICATION],
          ...optionsMap[Role.COMPLIANCE],
          ...optionsMap[Role.TEACHER],
        ];
      }
    } else if (user.role.includes(Role.COUNSELLOR)) {
      options = [...optionsMap[Role.APPLICATION]];
    } else if (user.role.includes(Role.APPLICATION)) {
      options = [...optionsMap[Role.COMPLIANCE]];
    } else if (user.role.includes(Role.COMPLIANCE)) {
      options = [];
    } else if (user.role.includes(Role.TEACHER)) {
      options = [...optionsMap[Role.TEACHER]];
    }

    return options;
  }

  async findAll(queryParams: DynamicDto, user: User): Promise<User[]> {
    const {
      select = {},
      where = {},
      relations = {},
      page = 1,
      limit = 10,
    } = queryParams?.query || {};
    const skip = ((page > 1 ? page : 1) - 1) * (limit > 0 ? limit : 1);
    const whereBuilder = {};
    for (const key in where) {
      if (key == 'fullName' && where['fullName'] !== '') {
        whereBuilder[key] = ILike(`%${where[key]}%`);
      }
      if (key == 'email' && where['email'] !== '') {
        whereBuilder[key] = ILike(`%${where[key]}%`);
      }
      if (key == 'phoneNumber' && where['phoneNumber'] !== '') {
        whereBuilder[key] = ILike(`%${where[key]}%`);
      }
      if (key == 'branchName' && where['branchName'] !== '') {
        whereBuilder[key] = ILike(`%${where[key]}%`);
      }
      if (key == 'status' && where['status'] !== '') {
        whereBuilder[key] = where[key];
      }
      if (key == 'role' && where['role'] !== '') {
        whereBuilder[key] = In(where[key]);
      }
    }
    if (user.role.includes(Role.MANAGER)) {
      whereBuilder['branchName'] = user.branchName;
    }
    const users = await this.userRepo.find({
      select: select,
      where: whereBuilder,
      relations: relations,
      skip: skip,
      take: limit,
      order: {
        updatedAt: 'DESC',
      },
    });
    let filteredUsers = users.filter(
      (user) => !user.role.includes(Role.STUDENT),
    );
    if (user.role.includes(Role.MANAGER)) {
      filteredUsers = filteredUsers.filter(
        (user) => !user.role.includes(Role.ADMIN),
      );
    }
    return filteredUsers;
  }

  async findById(id: number, queryParams?: DynamicDto): Promise<User> {
    const {
      select = {},
      where = {},
      relations = {},
    } = queryParams?.query || {};
    const user = await this.userRepo.findOne({
      select: select,
      where: { id, ...where },
      relations: relations,
    });
    if (!user) {
      throw new NotFoundException('User not found');
    }
    return user;
  }

  async update(id: number, updateUserDto: UpdateUserDto): Promise<User> {
    const user = await this.findById(id);
    if (user.email !== updateUserDto.email) {
      const existingUser = await this.userRepo.findOne({
        where: { email: updateUserDto.email },
      });
      if (existingUser) {
        throw new HttpException('User already exists', HttpStatus.CONFLICT);
      }
      user.email = updateUserDto.email;
      const password = generator.generate({ length: 12 });
      user.password = await bcrypt.hash(password, 10);
      this.mailService.sendWelcomeEmail({
        to: updateUserDto.email,
        subject: 'Welcome to the application',
        text: `${password}`,
      });
      this.userRepo.merge(user, updateUserDto);
      await this.userRepo.save(user);
    } else {
      this.userRepo.merge(user, updateUserDto);
      await this.userRepo.save(user);
    }
    return user;
  }

  async delete(id: string): Promise<any> {
    return await this.userRepo.softDelete(id);
  }
}
