import { Module } from '@nestjs/common';
import * as providers from './providers';
import * as controller from './controllers';
import { Application } from './entity';
import { TypeOrmModule } from '@nestjs/typeorm';
import { UniversityModule } from '../university/university.module';

import { Lead } from '../lead/entity';
@Module({
  imports: [TypeOrmModule.forFeature([Application, Lead]), UniversityModule],
  providers: Object.values(providers),
  controllers: Object.values(controller),
  exports: [providers.ApplicationCrudService],
})
export class ApplicationModule {}
