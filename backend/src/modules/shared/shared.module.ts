import { Module } from '@nestjs/common';
import { MailsenderModule } from './mailsender/mailsender.module';
// import { MiniostorageModule } from './miniostorage/miniostorage.module';
// import { RediscacheModule } from './rediscache/rediscache.module';
import { AuthModule } from './auth/auth.module';
import { DatabaseModule } from './database/database.module';
import { RealtimeModule } from './realtime/realtime.module';
import { ImageModule } from './image/image.module';
import { EventHandlerModule } from './event/event.module';

@Module({
  imports: [
    MailsenderModule,
    AuthModule,
    ImageModule,
    DatabaseModule,
    RealtimeModule /*MiniostorageModule*/ /*RediscacheModule*/,
    EventHandlerModule,
  ],
})
export class SharedModule {}
