import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import * as providers from './providers';
import * as controller from './controllers';
import { University } from './entities';

@Module({
  imports: [TypeOrmModule.forFeature([University])],
  providers: Object.values(providers),
  controllers: Object.values(controller),
  exports: [providers.UniversityCrudService],
})
export class UniversityModule {}
