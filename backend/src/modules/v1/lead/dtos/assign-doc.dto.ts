import { ApiProperty } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import {
  IsNotEmpty,
  IsNumber,
  IsOptional,
  ValidateNested,
} from 'class-validator';
import { CreateLeadDocumentDto } from './create-lead-document.dto';

export class assignDocDto {
  @ApiProperty()
  @IsNotEmpty()
  @IsNumber()
  leadId: number;

  @ApiProperty({ required: false })
  @IsOptional()
  @ValidateNested({ each: true })
  @Type(() => CreateLeadDocumentDto)
  leadDocs: CreateLeadDocumentDto[];
}
