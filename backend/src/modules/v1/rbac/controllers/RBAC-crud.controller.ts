import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Post,
  Put,
  Query,
  UsePipes,
} from '@nestjs/common';
import { RBACGeneralService } from '../providers';

import { ApiBody, ApiOperation, ApiQuery, ApiTags } from '@nestjs/swagger';

import { CreateSystemmoduleDto } from '../dtos/create-systemmodule.dto';
import { SystemModuleService } from '../providers/module-crud.service';
import { PermissionService } from '../providers/permission-crud.service';
import { AssignPermissionDto } from '../dtos/assign-permission.dto';
import { CreateRoleDto } from '../dtos/create-role.dto';
import { UpdateRoleDto } from '../dtos/update-role.dto';
import { DynamicDto } from '../dtos/dynamic.dto';
import { ParseBoolPipe } from '@/common/pipe';

@ApiTags('v1/rbac')
@Controller({ path: 'rbac', version: '1' })
export class RbacCrudController {
  constructor(
    private readonly rbacGenService: RBACGeneralService,
    private readonly systemModuleService: SystemModuleService,
    private readonly permissionService: PermissionService,
  ) {}

  @Post('roles/:roleId/permissions')
  assign(
    @Param('roleId') roleId: number,
    @Body() assignPermissionDto: AssignPermissionDto,
  ) {
    return this.rbacGenService.assignPermission(roleId, assignPermissionDto);
  }

  @Get('roles/:roleId/permissions')
  rolePermissions(@Param('roleId') roleId: number) {
    return this.rbacGenService.findAllPermissionsOfRole(roleId);
  }

  @Get('roles/count')
  count() {
    return this.rbacGenService.count();
  }

  @Post('roles')
  create(@Body() createRoleDto: CreateRoleDto) {
    console.log(createRoleDto);
    return this.rbacGenService.create(createRoleDto);
  }

  @Get('roles')
  @ApiOperation({ summary: 'Get all users' })
  @ApiQuery({ type: DynamicDto })
  @UsePipes(new ParseBoolPipe())
  findAll(@Query() queryParams: DynamicDto) {
    return this.rbacGenService.findAll(queryParams);
  }

  @Get('roles/:id')
  findOne(@Param('id') id: string) {
    return this.rbacGenService.findOne(+id);
  }

  @Put('roles/:id')
  update(@Param('id') id: string, @Body() updateRoleDto: UpdateRoleDto) {
    return this.rbacGenService.update(+id, updateRoleDto);
  }

  @Delete('roles/:id')
  remove(@Param('id') id: string) {
    return this.rbacGenService.remove(+id);
  }

  @Get('pair/init')
  init() {
    return this.rbacGenService.init();
  }

  @Get('pairs')
  getPair() {
    return this.rbacGenService.findAllPairs();
  }

  @Get('modules')
  findAllModules() {
    return this.systemModuleService.findAll();
  }

  @Post('modules')
  @ApiBody({ type: CreateSystemmoduleDto })
  createModule(@Body() createSystemmoduleDto: CreateSystemmoduleDto) {
    console.log(createSystemmoduleDto);
    return this.systemModuleService.create(createSystemmoduleDto);
  }

  @Get('permissions')
  findAllPerms() {
    return this.permissionService.findAll();
  }

  @Post('permissions')
  createPermission(@Body() createSystemmoduleDto: CreateSystemmoduleDto) {
    return this.permissionService.create(createSystemmoduleDto);
  }
}
