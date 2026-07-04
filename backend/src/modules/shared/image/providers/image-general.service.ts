import { Injectable } from '@nestjs/common';

import * as AWS from 'aws-sdk';
import * as fs from 'fs';
import { v4 as uuidv4 } from 'uuid';
import { ConfigService } from '@nestjs/config';

@Injectable()
export class ImagesGeneralService {
  private s3: AWS.S3;
  private keyPrefix: string;

  constructor(private readonly configService: ConfigService) {
    this.keyPrefix = this.configService.get('DGO_KEY_PREFIX');
    const spacesEndpoint = this.configService.get('DGO_SPACE_ENDPOINT');

    const accessKeyId = this.configService.get('DGO_ACCESS');
    const secretAccessKey = this.configService.get('DGO_SECRET_ACCESS');
    this.s3 = new AWS.S3({
      s3ForcePathStyle: false,
      region: this.configService.get('DGO_REGION'),
      endpoint: spacesEndpoint,
      credentials: {
        accessKeyId: accessKeyId,
        secretAccessKey: secretAccessKey,
      },
    });
  }

  async uploadImageToSpace(file: any) {
    const uniqueIdentifier = uuidv4();
    const key = `${this.keyPrefix}/${uniqueIdentifier}-${file.originalname}`;
    const bucketName = this.configService.get('DGO_SPACE_NAME');
    const fileData = await fs.promises.readFile(`${file.path}`);

    await this.s3
      .putObject({
        Bucket: bucketName,
        Key: key,
        Body: fileData,
        ACL: 'public-read',
        ContentType: file.mimetype,
      })
      .promise();

    await fs.promises.unlink(`${file.path}`);
    return key;
  }
}
