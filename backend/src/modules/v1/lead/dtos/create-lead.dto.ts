import { ApiProperty } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import {
  IsNotEmpty,
  IsNumber,
  IsObject,
  IsOptional,
  IsString,
  ValidateNested,
} from 'class-validator';
import {
  EnglishProficiencyResult,
  LastEducationDto,
  PrevEducationDto,
} from '../entity';
import { CreateLeadApplicationDto } from './create-lead-application.dto';
import { CreateLeadDocumentDto } from './create-lead-document.dto';

export class CreateLeadDto {
  @ApiProperty({ example: 'Mohsin Ibna Amin' })
  @IsNotEmpty({ message: 'fullName can not be empty' })
  @IsString()
  fullName: string;

  @ApiProperty({ example: 'mohsinamin953@gmail.com' })
  @IsNotEmpty({ message: 'email can not be empty' })
  @IsString()
  email: string;

  @ApiProperty({ example: '01534115844' })
  @IsOptional()
  @IsString()
  phoneNo: string;

  @ApiProperty({ required: false, example: 'country' })
  @IsOptional()
  @IsString()
  country?: string;

  @ApiProperty({ required: false, example: 'country' })
  @IsOptional()
  @IsString()
  interestedCountry?: string;

  @ApiProperty({ required: false, example: 'state' })
  @IsOptional()
  @IsString()
  state?: string;

  @ApiProperty({ required: false, example: 'Dhaka' })
  @IsOptional()
  @IsString()
  addressDetails?: string;

  // educational information
  @ApiProperty({
    required: false,
    type: Array,
    example: [{ name: 'abc', year: 2020, result: 'GPA-5.00' }],
  })
  @IsOptional()
  previousEducations?: PrevEducationDto[];

  @ApiProperty({
    required: false,
    type: Object,
    example: {
      degree: 'BSc',
      institute: 'DU',
      country: 'Bangladesh',
      year: '2020',
      result: 'GPA-5.00',
      month: 'details',
    },
  })
  @IsOptional()
  lastEducation?: LastEducationDto;

  // english proficiency
  @ApiProperty({ required: false })
  @IsOptional()
  @IsString()
  englishProficiency?: string;

  @ApiProperty({ type: Object, required: false })
  @IsOptional()
  @IsObject()
  englishProficiencyResult?: EnglishProficiencyResult;

  @ApiProperty({ example: 'Course' })
  @IsOptional()
  @IsString()
  purpose: string;

  @ApiProperty({ required: false })
  @IsOptional()
  @IsString()
  stage?: string;

  @ApiProperty({ required: false })
  @IsOptional()
  @IsString()
  subStage?: string;

  @ApiProperty({ required: false })
  @IsOptional()
  classes?: boolean[];

  @ApiProperty({ required: false })
  @IsOptional()
  exams?: boolean[];

  @ApiProperty({ required: false })
  @IsOptional()
  @IsNumber()
  assignedTo?: number;

  @ApiProperty({ required: false })
  @IsOptional()
  @IsString()
  branchName?: string;

  @ApiProperty({ required: false })
  @IsOptional()
  @IsString()
  source?: string;

  @ApiProperty({ required: false })
  @IsOptional()
  @IsString()
  remark: string;

  @ApiProperty({ required: false, type: [CreateLeadApplicationDto] })
  @IsOptional()
  @ValidateNested({ each: true })
  @Type(() => CreateLeadApplicationDto)
  applications: CreateLeadApplicationDto[];

  @ApiProperty({ required: false, type: [CreateLeadDocumentDto] })
  @IsOptional()
  @ValidateNested({ each: true })
  @Type(() => CreateLeadDocumentDto)
  documents: CreateLeadDocumentDto[];
}
