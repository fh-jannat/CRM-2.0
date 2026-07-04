import { Role } from '@/modules/enums/role.enum';
import { ApiProperty } from '@nestjs/swagger';
import {
  IsArray,
  IsEmail,
  IsNotEmpty,
  IsOptional,
  Length,
  NotContains,
} from 'class-validator';

export class CreateUserDto {
  @ApiProperty({
    required: true,
    example: 'Mohsin',
  })
  @IsNotEmpty({
    message: 'Name cannot be empty or whitespace',
  })
  readonly fullName: string;

  @ApiProperty({
    required: true,
    example: 'mohsinamin953@gmail.com',
  })
  @IsNotEmpty({
    message: 'Email cannot be empty or whitespace',
  })
  @IsEmail(
    {},
    {
      message: 'Email should be email',
    },
  )
  readonly email: string;

  @ApiProperty({
    required: true,
    example: '01534115844',
  })
  @IsOptional()
  readonly phoneNumber?: string;

  @ApiProperty({
    required: true,
    example: 'Dhaka',
  })
  @IsOptional()
  readonly branchName?: string;

  @ApiProperty({
    required: true,
    example: '123456',
  })
  @IsOptional()
  @NotContains(' ', {
    message: 'Password cannot be empty or whitespace',
  })
  @Length(6, 100, {
    message: 'Password must be between 6 and 100 characters long',
  })
  password?: string;

  @ApiProperty({
    required: true,
    example: 'active',
  })
  @IsOptional()
  readonly status?: string;

  @ApiProperty({
    required: true,
    example: 'Google',
  })
  @IsOptional()
  readonly provider?: string;

  @ApiProperty({
    required: true,
    example: 'local',
  })
  @IsOptional()
  readonly providerId?: string;

  @ApiProperty({ enum: Role, default: [Role.USER] })
  @IsOptional()
  @IsArray()
  role: Role[];
}
