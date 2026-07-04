import { Controller, Get, UseGuards, UsePipes } from '@nestjs/common';
import {
  ApiBearerAuth,
  ApiOperation,
  ApiResponse,
  ApiTags,
} from '@nestjs/swagger';

import { ParseBoolPipe } from '@/common/pipe';
import { AccessTokenGuard, RoleGuard } from '@/modules/shared/auth/guards';
import { HasRoles } from '@/common/decorator/roles.decorator';
import { Role } from '@/modules/enums/role.enum';

import { StatGeneralService } from '../providers';
import { StatResponseDto } from '../dtos';

@ApiTags('v1/stat')
@Controller({ path: 'stat', version: '1' })
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
export class StatController {
  constructor(private readonly StatService: StatGeneralService) {}

  @Get()
  @ApiOperation({ summary: 'Get all Stat' })
  @ApiResponse({
    status: 200,
    description: 'Successful response',
    type: StatResponseDto,
  })
  @UsePipes(new ParseBoolPipe())
  async findAll() {
    const data = await this.StatService.prepStat();
    return { success: true, data: data };
  }
}
