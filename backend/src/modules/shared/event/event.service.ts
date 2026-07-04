import { Injectable } from '@nestjs/common';
import { EventTriggeredEvent } from './dtos/event-triggered.event';
import { ActivityEvent } from './entities/activity.entity';
import { ILike, Repository } from 'typeorm';
import { InjectRepository } from '@nestjs/typeorm';
import { DynamicDto } from './dtos/dynamic.dto';
import { Role } from '@/modules/enums/role.enum';

@Injectable()
export class EventHandlerService {
  constructor(
    @InjectRepository(ActivityEvent)
    private readonly activityRepo: Repository<ActivityEvent>,
  ) {}

  async createActivity(event: EventTriggeredEvent) {
    const tempActivity = {
      eventId: event.eventId,
      role: event.payload.role,
      user: event.payload.user,
      details: event.payload.details,
      branch: event.payload.branch,
    };
    const createdActivity = await this.activityRepo.create(tempActivity);
    await this.activityRepo.save(createdActivity);
  }

  async findAll(queryParams: DynamicDto, user: any) {
    const { where = {}, page = 1, limit = 10 } = queryParams?.query || {};
    const skip = ((page > 1 ? page : 1) - 1) * (limit > 0 ? limit : 1);
    const whereBuilder = {};

    for (const key in where) {
      if (key == 'id' && where['id'] !== '') {
        whereBuilder['user.id'] = where[key];
      }
      if (key == 'role' && where['role'] !== '') {
        whereBuilder[key] = ILike(`${where[key]}`);
      }
      if (key == 'branch' && where['branch'] !== '') {
        whereBuilder[key] = ILike(`${where[key]}`);
      }
    }

    if (
      user.role.includes(Role.ADMIN) == false &&
      user.role.includes(Role.MANAGER) == true
    ) {
      whereBuilder['branch'] = ILike(`${user.branchName}`);
    }
    if (
      user.role.includes(Role.ADMIN) == false &&
      user.role.includes(Role.MANAGER) == false
    ) {
      whereBuilder['user.id'] = `${user.id}`;
    }

    const activities = await this.activityRepo.find({
      where: whereBuilder,
      select: {
        user: {
          fullName: true,
        },
      },
      relations: {
        user: true,
      },
      skip: skip,
      take: limit,
      order: {
        createdAt: 'DESC',
      },
    });
    const count = await this.activityRepo.count({
      where: whereBuilder,
    });
    return { data: activities, count };
  }
}
