import { ApiProperty } from '@nestjs/swagger';
import { IsOptional } from 'class-validator';

export class DynamicDto {
  @ApiProperty({
    required: false,
    example: {
      query: {
        startDate: '2024-3-12',
        endDate: '2024-6-10',
        initiatorId: 1,
      },
    },
  })
  @IsOptional()
  query: any;
}
