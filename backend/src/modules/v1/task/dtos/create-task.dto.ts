import { ApiProperty } from '@nestjs/swagger';
import { IsOptional, IsString } from 'class-validator';

export class CreateTaskDto {
  @ApiProperty({
    description: 'The name of the task',
    example: 'Implement feature X',
    nullable: true,
  })
  @IsString()
  @IsOptional()
  task?: string;

  @ApiProperty({
    description: 'A brief description of the task',
    example: 'This task involves implementing feature X in the application.',
    nullable: true,
  })
  @IsString()
  @IsOptional()
  description?: string;

  @ApiProperty({
    description: 'The current status of the task',
    example: 'In Progress',
    nullable: true,
  })
  @IsString()
  @IsOptional()
  status?: string;

  @ApiProperty({
    description: 'The start date of the task',
    example: '2023-06-01T00:00:00.000Z',
    type: String,
    nullable: true,
  })
  @IsString()
  @IsOptional()
  startDate?: Date;

  @ApiProperty({
    description: 'The end date of the task',
    example: '2023-06-30T23:59:59.999Z',
    type: String,
    nullable: true,
  })
  @IsString()
  @IsOptional()
  endDate?: Date;

  @ApiProperty({
    description: 'The ID of the user to whom the task is assigned',
    example: '1',
    nullable: true,
  })
  @IsOptional()
  assigned?: number;
}
