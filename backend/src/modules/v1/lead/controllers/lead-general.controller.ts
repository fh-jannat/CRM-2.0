import {
  Controller,
  Post,
  UseInterceptors,
  UploadedFiles,
  UseGuards,
} from '@nestjs/common';

import { FilesInterceptor } from '@nestjs/platform-express';

import { ApiBearerAuth, ApiBody, ApiConsumes, ApiTags } from '@nestjs/swagger';
import { LeadCrudService } from '../providers';
import { User } from '@/common/decorator/user.decorator';
import { HasRoles } from '@/common/decorator/roles.decorator';
import { AccessTokenGuard, RoleGuard } from '@/modules/shared/auth/guards';
import { Role } from '@/modules/enums/role.enum';

@ApiTags('v1/lead')
@Controller({ path: 'lead', version: '1' })
@ApiBearerAuth()
@UseGuards(AccessTokenGuard, RoleGuard)
@HasRoles(Role.ADMIN, Role.USER)
export class LeadGeneralController {
  constructor(private readonly leadService: LeadCrudService) {} // private readonly leadGenService: LeadGeneralService

  @Post('upload')
  @ApiConsumes('multipart/form-data')
  @ApiBody({
    schema: {
      type: 'object',
      properties: {
        files: {
          type: 'file',
          format: 'csv',
        },
      },
    },
  })
  @UseInterceptors(FilesInterceptor('files'))
  uploadFile(
    @UploadedFiles()
    files: Array<Express.Multer.File>,
    @User() user,
  ) {
    return this.leadService.uploadCSV(files, user);
  }
  // @Post('assign-doc')
  // @ApiOperation({ summary: 'assign Docs to lead' })
  // @ApiBody({ type: assignDocDto })
  // async create(@Body() assignDocDto: assignDocDto) {
  //   return await this.leadGenService.assignDocs(assignDocDto);
  // }
}
