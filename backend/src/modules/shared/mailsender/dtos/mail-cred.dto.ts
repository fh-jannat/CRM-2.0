import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty } from 'class-validator';

export class CreateMailCredDTO {
  @ApiProperty({ example: 'asd' })
  @IsNotEmpty({
    message: 'Host cannot be empty or whitespace',
  })
  smtpHost: string;

  @ApiProperty({ example: 'asd' })
  @IsNotEmpty({
    message: 'Port cannot be empty or whitespace',
  })
  smtpPort: string;

  @ApiProperty({ example: 'asd' })
  @IsNotEmpty({
    message: 'User mail cannot be empty or whitespace',
  })
  @ApiProperty({ example: 'asd' })
  @IsNotEmpty({
    message: 'From mail cannot be empty or whitespace',
  })
  smtpFrom: string;

  @ApiProperty({ example: 'asd' })
  @IsNotEmpty({
    message: 'User mail cannot be empty or whitespace',
  })
  @ApiProperty({ example: 'asd' })
  @IsNotEmpty({
    message: 'From mail cannot be empty or whitespace',
  })
  smtpUser: string;

  @ApiProperty({ example: 'asd' })
  @IsNotEmpty({
    message: 'password cannot be empty or whitespace',
  })
  smtpPassword: string;
}
