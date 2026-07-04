import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Post,
  Put,
  Query,
  UseGuards,
  UsePipes,
} from '@nestjs/common';
import {
  ApiBearerAuth,
  ApiBody,
  ApiOperation,
  ApiParam,
  ApiQuery,
  ApiTags,
} from '@nestjs/swagger';
import { BranchCrudService } from '../providers';
import { CreateBranchDto, UpdateBranchDto, DynamicDto } from '../dtos';
import { Branch } from '../entities/branch.entity';
import { ParseBoolPipe } from '@/common/pipe';
import { AccessTokenGuard, RoleGuard } from '@/modules/shared/auth/guards';
import { HasRoles } from '@/common/decorator/roles.decorator';
import { Role } from '@/modules/enums/role.enum';

@ApiTags('v1/branch')
@Controller({ path: 'branch', version: '1' })
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
export class BranchController {
  constructor(private readonly branchService: BranchCrudService) {}

  @Get('count')
  @ApiOperation({ summary: 'Get total branch count' })
  @ApiQuery({ type: DynamicDto })
  @UsePipes(new ParseBoolPipe())
  async count(@Query() queryParams: DynamicDto): Promise<number> {
    return await this.branchService.count(queryParams);
  }

  @Get('option')
  @ApiOperation({ summary: 'Get all branch option' })
  async options() {
    return await this.branchService.options();
  }

  @Post()
  @ApiOperation({ summary: 'Create a new branch' })
  @ApiBody({ type: CreateBranchDto })
  create(@Body() createBranchDto: CreateBranchDto): Promise<Branch> {
    return this.branchService.create(createBranchDto);
  }

  @Get()
  @ApiOperation({ summary: 'Get all branch' })
  @ApiQuery({ type: DynamicDto })
  @UsePipes(new ParseBoolPipe())
  async findAll(@Query() queryParams: DynamicDto): Promise<Branch[]> {
    return this.branchService.findAll(queryParams);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get branch by ID' })
  @ApiParam({ name: 'id', description: 'Branch ID' })
  @ApiQuery({ type: DynamicDto })
  @UsePipes(new ParseBoolPipe())
  findOne(
    @Param('id') id: number,
    @Query() queryParams: DynamicDto,
  ): Promise<Branch> {
    return this.branchService.findOne(id, queryParams);
  }

  @Put(':id')
  @ApiOperation({ summary: 'Update branch by ID' })
  @ApiParam({ name: 'id', description: 'Branch ID' })
  @ApiBody({ type: UpdateBranchDto })
  update(
    @Param('id') id: number,
    @Body() updateBranchDto: UpdateBranchDto,
  ): Promise<Branch> {
    return this.branchService.update(id, updateBranchDto);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete branch by ID' })
  @ApiParam({ name: 'id', description: 'Branch ID' })
  remove(@Param('id') id: number): Promise<Branch> {
    return this.branchService.remove(id);
  }
}
