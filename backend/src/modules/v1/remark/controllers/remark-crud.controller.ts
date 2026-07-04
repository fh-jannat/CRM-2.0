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
import { RemarkCrudService } from '../providers';
import { CreateRemarkDto, UpdateRemarkDto, DynamicDto } from '../dtos';
import { Remark } from '../entities/remark.entity';
import { ParseBoolPipe } from '@/common/pipe';
import { AccessTokenGuard, RoleGuard } from '@/modules/shared/auth/guards';
import { HasRoles } from '@/common/decorator/roles.decorator';
import { Role } from '@/modules/enums/role.enum';

@ApiTags('v1/remark')
@Controller({ path: 'remark', version: '1' })
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
export class RemarkController {
  constructor(private readonly remarkService: RemarkCrudService) {}

  @Get('count')
  @ApiOperation({ summary: 'Get total remark count' })
  @ApiQuery({ type: DynamicDto })
  @UsePipes(new ParseBoolPipe())
  async count(@Query() queryParams: DynamicDto): Promise<number> {
    return await this.remarkService.count(queryParams);
  }

  @Post()
  @ApiOperation({ summary: 'Create a new remark' })
  @ApiBody({ type: CreateRemarkDto })
  create(@Body() createRemarkDto: CreateRemarkDto): Promise<Remark> {
    return this.remarkService.create(createRemarkDto);
  }

  @Get()
  @ApiOperation({ summary: 'Get all remark' })
  @ApiQuery({ type: DynamicDto })
  @UsePipes(new ParseBoolPipe())
  async findAll(@Query() queryParams: DynamicDto): Promise<Remark[]> {
    return this.remarkService.findAll(queryParams);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get remark by ID' })
  @ApiParam({ name: 'id', description: 'Remark ID' })
  @ApiQuery({ type: DynamicDto })
  @UsePipes(new ParseBoolPipe())
  findOne(
    @Param('id') id: number,
    @Query() queryParams: DynamicDto,
  ): Promise<Remark> {
    return this.remarkService.findOne(id, queryParams);
  }

  @Put(':id')
  @ApiOperation({ summary: 'Update remark by ID' })
  @ApiParam({ name: 'id', description: 'Remark ID' })
  @ApiBody({ type: UpdateRemarkDto })
  update(
    @Param('id') id: number,
    @Body() updateRemarkDto: UpdateRemarkDto,
  ): Promise<Remark> {
    return this.remarkService.update(id, updateRemarkDto);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete remark by ID' })
  @ApiParam({ name: 'id', description: 'Remark ID' })
  remove(@Param('id') id: number): Promise<Remark> {
    return this.remarkService.remove(id);
  }
}
