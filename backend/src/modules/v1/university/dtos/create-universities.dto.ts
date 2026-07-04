import { ApiProperty } from '@nestjs/swagger';
import { CreateUniversityDto } from './create-university.dto';
import { IsArray, ValidateNested } from 'class-validator';
import { Type } from 'class-transformer';

export class CreateUniversitiesDto {
  @ApiProperty({
    type: [CreateUniversityDto],
    description: 'Array of universities',
  })
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => CreateUniversityDto)
  universities: CreateUniversityDto[];
}
