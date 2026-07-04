import { Module } from '@nestjs/common';
import { UserModule } from './user/user.module';
import { RbacModule } from './rbac/rbac.module';
import { LeadModule } from './lead/lead.module';
import { UniversityModule } from './university/university.module';
import { ApplicationModule } from './application/application.module';
import { CoachingclassModule } from './coachingclass/coachingclass.module';
import { LeadDocumentModule } from './leadDocument/leadDocument.module';
import { CatsModule } from '../shared/cats/cats.module';
import { NotificationModule } from './notification/notification.module';
import { ReportsModule } from './reports/reports.module';
import { StatusChangeModule } from './status-change/status-change.module';
import { TaskModule } from './task/task.module';
import { FacebookModule } from './facebook/facebook.module';
import { BranchModule } from './branch/branch.module';
import { StatModule } from './stats/stat.module';
import { StagelabelModule } from './stagelabel/stagelabel.module';
import { KpiModule } from './kpi/kpi.module';

@Module({
  imports: [
    UserModule,
    RbacModule,
    LeadModule,
    LeadDocumentModule,
    UniversityModule,
    ApplicationModule,
    CoachingclassModule,
    CatsModule,
    NotificationModule,
    ReportsModule,
    StatusChangeModule,
    TaskModule,
    FacebookModule,
    BranchModule,
    StatModule,
    StagelabelModule,
    KpiModule,
  ],
})
export class V1Module {}
