import { Module } from '@nestjs/common';

import * as providers from './providers';
import * as controller from './controllers';
import { LeadModule } from '../lead/lead.module';

@Module({
  imports: [LeadModule],
  providers: Object.values(providers),
  controllers: Object.values(controller),
  exports: [providers.StatGeneralService],
})
export class StatModule {}
