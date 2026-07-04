import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsString } from 'class-validator';

export class UpdateStagelabelDto {
  @ApiProperty()
  @IsNotEmpty({ message: 'stage can not be empty' })
  @IsString()
  stage: string;

  @ApiProperty()
  @IsNotEmpty({ message: 'substage can not be empty' })
  @IsString()
  substage: string;

  @ApiProperty()
  @IsNotEmpty({ message: 'substagelabel can not be empty' })
  @IsString()
  substagelabel: string;
}
