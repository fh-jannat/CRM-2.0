import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import * as providers from './providers';
import * as controller from './controllers';
import { SubStagelabel } from './entities';

@Module({
  imports: [TypeOrmModule.forFeature([SubStagelabel])],
  providers: Object.values(providers),
  controllers: Object.values(controller),
  exports: [providers.StagelabelCrudService],
})
export class StagelabelModule {}
