import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsString } from 'class-validator';

export class UpdateUniversityDto {
  @ApiProperty({ example: 'University of Dhaka' })
  @IsNotEmpty()
  @IsString()
  universityName: string;

  @ApiProperty({ example: 'Bangladesh' })
  @IsNotEmpty()
  @IsString()
  country: string;
}
