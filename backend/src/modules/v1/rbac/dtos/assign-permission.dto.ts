import { ApiProperty } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import { IsOptional, ValidateNested } from 'class-validator';

export class AssignPermissionDto {
  @ApiProperty({ required: false })
  roleId: number;

  @ApiProperty({
    required: false,
  })
  @IsOptional()
  @ValidateNested({ each: true })
  @Type(() => ModulePermissionPairDto)
  pairs: ModulePermissionPairDto[];
}

export class AssignPermissionDto2 {
  @ApiProperty()
  roleId: number;

  @ApiProperty({
    example: [1, 2, 3],
  })
  read: number[];
  @ApiProperty({
    example: [1, 2, 3],
  })
  write: number[];
}

export class ModulePermissionPairDto {
  @ApiProperty({
    required: false,
  })
  @IsOptional()
  moduleId: number;

  @ApiProperty({
    required: false,
  })
  @IsOptional()
  permissionIds: number[];
}
