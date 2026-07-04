import { Module } from '@nestjs/common';
import * as providers from './providers';
import * as controller from './controllers';
import { Report } from './entities/report.entity';
import { TypeOrmModule } from '@nestjs/typeorm';
import { LeadModule } from '../lead/lead.module';

@Module({
  imports: [TypeOrmModule.forFeature([Report]), LeadModule],
  providers: Object.values(providers),
  controllers: Object.values(controller),
  exports: [providers.ReportsService],
})
export class ReportsModule {}
