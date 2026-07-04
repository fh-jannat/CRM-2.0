import { Module } from '@nestjs/common';

import * as providers from './providers';
import * as controller from './controllers';
import { MulterModule } from '@nestjs/platform-express';

@Module({
  imports: [
    MulterModule.register({
      dest: './uploads',
    }),
  ],
  providers: Object.values(providers),
  controllers: Object.values(controller),
})
export class ImageModule {}
