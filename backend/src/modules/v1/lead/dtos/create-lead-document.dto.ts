import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsNumber, IsOptional, IsString } from 'class-validator';

export class CreateLeadDocumentDto {
  @ApiProperty({ example: 23 })
  @IsOptional()
  @IsNumber()
  id: number;

  @ApiProperty({ example: '1' })
  @IsNotEmpty()
  @IsString()
  docName: string;

  @ApiProperty({ example: 'link' })
  @IsNotEmpty()
  @IsString()
  link: string;
}
