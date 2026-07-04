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
import { CoachingclassCrudService } from '../providers';
import { Coachingclass } from '../entity/coachingclass.entity';
import {
  ApiBearerAuth,
  ApiBody,
  ApiOperation,
  ApiParam,
  ApiQuery,
  ApiTags,
} from '@nestjs/swagger';
import { CreateCoachingclassDto, UpdateCoachingclassDto } from '../dtos';

import { DynamicDto } from '../dtos/dynamic.dto';
import { ParseBoolPipe } from '@/common/pipe';

import { AccessTokenGuard, RoleGuard } from '@/modules/shared/auth/guards';
import { HasRoles } from '@/common/decorator/roles.decorator';
import { Role } from '@/modules/enums/role.enum';

@ApiTags('v1/coachingclass')
@Controller({ path: 'coachingclass', version: '1' })
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
export class CoachingclassCrudController {
  constructor(
    private readonly coachingclassService: CoachingclassCrudService,
  ) {}

  @Get()
  @ApiOperation({ summary: 'Get all coachingclass' })
  @ApiQuery({ type: DynamicDto })
  @UsePipes(new ParseBoolPipe())
  async findAll(@Query() queryParams: DynamicDto): Promise<Coachingclass[]> {
    return await this.coachingclassService.findAll(queryParams);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get coachingclass by ID' })
  @ApiParam({ name: 'id', description: 'coachingclass ID' })
  async findById(@Param('id') id: string): Promise<Coachingclass> {
    const coachingclass = await this.coachingclassService.findById(+id);
    if (!coachingclass) {
      throw new NotFoundException('coachingclass not found');
    }
    return coachingclass;
  }

  @Post()
  @ApiOperation({ summary: 'Create a new coachingclass' })
  @ApiBody({ type: CreateCoachingclassDto })
  async create(
    @Body() createCoachingclassDto: CreateCoachingclassDto,
  ): Promise<Coachingclass> {
    return await this.coachingclassService.create(createCoachingclassDto);
  }

  @Put(':id')
  @ApiOperation({ summary: 'Update coachingclass by ID' })
  @ApiParam({ name: 'id', description: 'coachingclass ID' })
  @ApiBody({ type: UpdateCoachingclassDto })
  async update(
    @Param('id') id: string,
    @Body() updateCoachingclassDto: UpdateCoachingclassDto,
  ): Promise<Coachingclass> {
    const updatedCoachingclass = await this.coachingclassService.update(
      +id,
      updateCoachingclassDto,
    );
    if (!updatedCoachingclass) {
      throw new NotFoundException('coachingclass not found');
    }
    return updatedCoachingclass;
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete coachingclass by ID' })
  @ApiParam({ name: 'id', description: 'coachingclass ID' })
  async delete(@Param('id') id: string): Promise<Coachingclass> {
    const deletedCoachingclass = await this.coachingclassService.delete(+id);
    if (!deletedCoachingclass) {
      throw new NotFoundException('coachingclass not found');
    }
    return deletedCoachingclass;
  }
}
