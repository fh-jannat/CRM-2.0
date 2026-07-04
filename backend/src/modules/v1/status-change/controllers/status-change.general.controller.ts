import { Controller, Get, Post, Body, Param, Query } from '@nestjs/common';
import { ApiQuery, ApiTags } from '@nestjs/swagger';
import { StatusChangeService } from '../providers/status-change.service';
import { CreateStatusChangeDto } from '../dtos/create-status-change.dto';

import { DynamicDto } from '../dtos/dynamic.dto';

@ApiTags('v1/status-change')
@Controller('status-change')
export class StatusChangeController {
  constructor(private readonly statusChangeService: StatusChangeService) {}

  @Post()
  create(@Body() createStatusChangeDto: CreateStatusChangeDto) {
    return this.statusChangeService.create(createStatusChangeDto);
  }

  @Get('report')
  @ApiQuery({ type: DynamicDto })
  getReportData(@Query() queryParams: DynamicDto) {
    return this.statusChangeService.getLastOccurringLeadId(queryParams);
  }

  @Get('success')
  @ApiQuery({ type: DynamicDto })
  getSuccessData(@Query() queryParams: DynamicDto) {
    return this.statusChangeService.getSuccessCounts(queryParams);
  }

  @Get()
  findAll() {
    return this.statusChangeService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.statusChangeService.findOne(+id);
  }
}
