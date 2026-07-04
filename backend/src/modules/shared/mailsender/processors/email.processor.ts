import { MailerService } from '@nestjs-modules/mailer';
import {
  OnQueueActive,
  OnQueueCompleted,
  OnQueueFailed,
  Process,
  Processor,
} from '@nestjs/bull';
import { Job } from 'bull';
import { Mail } from '../dtos';
import { Logger } from '@nestjs/common';

@Processor('email')
export class EmailProcessor {
  private readonly logger = new Logger(this.constructor.name);

  constructor(private readonly mailService: MailerService) {
    this.logger.log('EmailProcessor');
  }

  @OnQueueActive()
  onActive(job: Job) {
    this.logger.debug(
      `Processing job ${job.id} of type ${job.name}. Data: ${JSON.stringify(
        job.data,
      )}`,
    );
  }

  @OnQueueCompleted()
  onComplete(job: Job, result: any) {
    this.logger.debug(
      `Completed job ${job.id} of type ${job.name}. Result: ${JSON.stringify(
        result,
      )}`,
    );
  }

  @OnQueueFailed()
  onError(job: Job<any>, error: any) {
    this.logger.error(
      `Failed job ${job.id} of type ${job.name}: ${error.message}`,
      error.stack,
    );
  }

  @Process('sendmail')
  async sendEmail(job: Job<Mail>) {
    const { data } = job.data;
    await this.mailService.sendMail({
      ...data,
      template: 'send-email',
      context: {
        text: data.text,
      },
    });
  }

  @Process('welcome')
  async sendWelcomeEmail(job: Job<Mail>) {
    const { data } = job.data;
    await this.mailService.sendMail({
      ...data,
      template: 'welcome',
      context: {
        user: data.user,
        text: data.text,
      },
    });
  }

  @Process('verify-email')
  async sendVerifyEmail(job: Job<Mail>) {
    const { data } = job.data;

    await this.mailService.sendMail({
      ...data,

      template: 'verify-email',
      context: {
        user: data.user,
        text: data.text,
      },
    });
    return { jobId: job.id };
  }

  @Process('reset-password')
  async sendResetPasswordEmail(job: Job<Mail>) {
    const { data } = job.data;

    await this.mailService.sendMail({
      ...data,
      template: 'reset-password',
      context: {
        user: data.user,
        text: data.text,
      },
    });
  }

  @Process('test-mail')
  async changeCreds(job: Job<Mail>) {
    const { data } = job.data;

    await this.mailService.sendMail({
      ...data,
      template: 'welcome',
      transporterName: data.transporterName,

      context: {
        user: data.user,
        text: data.text,
      },
    });
    return { jobId: job.id };
  }
}
