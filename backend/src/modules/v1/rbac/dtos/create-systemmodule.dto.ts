import { ApiProperty } from '@nestjs/swagger';
import { IsString, IsNotEmpty } from 'class-validator';

export class CreateSystemmoduleDto {
  @ApiProperty()
  @IsString()
  @IsNotEmpty()
  name: string;
}
