import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsString } from 'class-validator';

export class CreateLeadDocumentDto {
  @ApiProperty({ example: '1' })
  @IsNotEmpty()
  @IsString()
  docName: string;

  @ApiProperty({ example: 'link' })
  @IsNotEmpty()
  @IsString()
  link: string;
}
