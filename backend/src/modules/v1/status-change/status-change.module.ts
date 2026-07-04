import { Module } from '@nestjs/common';
import { StatusChangeService } from './providers/status-change.service';
import * as providers from './providers';
import * as controller from './controllers';
import { TypeOrmModule } from '@nestjs/typeorm';
import { StatusChange } from './entity';

@Module({
  imports: [TypeOrmModule.forFeature([StatusChange])],
  providers: Object.values(providers),
  controllers: Object.values(controller),
  exports: [StatusChangeService],
})
export class StatusChangeModule {}
