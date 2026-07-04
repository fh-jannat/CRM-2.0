import { Injectable, Logger } from '@nestjs/common';
import { Mail } from './dtos';
import { InjectQueue } from '@nestjs/bull';
import { Queue } from 'bull';
import { MailerService } from '@nestjs-modules/mailer';
import { CreateMailCredDTO } from './dtos/mail-cred.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { MailCred } from './entities/mail-cred.entity';
import { Repository } from 'typeorm';
import { EncryptionService } from './encryption.service';
import { ConfigService } from '@nestjs/config';

@Injectable()
export class MailsenderService {
  logger = new Logger('RedisQueue');
  constructor(
    @InjectQueue('email') private emailQueue: Queue,
    private readonly mailerService: MailerService,
    @InjectRepository(MailCred) private credRepo: Repository<MailCred>,
    private encryptionService: EncryptionService,
    private configService: ConfigService,
  ) {
    this.init();
  }

  async init() {
    try {
      await this.delay(1000, 1);
      this.checkQueueAvailability();
      await this.changeCreds(false);
    } catch (e) {
      this.logger.error(e);
    }
  }

  private checkQueueAvailability(): void {
    if (this.emailQueue.client.status === 'ready') {
      this.logger.log('Redis is ready');
    } else {
      throw new Error('Redis not available');
    }
  }

  delay(t: number, val: any) {
    return new Promise(function (resolve) {
      setTimeout(function () {
        resolve(val);
      }, t);
    });
  }

  async sendWelcomeEmail(data: Mail) {
    const job = await this.emailQueue.add('welcome', { data });
    return { jobId: job.id };
  }

  async sendResetPasswordEmail(data: Mail) {
    const job = await this.emailQueue.add('reset-password', { data });
    return { jobId: job.id };
  }

  async sendEmail(data: Mail) {
    const job = await this.emailQueue.add('sendmail', { data });
    return { jobId: job.id };
  }

  async sendTestMail() {
    const data: Mail = {
      to: 'mohsinamin953@gmail.com',
      subject: 'Test mail',
      text: `jasdflkjlkdfjakljsdhf`,
      transporterName: 'test',
    };
    try {
      const job = await this.emailQueue.add('welcome', { data });
      return await job.finished();
    } catch (error) {
      throw new Error(error);
    }
  }

  async changeCreds(flag: boolean) {
    if (flag == true) {
      return await this.mailerService.addTransporter('test', {});
    } else {
      const creds = await this.getCreds();
      if (!creds) {
        return this.mailerService.addTransporter('test', {
          host: this.configService.get('SMTP_HOST'),
          port: +this.configService.get<number>('SMTP_PORT'),
          secure:
            this.configService.get('SMTP_SECURE') === 'true' ? true : false,
          from: this.configService.get('SMTP_MAIL_FROM'),
          auth: {
            user: this.configService.get('SMTP_USER'),
            pass: this.configService.get('SMTP_PASSWORD'),
          },
        });
      }
      return this.mailerService.addTransporter('test', {
        host: creds.smtpHost,
        port: creds.smtpPort,
        from: creds.smtpFrom,
        secure: creds.smtpPort === '465' ? true : false,
        auth: {
          user: creds.smtpUser,
          pass: creds.smtpPassword,
        },
      });
    }
  }

  async createCreds(createCreds: CreateMailCredDTO) {
    const existing = await this.getCreds();
    if (existing) {
      await this.deleteCreds();
    }
    const credTemp = await this.credRepo.create(createCreds);
    credTemp.smtpPassword = this.encryptionService.encrypt(
      credTemp.smtpPassword,
    );
    await this.credRepo.save(credTemp);
    await this.changeCreds(false);
    const res = await this.sendTestMail();
    if (res) return 'Created';
  }

  async deleteCreds() {
    const creds = await this.getCreds();
    if (creds != null) {
      await this.changeCreds(true);
      await this.credRepo.delete(creds.id);
    }
  }

  async getCreds() {
    const credsList = await this.credRepo.find();
    if (credsList.length == 0) {
      return null;
    }
    const creds = credsList[0];
    creds.smtpPassword = this.encryptionService.decrypt(creds.smtpPassword);
    return creds;
  }
}
