import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import * as providers from './providers';
import * as controller from './controllers';
import { Kpi } from './entities';
import { LeadModule } from '../lead/lead.module';
import { StatusChangeModule } from '../status-change/status-change.module';

@Module({
  imports: [TypeOrmModule.forFeature([Kpi]), LeadModule, StatusChangeModule],
  providers: Object.values(providers),
  controllers: Object.values(controller),
  exports: [],
})
export class KpiModule {}
