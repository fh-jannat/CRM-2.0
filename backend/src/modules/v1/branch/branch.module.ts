import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import * as providers from './providers';
import * as controller from './controllers';
import { Branch } from './entities';

@Module({
  imports: [TypeOrmModule.forFeature([Branch])],
  providers: Object.values(providers),
  controllers: Object.values(controller),
  exports: [providers.BranchCrudService],
})
export class BranchModule {}
