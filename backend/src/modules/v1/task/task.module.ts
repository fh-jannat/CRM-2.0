import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import * as providers from './providers';
import * as controller from './controllers';
import { Task } from './entities';
import { UserModule } from '../user';
import { NotificationModule } from '../notification/notification.module';

@Module({
  imports: [TypeOrmModule.forFeature([Task]), UserModule, NotificationModule],
  providers: Object.values(providers),
  controllers: Object.values(controller),
  exports: [providers.TaskCrudService],
})
export class TaskModule {}
