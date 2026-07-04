import {
  HttpException,
  HttpStatus,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { User } from '../entity/user.entity';
import { CreateUserDto, UpdateUserDto } from '../dtos';
import { UserCurdService } from './user-curd.service';
import { Providers } from '@/common/enums';
import { Role } from '@/modules/enums/role.enum';

@Injectable()
export class UserGeneralService {
  constructor(
    @InjectRepository(User)
    private readonly userRepository: Repository<User>,
    private readonly userService: UserCurdService,
  ) {}

  async findUserByEmail(email: string): Promise<User> {
    return await this.userRepository.findOne({ where: { email } });
  }

  async countAdminUser(): Promise<any> {
    return await this.userRepository.count({
      where: { role: Role.ADMIN },
    });
  }

  async createAdminUser(user: CreateUserDto): Promise<User> {
    const userTemp = this.userRepository.create({
      fullName: user.fullName,
      isVerified: true,
      email: user.email,
      password: user.password,
      provider: Providers.Local,
      status: 'active',
      role: [Role.ADMIN],
    });
    return await this.userRepository.save(userTemp);
  }

  async findUserById(id: number): Promise<User> {
    return await this.userRepository.findOne({
      where: { id },
    });
  }

  async findUserByIdPassword(id: number): Promise<User> {
    return await this.userRepository.findOne({
      where: { id },
      select: ['id', 'fullName', 'email'],
    });
  }

  async registerUser(user: CreateUserDto): Promise<User> {
    const existingUser = await this.findUserByEmail(user.email);
    if (existingUser) {
      throw new HttpException('User already registered', HttpStatus.CONFLICT);
    }
    return await this.userService.create(user);
  }

  async updateUser(id: number, user: UpdateUserDto): Promise<User> {
    const existingUser = await this.findUserById(+id);
    if (!existingUser) {
      throw new NotFoundException('User not found');
    }
    return await this.userService.update(id, user);
  }

  // async assignRole(roleId: number, userId: number): Promise<User> {
  //   let role = await this.rbacService.findById(roleId);
  //   let user
  // }
}
