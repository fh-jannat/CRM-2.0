import { Role } from '@/modules/enums/role.enum';
import { ApiProperty, PartialType } from '@nestjs/swagger';
import { IsArray, IsEmail, IsOptional } from 'class-validator';
import { CreateUserDto } from './create-user.dto';

export class UpdateUserDto extends PartialType(CreateUserDto) {
  @ApiProperty({
    required: false,
    example: 'Mohsin',
  })
  @IsOptional({
    message: 'Name cannot be empty or whitespace',
  })
  readonly name?: string;

  @ApiProperty({
    required: false,
    example: 'mohsinamin953@gmail.com',
  })
  @IsOptional({
    message: 'Email cannot be empty or whitespace',
  })
  @IsEmail(
    {},
    {
      message: 'Email should be email',
    },
  )
  readonly email?: string;

  @ApiProperty({
    required: true,
    example: '01534115844',
  })
  @IsOptional()
  readonly phoneNumber?: string;

  @ApiProperty({
    required: true,
    example: 'active',
  })
  @IsOptional()
  readonly status?: string;

  @ApiProperty({ enum: Role, default: [Role.USER] })
  @IsOptional()
  @IsArray()
  role: Role[];
}
