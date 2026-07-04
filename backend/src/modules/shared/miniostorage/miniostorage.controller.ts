import {
  Controller,
  Post,
  UploadedFile,
  UseInterceptors,
} from '@nestjs/common';
import {
  ApiBody,
  ApiConsumes,
  ApiOperation,
  ApiResponse,
  ApiTags,
} from '@nestjs/swagger';
import { MiniostorageService } from './miniostorage.service';
import { FileInterceptor } from '@nestjs/platform-express';

@ApiTags('v1/fileupload')
@Controller({
  path: 'fileupload',
  version: '1',
})
export class MiniostorageController {
  constructor(private readonly miniostorageService: MiniostorageService) {}

  @Post()
  @UseInterceptors(FileInterceptor('file'))
  @ApiOperation({ summary: 'Upload a single image' })
  @ApiConsumes('multipart/form-data')
  @ApiBody({
    schema: {
      type: 'object',
      properties: {
        file: {
          type: 'string',
          format: 'binary',
        },
      },
    },
  })
  @ApiResponse({
    status: 201,
    description: 'Single Image uploaded successfully',
    schema: {
      type: 'object',
      properties: {
        statusCode: { type: 'string', example: 'success' },
      },
    },
  })
  async uploadFile(@UploadedFile() file: any) {
    return await this.miniostorageService.uploadFile(file);
  }
}
