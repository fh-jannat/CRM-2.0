import { Controller, Get, Query, UseGuards, UsePipes } from '@nestjs/common';

import {
  ApiBearerAuth,
  ApiOperation,
  ApiQuery,
  ApiTags,
} from '@nestjs/swagger';
import { EventHandlerService } from '../event.service';
import { DynamicDto } from '../dtos/dynamic.dto';
import { ParseBoolPipe } from '@/common/pipe';
import { AccessTokenGuard, RoleGuard } from '@/modules/shared/auth/guards';
import { HasRoles } from '@/common/decorator/roles.decorator';
import { Role } from '@/modules/enums/role.enum';
import { User } from '@/common/decorator/user.decorator';
@ApiTags('v1/activity')
@Controller({ path: 'activity', version: '1' })
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
export class EventHandlerController {
  constructor(private readonly activityService: EventHandlerService) {}

  @Get()
  @ApiOperation({ summary: 'Get all lead' })
  @ApiQuery({ type: DynamicDto })
  @UsePipes(new ParseBoolPipe())
  async findAll(@User() user: any, @Query() queryParams: DynamicDto) {
    return await this.activityService.findAll(queryParams, user);
  }
}
