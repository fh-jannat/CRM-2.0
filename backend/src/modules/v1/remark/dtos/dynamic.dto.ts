import { ApiProperty } from '@nestjs/swagger';
import { IsOptional } from 'class-validator';

export class DynamicDto {
  @ApiProperty({
    required: false,
    example: {
      query: {
        select: { universityName: true },
        where: { country: 'Bangladesh' },
        page: 1,
        limit: 10,
      },
    },
  })
  @IsOptional()
  query: any;
}
