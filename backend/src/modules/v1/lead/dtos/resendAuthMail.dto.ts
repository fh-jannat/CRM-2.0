import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsNumber } from 'class-validator';

export class ResendAuthMailDto {
  @ApiProperty()
  @IsNotEmpty()
  @IsNumber()
  leadId: number;
}
