import { Controller, Get, Query, UseGuards, UsePipes } from '@nestjs/common';
import {
  ApiBearerAuth,
  ApiOperation,
  ApiQuery,
  ApiTags,
} from '@nestjs/swagger';
import { KpiGeneralService } from '../providers';
import { KpiDto, LeadStageWiseDto } from '../dtos';

import { ParseBoolPipe } from '@/common/pipe';
import { AccessTokenGuard, RoleGuard } from '@/modules/shared/auth/guards';
import { HasRoles } from '@/common/decorator/roles.decorator';
import { Role } from '@/modules/enums/role.enum';

@ApiTags('v1/kpi')
@Controller({ path: 'kpi', version: '1' })
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
export class KpiGeneralController {
  constructor(private readonly kpiService: KpiGeneralService) {}

  @Get('report/total-lead-info')
  @ApiOperation({ summary: 'Get all company wide lead info' })
  @ApiQuery({ type: KpiDto })
  @UsePipes(new ParseBoolPipe())
  async getCompanyWideLeadInfo(): Promise<any> {
    return this.kpiService.getCompanyWideLeadInfo();
  }

  @Get('report/conversion-trend-history')
  @ApiOperation({ summary: 'Get historical converasion rate trends' })
  @ApiQuery({ type: KpiDto })
  @UsePipes(new ParseBoolPipe())
  async getTrends(@Query() queryParam: KpiDto): Promise<any> {
    return this.kpiService.getConversionTrends(queryParam);
  }

  @Get('report/stage-wise-counts')
  @ApiOperation({ summary: 'Get stage wise counts of leads' })
  @ApiQuery({ type: LeadStageWiseDto })
  @UsePipes(new ParseBoolPipe())
  async getStageWiseLeadCount(
    @Query() queryParam: LeadStageWiseDto,
  ): Promise<any> {
    return this.kpiService.getStageWiseLeadCounts(queryParam);
  }
}
