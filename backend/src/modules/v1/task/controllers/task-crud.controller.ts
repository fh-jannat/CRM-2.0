import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Post,
  Put,
  Query,
  UseGuards,
  UsePipes,
} from '@nestjs/common';
import {
  ApiBearerAuth,
  ApiBody,
  ApiOperation,
  ApiParam,
  ApiQuery,
  ApiTags,
} from '@nestjs/swagger';
import { TaskCrudService } from '../providers';
import { CreateTaskDto, UpdateTaskDto, DynamicDto } from '../dtos';
import { Task } from '../entities/task.entity';
import { ParseBoolPipe } from '@/common/pipe';
import { AccessTokenGuard, RoleGuard } from '@/modules/shared/auth/guards';
import { HasRoles } from '@/common/decorator/roles.decorator';
import { Role } from '@/modules/enums/role.enum';
import { User } from '@/common/decorator/user.decorator';

@ApiTags('v1/task')
@Controller({ path: 'task', version: '1' })
@ApiBearerAuth()
@UseGuards(AccessTokenGuard, RoleGuard)
@HasRoles(
  Role.ADMIN,
  Role.APPLICATION,
  Role.COMPLIANCE,
  Role.COUNSELLOR,
  Role.MANAGER,
  Role.TEACHER,
  Role.STUDENT,
  Role.USER,
)
export class UniversityController {
  constructor(private readonly universityService: TaskCrudService) {}

  @Get('count')
  @ApiOperation({ summary: 'Get total university count' })
  @ApiQuery({ type: DynamicDto })
  @UsePipes(new ParseBoolPipe())
  async count(@Query() queryParams: DynamicDto, @User() user): Promise<number> {
    return await this.universityService.count(queryParams, user);
  }

  @Post()
  @ApiOperation({ summary: 'Create a new university' })
  @ApiBody({ type: CreateTaskDto })
  create(
    @Body() createUniversityDto: CreateTaskDto,
    @User() user,
  ): Promise<Task> {
    return this.universityService.create(createUniversityDto, user);
  }

  @Get()
  @ApiOperation({ summary: 'Get all university' })
  @ApiQuery({ type: DynamicDto })
  @UsePipes(new ParseBoolPipe())
  async findAll(
    @Query() queryParams: DynamicDto,
    @User() user,
  ): Promise<Task[]> {
    return this.universityService.findAll(queryParams, user);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get university by ID' })
  @ApiParam({ name: 'id', description: 'University ID' })
  @ApiQuery({ type: DynamicDto })
  @UsePipes(new ParseBoolPipe())
  findOne(
    @Param('id') id: number,
    @Query() queryParams: DynamicDto,
  ): Promise<Task> {
    return this.universityService.findOne(id, queryParams);
  }

  @Put(':id')
  @ApiOperation({ summary: 'Update university by ID' })
  @ApiParam({ name: 'id', description: 'University ID' })
  @ApiBody({ type: UpdateTaskDto })
  update(
    @Param('id') id: number,
    @Body() updateUniversityDto: UpdateTaskDto,
  ): Promise<Task> {
    return this.universityService.update(id, updateUniversityDto);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete university by ID' })
  @ApiParam({ name: 'id', description: 'University ID' })
  remove(@Param('id') id: number): Promise<Task> {
    return this.universityService.remove(id);
  }
}
