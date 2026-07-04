import { ApiPropertyOptional } from '@nestjs/swagger';
import { IsOptional, IsString } from 'class-validator';

export class CreateFacebookDto {
  @ApiPropertyOptional({
    description: 'The app ID for the Facebook application',
  })
  @IsOptional()
  @IsString()
  appId?: string;

  @ApiPropertyOptional({
    description: 'The app secret for the Facebook application',
  })
  @IsOptional()
  @IsString()
  appSecret?: string;

  @ApiPropertyOptional({ description: 'The page ID of the Facebook page' })
  @IsOptional()
  @IsString()
  pageId?: string;

  @ApiPropertyOptional({
    description: 'The access token for the Facebook page',
  })
  @IsOptional()
  @IsString()
  pageAccessToken?: string;
}
