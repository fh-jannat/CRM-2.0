import { Module } from '@nestjs/common';

import * as providers from './providers';
import * as controllers from './controllers';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Notification } from './entity/notification.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Notification])],
  controllers: Object.values(controllers),
  providers: Object.values(providers),
  exports: [providers.NotificationGeneralService],
})
export class NotificationModule {}
