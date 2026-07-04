import { Module } from '@nestjs/common';
import { MailsenderService } from './mailsender.service';
import { MailerModule } from '@nestjs-modules/mailer';
import { HandlebarsAdapter } from '@nestjs-modules/mailer/dist/adapters/handlebars.adapter';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { BullModule } from '@nestjs/bull';
import { EmailProcessor } from './processors/email.processor';
import { MailSenderController } from './mailsender.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { MailCred } from './entities';
import { EncryptionService } from './encryption.service';

@Module({
  imports: [
    MailerModule.forRootAsync({
      imports: [ConfigModule],
      useFactory: async (configService: ConfigService) => ({
        transport: {
          host: configService.get('SMTP_HOST'),
          port: +configService.get<number>('SMTP_PORT'),
          secure: configService.get('SMTP_SECURE') === 'true' ? true : false,
          auth: {
            user: configService.get('SMTP_USER'),
            pass: configService.get('SMTP_PASSWORD'),
          },
        },
        defaults: {
          from: `"No Reply" <${configService.get('SMTP_MAIL_FROM')}>`,
        },
        template: {
          dir: __dirname + '/templates',
          adapter: new HandlebarsAdapter(),
        },
      }),
      inject: [ConfigService],
    }),
    BullModule.forRootAsync({
      imports: [ConfigModule],
      useFactory: async (configService: ConfigService) => ({
        redis: {
          host: configService.get('REDIS_HOST'),
          port: +configService.get<number>('REDIS_PORT'),
        },
      }),
      inject: [ConfigService],
    }),
    BullModule.registerQueue({
      name: 'email',
    }),
    TypeOrmModule.forFeature([MailCred]),
  ],
  providers: [MailsenderService, EncryptionService, EmailProcessor],
  controllers: [MailSenderController],
  exports: [MailsenderService],
})
export class MailsenderModule {}
