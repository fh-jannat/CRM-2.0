import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty } from 'class-validator';

export class UpdateRBACDto {
  @ApiProperty({
    required: true,
    example: 'Batman',
  })
  @IsNotEmpty({
    message: 'RBAC cannot be empty or whitespace',
  })
  readonly RBAC?: string;
}
