import { ApiProperty } from '@nestjs/swagger';
import { IsOptional } from 'class-validator';

export class SuccessReportResponseDto {
  @ApiProperty({
    required: false,
    example: {
      response: [
        {
          user: '4',
          sucessCount: 55,
        },
        {
          user: '5',
          sucessCount: 25,
        },
      ],
    },
  })
  @IsOptional()
  response: any;
}
