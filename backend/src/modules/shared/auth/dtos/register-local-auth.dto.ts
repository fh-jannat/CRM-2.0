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

export class CreateAuthDto {
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
    example: '123456',
  })
  @IsNotEmpty({
    message: 'Password cannot be empty or whitespace',
  })
  @NotContains(' ', {
    message: 'Password cannot be empty or whitespace',
  })
  @Length(6, 100, {
    message: 'Password must be between 6 and 100 characters long',
  })
  password: string;

  @ApiProperty({ enum: Role, default: [Role.USER] })
  @IsOptional()
  @IsArray()
  role: Role[];
}
