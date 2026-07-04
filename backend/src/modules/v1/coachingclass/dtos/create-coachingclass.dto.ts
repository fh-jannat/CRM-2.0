import { ApiProperty } from '@nestjs/swagger';
import {
  IsBoolean,
  IsDateString,
  IsNotEmpty,
  IsNumber,
  IsOptional,
} from 'class-validator';

export class CreateCoachingclassDto {
  @ApiProperty({
    required: true,
    example: 'name field',
  })
  @IsNotEmpty({
    message: 'coachingclass field cannot be empty or whitespace',
  })
  readonly name: string;

  @ApiProperty({
    required: true,
    example: 'Mock',
  })
  @IsNotEmpty({
    message: ' typeof coaching cannot be empty or whitespace',
  })
  readonly cType: string;

  @ApiProperty({
    required: false,
    example: '2011-10-05T14:48:00.000Z',
  })
  @IsDateString()
  @IsOptional()
  readonly classDate: Date;

  @ApiProperty({
    required: false,
    example: false,
    default: false,
  })
  @IsBoolean()
  @IsOptional()
  isPresent: boolean;

  @ApiProperty({
    required: false,
    example: 1,
  })
  @IsNumber()
  @IsOptional()
  leadId: number;
}
