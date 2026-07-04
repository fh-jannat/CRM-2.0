import { Module } from '@nestjs/common';
import * as providers from './providers';
import * as controller from './controllers';
import { LeadDocument } from './entity';
import { TypeOrmModule } from '@nestjs/typeorm';
@Module({
  imports: [TypeOrmModule.forFeature([LeadDocument])],
  providers: Object.values(providers),
  controllers: Object.values(controller),
  exports: [providers.LeadDocumentCrudService],
})
export class LeadDocumentModule {}
