import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty } from 'class-validator';

export class SendMailDTO {
  @ApiProperty({ example: 'asd' })
  @IsNotEmpty({
    message: 'email subject',
  })
  subject: string;

  @ApiProperty({ example: 'asd' })
  @IsNotEmpty({
    message: 'email body',
  })
  text: string;

  @ApiProperty({ example: 'asd' })
  @IsNotEmpty({
    message: 'To mail cannot be empty or whitespace',
  })
  to: string;
}
