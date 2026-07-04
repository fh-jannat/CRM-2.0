import {
  Controller,
  Post,
  UseInterceptors,
  UploadedFile,
} from '@nestjs/common';

import { FileInterceptor } from '@nestjs/platform-express';
import { ImagesGeneralService } from '../providers/image-general.service';
import { ApiBody, ApiConsumes, ApiTags } from '@nestjs/swagger';

@ApiTags('v1/image')
@Controller({ path: 'image', version: '1' })
export class ImagesGeneralController {
  constructor(private readonly imagesService: ImagesGeneralService) {}

  @Post('upload')
  @ApiConsumes('multipart/form-data')
  @ApiBody({
    schema: {
      type: 'object',
      properties: {
        file: {
          type: 'file',
          format: 'binary',
        },
      },
    },
  })
  @UseInterceptors(FileInterceptor('file'))
  uploadFile(
    @UploadedFile()
    file: any,
  ) {
    return this.imagesService.uploadImageToSpace(file);
  }
}
