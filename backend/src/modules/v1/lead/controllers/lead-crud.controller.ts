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
import { LeadCrudService } from '../providers';
import { Lead } from '../entity/lead.entity';
import {
  ApiBearerAuth,
  ApiBody,
  ApiOperation,
  ApiParam,
  ApiQuery,
  ApiTags,
} from '@nestjs/swagger';
import { CreateLeadDto, UpdateLeadDto } from '../dtos';
import { DynamicDto } from '../dtos/dynamic.dto';
import { ParseBoolPipe } from '@/common/pipe';

import { AccessTokenGuard, RoleGuard } from '@/modules/shared/auth/guards';
import { HasRoles } from '@/common/decorator/roles.decorator';
import { Role } from '@/modules/enums/role.enum';
import { User } from '@/common/decorator/user.decorator';
import { ResendAuthMailDto } from '../dtos/resendAuthMail.dto';
import { UpdateLeadStage } from '../dtos/update-lead-stage.dto';

@ApiTags('v1/lead')
@Controller({ path: 'lead', version: '1' })
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
export class LeadCrudController {
  constructor(private readonly leadService: LeadCrudService) {}

  @Get('count')
  @ApiOperation({ summary: 'Get all lead count' })
  @ApiQuery({ type: DynamicDto })
  @UsePipes(new ParseBoolPipe())
  async count(@Query() queryParams: DynamicDto, @User() user): Promise<number> {
    return await this.leadService.count(queryParams, user);
  }

  @Post('resend')
  @ApiOperation({ summary: 'Resend email' })
  @ApiBody({ type: ResendAuthMailDto })
  async resendMail(
    @Body() resendAuthMailDto: ResendAuthMailDto,
  ): Promise<Lead> {
    return await this.leadService.resendEmail(resendAuthMailDto.leadId);
  }

  @Post()
  @ApiOperation({ summary: 'Create a new lead' })
  @ApiBody({ type: CreateLeadDto })
  async create(
    @Body() createLeadDto: CreateLeadDto,
    @User() user: any,
  ): Promise<Lead> {
    return await this.leadService.create(createLeadDto, user);
  }

  @Get()
  @ApiOperation({ summary: 'Get all lead' })
  @ApiQuery({ type: DynamicDto })
  @UsePipes(new ParseBoolPipe())
  async findAll(
    @Query() queryParams: DynamicDto,
    @User() user,
  ): Promise<Lead[]> {
    return await this.leadService.findAll(queryParams, user);
  }

  @Get('student')
  @ApiOperation({ summary: 'Get lead by ID' })
  async leadDetailsForStudent(@User() user: any): Promise<Lead> {
    const lead = await this.leadService.leadDetailsForStudent(user);
    return lead;
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get lead by ID' })
  @ApiQuery({ type: DynamicDto })
  @UsePipes(new ParseBoolPipe())
  @ApiParam({ name: 'id', description: 'lead ID' })
  async findById(
    @Query() queryParams: DynamicDto,
    @Param('id') id: string,
  ): Promise<Lead> {
    const lead = await this.leadService.findById(+id, queryParams);
    return lead;
  }

  @Put('stagechange/:id')
  @ApiOperation({ summary: 'Update lead by ID' })
  @ApiParam({ name: 'id', description: 'lead ID' })
  @ApiBody({ type: UpdateLeadStage })
  async updateStageSubstage(
    @Param('id') id: string,
    @Body() updateLeadDto: UpdateLeadStage,
  ) {
    return await this.leadService.updateStageSubstage(+id, updateLeadDto);
  }

  @Put(':id')
  @ApiOperation({ summary: 'Update lead by ID' })
  @ApiParam({ name: 'id', description: 'lead ID' })
  @ApiBody({ type: UpdateLeadDto })
  async update(
    @Param('id') id: string,
    @Body() updateLeadDto: UpdateLeadDto,
    @User() user: any,
  ): Promise<Lead> {
    const updatedLead = await this.leadService.update(+id, updateLeadDto, user);
    if (!updatedLead) {
      throw new NotFoundException('lead not found');
    }
    return updatedLead;
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete lead by ID' })
  @ApiParam({ name: 'id', description: 'lead ID' })
  async delete(@Param('id') id: string): Promise<Lead> {
    const deletedLead = await this.leadService.delete(+id);
    if (!deletedLead) {
      throw new NotFoundException('lead not found');
    }
    return deletedLead;
  }
}
