import { Module } from '@nestjs/common';
import { FacebookService } from './facebook.service';
import { FacebookController } from './facebook.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Facebook } from './entities/facebook.entity';

@Module({
  controllers: [FacebookController],
  providers: [FacebookService],
  imports: [TypeOrmModule.forFeature([Facebook])],
})
export class FacebookModule {}
