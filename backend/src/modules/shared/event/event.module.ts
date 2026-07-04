import { Module } from '@nestjs/common';

import { EventHandlerService } from './event.service';
import { ActivityEvent } from './entities/activity.entity';
import { TypeOrmModule } from '@nestjs/typeorm';
import { EventHandlerController } from './controller/event.controller';
@Module({
  imports: [TypeOrmModule.forFeature([ActivityEvent])],
  providers: [EventHandlerService],
  exports: [EventHandlerService],
  controllers: [EventHandlerController],
})
export class EventHandlerModule {}
