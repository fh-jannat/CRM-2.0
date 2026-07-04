import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { ILike, Repository } from 'typeorm';
import { Task } from '../entities/task.entity';
import { CreateTaskDto, UpdateTaskDto, DynamicDto } from '../dtos';
import { UserCurdService } from '../../user/providers';
import { Role } from '@/modules/enums/role.enum';
import { NotificationGeneralService } from '../../notification/providers';

@Injectable()
export class TaskCrudService {
  constructor(
    @InjectRepository(Task)
    private taskRepository: Repository<Task>,
    private readonly userCurdService: UserCurdService,
    private readonly notificationService: NotificationGeneralService,
  ) {}

  async count(queryParams: DynamicDto, user): Promise<number> {
    const { where = {} } = queryParams?.query || {};
    const whereBuilder = {};
    for (const key in where) {
      if (key == 'status' && where['status'] !== '') {
        whereBuilder[key] = where[key];
      }
      if (key == 'fullName' && where['fullName'] !== '') {
        whereBuilder['assigned'] = {};
        whereBuilder['assigned'].fullName = ILike(`%${where[key]}%`);
      }
      if (key == 'branchName' && where['branchName'] !== '') {
        whereBuilder['assigned'] = {};
        whereBuilder['assigned'].branchName = ILike(`%${where[key]}%`);
      }
    }
    if (user) {
      if (
        !user.role?.includes(Role.ADMIN) &&
        !user.role?.includes(Role.MANAGER)
      ) {
        whereBuilder['assigned'] = {};
        whereBuilder['assigned'].id = user.id;
      }
      if (user.role?.includes(Role.MANAGER)) {
        whereBuilder['assigned'] = {};
        whereBuilder['assigned'].branchName = user.branchName;
      }
    }
    const count = await this.taskRepository.count({ where: whereBuilder });
    return count;
  }

  async create(createTaskDto: CreateTaskDto, user): Promise<Task> {
    const assigned = await this.userCurdService.findById(
      createTaskDto.assigned,
    );
    const task = this.taskRepository.create({
      task: createTaskDto.task,
      assigned: assigned,
      status: createTaskDto.status,
      endDate: createTaskDto.endDate,
      startDate: createTaskDto.startDate,
      description: createTaskDto.description,
    });
    await this.notificationService.createNotification(
      assigned.id,
      `${user.fullName} 'assigned you a new task '`,
      'tasks',
    );
    return this.taskRepository.save(task);
  }

  async findAll(queryParams: DynamicDto, user): Promise<Task[]> {
    const {
      select = {},
      where = {},
      page = 1,
      limit = 10,
    } = queryParams?.query || {};
    const skip = ((page > 1 ? page : 1) - 1) * (limit > 0 ? limit : 1);
    const whereBuilder = {};
    for (const key in where) {
      if (key == 'status' && where['status'] !== '') {
        whereBuilder[key] = where[key];
      }
      if (key == 'fullName' && where['fullName'] !== '') {
        whereBuilder['assigned'] = {};
        whereBuilder['assigned'].fullName = ILike(`%${where[key]}%`);
      }
      if (key == 'branchName' && where['branchName'] !== '') {
        whereBuilder['assigned'] = {};
        whereBuilder['assigned'].branchName = ILike(`%${where[key]}%`);
      }
    }
    if (user) {
      if (
        !user.role?.includes(Role.ADMIN) &&
        !user.role?.includes(Role.MANAGER)
      ) {
        whereBuilder['assigned'] = {};
        whereBuilder['assigned'].id = user.id;
      }
      if (user.role?.includes(Role.MANAGER)) {
        whereBuilder['assigned'] = {};
        whereBuilder['assigned'].branchName = user.branchName;
      }
    }
    return this.taskRepository.find({
      select: select,
      where: whereBuilder,
      relations: {
        assigned: true,
      },
      skip: skip,
      take: limit,
      order: { createdAt: 'DESC' },
    });
  }

  async findOne(id: number, queryParams?: DynamicDto): Promise<Task> {
    const {
      select = {},
      where = {},
      relations = {},
    } = queryParams?.query || {};
    return this.taskRepository.findOne({
      select: select,
      where: { id: id, ...where },
      relations: relations,
    });
  }
  async update(id: number, updateTaskDto: UpdateTaskDto): Promise<Task> {
    const task = await this.findOne(id);
    const assigned = await this.userCurdService.findById(
      updateTaskDto.assigned,
    );
    task.task = updateTaskDto.task;
    task.assigned = assigned;
    task.status = updateTaskDto.status;
    task.endDate = updateTaskDto.endDate;
    task.startDate = updateTaskDto.startDate;
    task.description = updateTaskDto.description;
    return this.taskRepository.save(task);
  }

  async remove(id: number): Promise<Task> {
    const task = await this.findOne(id);
    await this.taskRepository.remove(task);
    return task;
  }
}
