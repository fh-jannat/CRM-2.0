import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsString } from 'class-validator';

export class UpdateLeadStage {
  @ApiProperty({ example: '1' })
  @IsNotEmpty()
  @IsString()
  stage: string;

  @ApiProperty({ example: 'link' })
  @IsNotEmpty()
  @IsString()
  subStage: string;
}
