import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsNumber, IsOptional, IsString } from 'class-validator';

export class CreateLeadApplicationDto {
  @ApiProperty({ example: 23 })
  @IsOptional()
  @IsNumber()
  id: number;

  @ApiProperty({ example: '1' })
  @IsOptional()
  @IsString()
  applicationStatus: string;

  @ApiProperty({ example: '1' })
  @IsNotEmpty()
  @IsString()
  intakeMonth: string;

  @ApiProperty({ example: '1990' })
  @IsNotEmpty()
  @IsString()
  intakeYear: string;

  @ApiProperty({ example: 1 })
  @IsNotEmpty()
  @IsNumber()
  universityId: number;

  @ApiProperty({ example: 'course label' })
  @IsOptional()
  @IsString()
  courseLabel: string;

  @ApiProperty({ example: 'course label' })
  @IsNotEmpty()
  @IsString()
  courseDetails: string;
}
