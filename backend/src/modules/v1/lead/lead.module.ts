import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import * as providers from './providers';
import * as controller from './controllers';
import { UserModule } from '../user';
import { Lead } from '@/entities';
import { LeadDocumentModule } from '../leadDocument/leadDocument.module';
import { ApplicationModule } from '../application/application.module';
import { MailsenderModule } from '@/modules/shared/mailsender';
import { RemarkModule } from '../remark/remark.module';
import { RealtimeModule } from '@/modules/shared/realtime/realtime.module';
import { NotificationModule } from '../notification/notification.module';
import { StatusChangeModule } from '../status-change/status-change.module';
import { EventHandlerModule } from '@/modules/shared/event/event.module';
import { MulterModule } from '@nestjs/platform-express';
@Module({
  imports: [
    TypeOrmModule.forFeature([Lead]),
    UserModule,
    LeadDocumentModule,
    ApplicationModule,
    MailsenderModule,
    RemarkModule,
    RealtimeModule,
    NotificationModule,
    StatusChangeModule,
    EventHandlerModule,
    MulterModule.register({
      dest: './uploads',
    }),
  ],
  providers: Object.values(providers),
  controllers: Object.values(controller),
  exports: [providers.LeadCrudService, providers.LeadGeneralService],
})
export class LeadModule {}
