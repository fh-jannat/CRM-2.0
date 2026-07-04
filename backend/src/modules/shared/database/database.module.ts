import { Module } from '@nestjs/common';
// import { MongooseModule } from './mongoose/mongoose.module';
// import { TypeOrmModule1 } from './typeorm1/typeorm.module';

@Module({
  imports: [],
  exports: [DatabaseModule],
})
export class DatabaseModule {}
