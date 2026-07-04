import { ApiBody, ApiOperation, ApiTags } from '@nestjs/swagger';
import { MailsenderService } from './mailsender.service';
import { Body, Controller, Delete, Get, Post } from '@nestjs/common';

import { CreateMailCredDTO } from './dtos/mail-cred.dto';
import { SendMailDTO } from './dtos/send-mail.dto';

@ApiTags('v1/mail')
@Controller({ path: 'mail', version: '1' })
export class MailSenderController {
  constructor(private readonly mailSenderService: MailsenderService) {}

  @Post('sendmail')
  @ApiOperation({ summary: 'send mail' })
  @ApiBody({ type: SendMailDTO })
  async sendmail(@Body() sendMailDto: SendMailDTO): Promise<any> {
    return await this.mailSenderService.sendEmail(sendMailDto);
  }

  @Post()
  @ApiOperation({ summary: 'provide smtp creds' })
  @ApiBody({ type: CreateMailCredDTO })
  async create(@Body() createMailDto: CreateMailCredDTO): Promise<any> {
    return await this.mailSenderService.createCreds(createMailDto);
  }

  @Get()
  @ApiOperation({ summary: 'check if creds are provided' })
  async get(): Promise<any> {
    return await this.mailSenderService.getCreds();
  }

  @Delete()
  @ApiOperation({ summary: 'delete creds' })
  async delete(): Promise<any> {
    return await this.mailSenderService.deleteCreds();
  }
  @Post('send')
  @ApiOperation({ summary: 'provide smtp creds' })
  @ApiBody({ type: CreateMailCredDTO })
  async send(@Body() createMailDto: CreateMailCredDTO): Promise<any> {
    console.log(createMailDto);
    return await this.mailSenderService.sendTestMail();
  }
}
