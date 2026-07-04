import { ApiProperty } from '@nestjs/swagger';
import { IsOptional } from 'class-validator';

export class LeadStageWiseDto {
  @ApiProperty({
    required: false,
    example: {
      query: {
        branch: 'leave empty if you want to query for all branches',
        dayInterval:
          'how many previous days do you want the counts for. Leave empty if all. It should be a Integer datatype',
      },
    },
  })
  @IsOptional()
  query: any;
}
