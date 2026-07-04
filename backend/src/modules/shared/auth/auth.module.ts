import { Module } from '@nestjs/common';
import * as controllers from './controllers';
import * as providers from './providers';
import { JwtModule } from '@nestjs/jwt';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { JwtAuthStrategy } from './strategies';
import { MailsenderModule } from '@/modules/shared/mailsender';
import { UserModule } from '@/modules/v1/user/user.module';
import { EventHandlerModule } from '../event/event.module';

@Module({
  imports: [
    UserModule,
    MailsenderModule,
    EventHandlerModule,
    JwtModule.registerAsync({
      imports: [ConfigModule],
      inject: [ConfigService],
      useFactory: async (configService: ConfigService) => ({
        secret: configService.get('JWT_ACCESS_SECRET_KEY'),
        signOptions: {
          expiresIn: configService.get('JWT_ACCESS_EXPIRATION_TIME'),
        },
      }),
    }),
  ],
  controllers: Object.values(controllers),
  providers: [...Object.values(providers), JwtAuthStrategy],
  exports: Object.values(providers),
})
export class AuthModule {}
