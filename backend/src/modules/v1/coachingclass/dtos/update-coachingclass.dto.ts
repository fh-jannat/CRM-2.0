import { ApiProperty } from '@nestjs/swagger';
import {
  IsBoolean,
  IsDate,
  IsNotEmpty,
  IsNumber,
  IsOptional,
} from 'class-validator';

export class UpdateCoachingclassDto {
  @ApiProperty({
    required: false,
    example: 'name field',
  })
  @IsNotEmpty({
    message: 'coachingclass field cannot be empty or whitespace',
  })
  readonly name: string;

  @ApiProperty({
    required: false,
    example: 'Mock',
  })
  @IsNotEmpty({
    message: ' typeof coaching cannot be empty or whitespace',
  })
  readonly cType: string;

  @ApiProperty({
    required: false,
    example: 'name field',
  })
  @IsDate()
  @IsOptional()
  readonly classDate: Date;

  @ApiProperty({
    required: false,
    example: false,
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
