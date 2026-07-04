import { ApiProperty } from '@nestjs/swagger';
import { IsOptional } from 'class-validator';

export class DynamicDto {
  @ApiProperty({
    required: false,
    example: {
      query: {
        where: {
          branch: 'dhanmondi',
          role: 'user',
          id: 1,
        },
        page: 1,
        limit: 10,
      },
    },
  })
  @IsOptional()
  query: any;
}
