import { ApiProperty } from '@nestjs/swagger';
import { Type } from 'class-transformer';

export class StatDto {
  @ApiProperty({ example: 23 })
  Lead: number;
  @ApiProperty({ example: 23 })
  Admission: number;
  @ApiProperty({ example: 23 })
  VisaCompliance: number;
  @ApiProperty({ example: 23 })
  Student: number;
}

export class StatResponseDto {
  @ApiProperty({ example: true })
  success: boolean;

  @ApiProperty()
  @Type(() => StatDto)
  data: StatDto;
}
