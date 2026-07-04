import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Notification } from '../entity/notification.entity';
import { DynamicDto } from '../dtos/dynamic.dto';

@Injectable()
export class NotificationGeneralService {
  constructor(
    @InjectRepository(Notification)
    private notificationRepository: Repository<Notification>,
  ) {}

  async createNotification(
    userId: number,
    message: string,
    url?: string,
  ): Promise<Notification> {
    const notification = this.notificationRepository.create({
      userId,
      message,
      url,
    });
    return this.notificationRepository.save(notification);
  }

  async findAll(
    queryParams: DynamicDto,
    userId: number,
  ): Promise<Notification[]> {
    const {
      select = {},
      where = {},
      relations = {},
      page = 1,
      limit = 10,
    } = queryParams?.query || {};
    const skip = ((page > 1 ? page : 1) - 1) * (limit > 0 ? limit : 1);
    return this.notificationRepository.find({
      select: select,
      where: { ...where, userId: userId },
      relations: relations,
      skip: skip,
      take: limit,
      order: { createdAt: 'DESC' },
    });
  }

  async count(queryParams: DynamicDto, userId: number) {
    const { where = {} } = queryParams?.query || {};
    return this.notificationRepository.count({
      where: { ...where, userId: userId },
    });
  }

  async countUnread(userId: number) {
    return this.notificationRepository.count({
      where: { userId: userId, isRead: false },
    });
  }

  async findAllUnread(userId: number): Promise<Notification[]> {
    return this.notificationRepository.find({
      where: { userId: userId, isRead: false },
    });
  }

  async markAsRead(id: number): Promise<Notification> {
    const notification = await this.notificationRepository.findOneBy({ id });
    if (notification) {
      notification.isRead = true;
      return this.notificationRepository.save(notification);
    }
    return null;
  }
}
