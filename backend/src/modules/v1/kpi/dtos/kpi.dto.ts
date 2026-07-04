import { ApiProperty } from '@nestjs/swagger';
import { IsOptional } from 'class-validator';

export class KpiDto {
  @ApiProperty({
    required: false,
    example: {
      query: {
        branch: 'leave empty if you want to query for all branches',
      },
    },
  })
  @IsOptional()
  query: any;
}
