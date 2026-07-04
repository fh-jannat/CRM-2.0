import {
  Body,
  Controller,
  Delete,
  Get,
  NotFoundException,
  Param,
  Post,
  Put,
  UseGuards,
} from '@nestjs/common';
import { ApplicationCrudService } from '../providers';
import { Application } from '../entity/application.entity';
import {
  ApiBearerAuth,
  ApiBody,
  ApiOperation,
  ApiParam,
  ApiTags,
} from '@nestjs/swagger';
import { CreateApplicationDto, UpdateApplicationDto } from '../dtos';
import { AccessTokenGuard, RoleGuard } from '@/modules/shared/auth/guards';
import { HasRoles } from '@/common/decorator/roles.decorator';
import { Role } from '@/modules/enums/role.enum';

@ApiTags('v1/application')
@Controller({ path: 'application', version: '1' })
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
export class ApplicationCrudController {
  constructor(private readonly applicationService: ApplicationCrudService) {}

  @Get()
  @ApiOperation({ summary: 'Get all application' })
  async findAll(): Promise<Application[]> {
    return await this.applicationService.findAll();
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get application by ID' })
  @ApiParam({ name: 'id', description: 'application ID' })
  async findById(@Param('id') id: string): Promise<Application> {
    const application = await this.applicationService.findById(+id);
    if (!application) {
      throw new NotFoundException('application not found');
    }
    return application;
  }

  @Post()
  @ApiOperation({ summary: 'Create a new application' })
  @ApiBody({ type: CreateApplicationDto })
  async create(
    @Body() createApplicationDto: CreateApplicationDto,
  ): Promise<Application> {
    return await this.applicationService.create(createApplicationDto);
  }

  @Put(':id')
  @ApiOperation({ summary: 'Update application by ID' })
  @ApiParam({ name: 'id', description: 'application ID' })
  @ApiBody({ type: UpdateApplicationDto })
  async update(
    @Param('id') id: string,
    @Body() updateApplicationDto: UpdateApplicationDto,
  ): Promise<Application> {
    const updatedApplication = await this.applicationService.update(
      +id,
      updateApplicationDto,
    );
    if (!updatedApplication) {
      throw new NotFoundException('application not found');
    }
    return updatedApplication;
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete application by ID' })
  @ApiParam({ name: 'id', description: 'application ID' })
  async delete(@Param('id') id: string): Promise<Application> {
    const deletedApplication = await this.applicationService.delete(+id);
    if (!deletedApplication) {
      throw new NotFoundException('application not found');
    }
    return deletedApplication;
  }
}
