import { Module } from '@nestjs/common';

import * as providers from './providers';
import * as controller from './controllers';
import { TypeOrmModule } from '@nestjs/typeorm';
import { User } from './entity/user.entity';
import { MailsenderModule } from '@/modules/shared/mailsender';

@Module({
  imports: [TypeOrmModule.forFeature([User]), MailsenderModule],
  providers: Object.values(providers),
  controllers: Object.values(controller),
  exports: [providers.UserGeneralService, providers.UserCurdService],
})
export class UserModule {}
