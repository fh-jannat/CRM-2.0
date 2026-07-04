import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import * as providers from './providers';
import * as controller from './controllers';
import { Remark } from './entities';

@Module({
  imports: [TypeOrmModule.forFeature([Remark])],
  providers: Object.values(providers),
  controllers: Object.values(controller),
  exports: [providers.RemarkCrudService],
})
export class RemarkModule {}
