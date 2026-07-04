import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsNumber, IsString } from 'class-validator';

export class CreateApplicationDto {
  @ApiProperty({ example: '1' })
  @IsNotEmpty()
  @IsString()
  intakeMonth: string;

  @ApiProperty({ example: '1' })
  @IsNotEmpty()
  @IsString()
  applicationStatus: string;

  @ApiProperty({ example: '1990' })
  @IsNotEmpty()
  @IsString()
  intakeYear: string;

  @ApiProperty({ example: 1 })
  @IsNotEmpty()
  @IsNumber()
  universityId: number;

  @ApiProperty({ example: 'course label' })
  @IsNotEmpty()
  @IsString()
  courseLabel: string;

  @ApiProperty({ example: 'course label' })
  @IsNotEmpty()
  @IsString()
  courseDetails: string;
}
