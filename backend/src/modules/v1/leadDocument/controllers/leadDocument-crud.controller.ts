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
import { LeadDocumentCrudService } from '../providers';
import { LeadDocument } from '../entity';
import {
  ApiBearerAuth,
  ApiBody,
  ApiOperation,
  ApiParam,
  ApiTags,
} from '@nestjs/swagger';
import { CreateLeadDocumentDto, UpdateLeadDocumentDto } from '../dtos';

import { AccessTokenGuard, RoleGuard } from '@/modules/shared/auth/guards';
import { HasRoles } from '@/common/decorator/roles.decorator';
import { Role } from '@/modules/enums/role.enum';

@ApiTags('v1/document')
@Controller({ path: 'document', version: '1' })
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
export class LeadDocumentCrudController {
  constructor(private readonly applicationService: LeadDocumentCrudService) {}

  @Get()
  @ApiOperation({ summary: 'Get all application' })
  async findAll(): Promise<LeadDocument[]> {
    return await this.applicationService.findAll();
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get application by ID' })
  @ApiParam({ name: 'id', description: 'application ID' })
  async findById(@Param('id') id: string): Promise<LeadDocument> {
    const application = await this.applicationService.findById(+id);
    if (!application) {
      throw new NotFoundException('application not found');
    }
    return application;
  }

  @Post()
  @ApiOperation({ summary: 'Create a new application' })
  @ApiBody({ type: CreateLeadDocumentDto })
  async create(
    @Body() createLeadDocumentDto: CreateLeadDocumentDto,
  ): Promise<LeadDocument> {
    return await this.applicationService.create(createLeadDocumentDto);
  }

  @Put(':id')
  @ApiOperation({ summary: 'Update application by ID' })
  @ApiParam({ name: 'id', description: 'application ID' })
  @ApiBody({ type: UpdateLeadDocumentDto })
  async update(
    @Param('id') id: string,
    @Body() updateLeadDocumentDto: UpdateLeadDocumentDto,
  ): Promise<LeadDocument> {
    const updatedLeadDocument = await this.applicationService.update(
      +id,
      updateLeadDocumentDto,
    );
    if (!updatedLeadDocument) {
      throw new NotFoundException('application not found');
    }
    return updatedLeadDocument;
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete application by ID' })
  @ApiParam({ name: 'id', description: 'application ID' })
  async delete(@Param('id') id: string): Promise<LeadDocument> {
    const deletedLeadDocument = await this.applicationService.delete(+id);
    if (!deletedLeadDocument) {
      throw new NotFoundException('application not found');
    }
    return deletedLeadDocument;
  }
}
