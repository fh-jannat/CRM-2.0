import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty } from 'class-validator';

export class CreateRBACDto {
  @ApiProperty({
    required: true,
    example: 'example RBAC field',
  })
  @IsNotEmpty({
    message: 'RBAC field cannot be empty or whitespace',
  })
  readonly name: string;
}
