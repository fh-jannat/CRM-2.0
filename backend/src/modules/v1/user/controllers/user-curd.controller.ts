import {
  Body,
  Controller,
  Delete,
  Get,
  NotFoundException,
  Param,
  Post,
  Put,
  Query,
  UseGuards,
  UsePipes,
} from '@nestjs/common';
import { UserCurdService } from '../providers';

import {
  ApiBearerAuth,
  ApiBody,
  ApiOperation,
  ApiParam,
  ApiQuery,
  ApiTags,
} from '@nestjs/swagger';
import { CreateUserDto, UpdateUserDto } from '../dtos';
import { DynamicDto } from '../dtos/dynamic.dto';
import { ParseBoolPipe } from '@/common/pipe';
import { User as UserEntity } from '../entity';
import { AccessTokenGuard, RoleGuard } from '@/modules/shared/auth/guards';
import { HasRoles } from '@/common/decorator/roles.decorator';
import { Role } from '@/modules/enums/role.enum';
import { User } from '@/common/decorator/user.decorator';

@ApiTags('v1/user')
@Controller({ path: 'user', version: '1' })
@ApiBearerAuth()
@UseGuards(AccessTokenGuard, RoleGuard)
@HasRoles(
  Role.ADMIN,
  Role.APPLICATION,
  Role.COMPLIANCE,
  Role.COUNSELLOR,
  Role.MANAGER,
  Role.STUDENT,
  Role.TEACHER,
  Role.USER,
)
export class UserCurdController {
  constructor(private readonly userService: UserCurdService) {}

  @Get('count')
  @ApiOperation({ summary: 'Get total users count' })
  @ApiQuery({ type: DynamicDto })
  @UsePipes(new ParseBoolPipe())
  async count(@Query() queryParams: DynamicDto): Promise<number> {
    return await this.userService.count(queryParams);
  }

  @Get('role-option')
  async getRoleOption(
    @Query('stage') stage: string,
    @Query('branchSpecificApplication') branchSpecificApplication: boolean,
    @User() user: UserEntity,
  ) {
    return await this.userService.getRoleOption(
      user,
      stage,
      branchSpecificApplication,
    );
  }

  @Post()
  @ApiOperation({ summary: 'Create a new user' })
  @ApiBody({ type: CreateUserDto })
  async create(@Body() createUserDto: CreateUserDto): Promise<UserEntity> {
    return await this.userService.create(createUserDto);
  }

  @Get()
  @ApiOperation({ summary: 'Get all users' })
  @ApiQuery({ type: DynamicDto })
  @UsePipes(new ParseBoolPipe())
  async findAll(
    @Query() queryParams: DynamicDto,
    @User() user: UserEntity,
  ): Promise<UserEntity[]> {
    return await this.userService.findAll(queryParams, user);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get user by ID' })
  @ApiParam({ name: 'id', description: 'User ID' })
  @ApiQuery({ type: DynamicDto })
  @UsePipes(new ParseBoolPipe())
  async findById(
    @Param('id') id: string,
    @Query() queryParams: DynamicDto,
  ): Promise<UserEntity> {
    const user = await this.userService.findById(+id, queryParams);
    if (!user) {
      throw new NotFoundException('User not found');
    }
    return user;
  }

  @Put(':id')
  @ApiOperation({ summary: 'Update user by ID' })
  @ApiParam({ name: 'id', description: 'User ID' })
  @ApiBody({ type: UpdateUserDto })
  async update(
    @Param('id') id: string,
    @Body() updateUserDto: UpdateUserDto,
  ): Promise<UserEntity> {
    const updatedUser = await this.userService.update(+id, updateUserDto);
    return updatedUser;
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete user by ID' })
  @ApiParam({ name: 'id', description: 'User ID' })
  async delete(@Param('id') id: string) {
    const deletedUser = await this.userService.delete(id);
    return deletedUser;
  }
}
