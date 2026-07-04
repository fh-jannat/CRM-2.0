import { Module } from '@nestjs/common';
import { RediscacheService } from './rediscache.service';

@Module({
  providers: [RediscacheService],
})
export class RediscacheModule {}
