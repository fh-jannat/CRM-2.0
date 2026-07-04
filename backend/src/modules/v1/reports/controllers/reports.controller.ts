import { Controller, Get, Query } from '@nestjs/common';
import { ReportsService } from '../providers/reports.service';
import { ApiOperation, ApiQuery, ApiTags } from '@nestjs/swagger';
import { Lead } from '../../lead/entity';
import { DynamicDto } from '../../leadDocument/dtos';

@ApiTags('v1/reports')
@Controller('reports')
export class ReportsController {
  constructor(private readonly reportsService: ReportsService) {}
  @Get('lead')
  @ApiOperation({ summary: 'Get data for all lead report' })
  @ApiQuery({ type: DynamicDto })
  async getLeadReport(@Query() queryParams: DynamicDto): Promise<Lead[]> {
    return await this.reportsService.getLeadReport(queryParams);
  }
  @Get('admission')
  @ApiOperation({ summary: 'Get data for all admissions' })
  @ApiQuery({ type: DynamicDto })
  async getAdmissionReport(@Query() queryParams: DynamicDto): Promise<Lead[]> {
    return await this.reportsService.getAdmissionReport(queryParams);
  }

  @Get('student')
  @ApiOperation({ summary: 'Get data for all students' })
  @ApiQuery({ type: DynamicDto })
  async getStudentReport(@Query() queryParams: DynamicDto): Promise<Lead[]> {
    return await this.reportsService.getAdmissionReport(queryParams);
  }
}
