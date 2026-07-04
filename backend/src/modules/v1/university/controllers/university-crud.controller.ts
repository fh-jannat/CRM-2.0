import {
  Body,
  Controller,
  Delete,
  Get,
  InternalServerErrorException,
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
import { UniversityCrudService } from '../providers';
import {
  CreateUniversityDto,
  UpdateUniversityDto,
  DynamicDto,
  CreateUniversitiesDto,
} from '../dtos';
import { University } from '../entities/university.entity';
import { ParseBoolPipe } from '@/common/pipe';
import { AccessTokenGuard, RoleGuard } from '@/modules/shared/auth/guards';
import { HasRoles } from '@/common/decorator/roles.decorator';
import { Role } from '@/modules/enums/role.enum';

@ApiTags('v1/university')
@Controller({ path: 'university', version: '1' })
@ApiBearerAuth()
@UseGuards(AccessTokenGuard, RoleGuard)
@HasRoles(
  Role.ADMIN,
  Role.APPLICATION,
  Role.COMPLIANCE,
  Role.COUNSELLOR,
  Role.MANAGER,
  Role.STUDENT,
  Role.USER,
)
export class UniversityController {
  constructor(private readonly universityService: UniversityCrudService) {}

  @Get('count')
  @ApiOperation({ summary: 'Get total university count' })
  @ApiQuery({ type: DynamicDto })
  @UsePipes(new ParseBoolPipe())
  async count(@Query() queryParams: DynamicDto): Promise<number> {
    return await this.universityService.count(queryParams);
  }

  @Post('seed')
  @ApiOperation({ summary: 'seed universities' })
  @ApiBody({ type: CreateUniversitiesDto })
  seed(
    @Body() createUniversitiesDto: CreateUniversitiesDto,
  ): Promise<University[]> {
    try {
      return this.universityService.seed(createUniversitiesDto);
    } catch (e) {
      throw new InternalServerErrorException(e);
    }
  }

  @Post()
  @ApiOperation({ summary: 'Create a new university' })
  @ApiBody({ type: CreateUniversityDto })
  create(
    @Body() createUniversityDto: CreateUniversityDto,
  ): Promise<University> {
    return this.universityService.create(createUniversityDto);
  }

  @Get('options')
  @ApiOperation({ summary: 'Get all university option' })
  async options() {
    return this.universityService.options();
  }

  @Get()
  @ApiOperation({ summary: 'Get all university' })
  @ApiQuery({ type: DynamicDto })
  @UsePipes(new ParseBoolPipe())
  async findAll(@Query() queryParams: DynamicDto): Promise<University[]> {
    return this.universityService.findAll(queryParams);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get university by ID' })
  @ApiParam({ name: 'id', description: 'University ID' })
  @ApiQuery({ type: DynamicDto })
  @UsePipes(new ParseBoolPipe())
  findOne(
    @Param('id') id: number,
    @Query() queryParams: DynamicDto,
  ): Promise<University> {
    return this.universityService.findOne(id, queryParams);
  }

  @Put(':id')
  @ApiOperation({ summary: 'Update university by ID' })
  @ApiParam({ name: 'id', description: 'University ID' })
  @ApiBody({ type: UpdateUniversityDto })
  update(
    @Param('id') id: number,
    @Body() updateUniversityDto: UpdateUniversityDto,
  ): Promise<University> {
    return this.universityService.update(id, updateUniversityDto);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete university by ID' })
  @ApiParam({ name: 'id', description: 'University ID' })
  remove(@Param('id') id: number): Promise<University> {
    return this.universityService.remove(id);
  }
}
