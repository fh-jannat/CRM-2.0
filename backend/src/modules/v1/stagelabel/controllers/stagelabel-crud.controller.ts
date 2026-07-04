import { Body, Controller, Get, Param, Put } from '@nestjs/common';
import { ApiBody, ApiOperation, ApiParam, ApiTags } from '@nestjs/swagger';
import { StagelabelCrudService } from '../providers';
import { SubStagelabel } from '../entities/substagelabel.entity';
import { UpdateStagelabelDto } from '../dtos';

@ApiTags('v1/stagelabel')
@Controller({ path: 'stagelabel', version: '1' })
export class StagelabelController {
  constructor(private readonly stagelabelService: StagelabelCrudService) {}

  @Get('seed')
  @ApiOperation({ description: 'Seed data' })
  seed() {
    return this.stagelabelService.seed();
  }

  @Get()
  @ApiOperation({ summary: 'Get all' })
  getAll() {
    return this.stagelabelService.getAll();
  }

  @Get('label/:stage/:label')
  @ApiOperation({ summary: 'Get' })
  @ApiParam({ name: 'label', description: 'label' })
  @ApiParam({ name: 'stage', description: 'stage' })
  findOne(@Param('label') label: string, @Param('stage') stage: string) {
    return this.stagelabelService.getSubStage(label, stage);
  }

  @Get('option/:stage')
  @ApiOperation({ summary: 'Get' })
  @ApiParam({ name: 'stage', description: 'stage' })
  findOption(@Param('stage') stage: string) {
    return this.stagelabelService.buildOption(stage);
  }

  @Get('menu/:stage')
  @ApiOperation({ summary: 'Get' })
  @ApiParam({ name: 'stage', description: 'stage' })
  findMenu(@Param('stage') stage: string) {
    return this.stagelabelService.buildMenu(stage);
  }

  @Put('label')
  @ApiOperation({ summary: 'Update' })
  @ApiBody({ type: SubStagelabel })
  update(@Body() updateStagelabelDto: UpdateStagelabelDto) {
    return this.stagelabelService.updateSubStage(updateStagelabelDto);
  }
}
