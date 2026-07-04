import { Module } from '@nestjs/common';
import * as providers from './providers';
import * as controller from './controllers';
import { TypeOrmModule } from '@nestjs/typeorm';
import { LeadModule } from '../lead/lead.module';
// import { UniversityModule } from '../university/university.module';
import { Coachingclass } from './entity';
@Module({
  imports: [TypeOrmModule.forFeature([Coachingclass]), LeadModule],
  providers: Object.values(providers),
  controllers: Object.values(controller),
  exports: [],
})
export class CoachingclassModule {}
