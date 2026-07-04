import {
  Body,
  Controller,
  Get,
  Param,
  Patch,
  Post,
  Query,
  UseGuards,
  UsePipes,
} from '@nestjs/common';
import { NotificationGeneralService } from '../providers';
import { Notification } from '../entity/notification.entity';
import { ApiOperation, ApiQuery, ApiTags } from '@nestjs/swagger';
import { AccessTokenGuard } from '@/modules/shared/auth/guards';
import { User } from '@/common/decorator/user.decorator';
import { DynamicDto } from '../dtos/dynamic.dto';
import { ParseBoolPipe } from '@/common/pipe';

@ApiTags('v1/notification')
@Controller({ path: 'notification', version: '1' })
export class NotificationGeneralController {
  constructor(
    private readonly notificationService: NotificationGeneralService,
  ) {}

  @Post()
  async create(
    @Body('userId') userId: number,
    @Body('message') message: string,
    @Body('redirectUrl') redirectUrl?: string,
  ): Promise<Notification> {
    return this.notificationService.createNotification(
      userId,
      message,
      redirectUrl,
    );
  }

  @Get('count')
  @ApiOperation({ summary: 'Get total notification count' })
  @ApiQuery({ type: DynamicDto })
  @UsePipes(new ParseBoolPipe())
  @UseGuards(AccessTokenGuard)
  async count(@Query() queryParams: DynamicDto, @User() user): Promise<number> {
    return await this.notificationService.count(queryParams, user.id);
  }

  @Get('unread-count')
  @ApiOperation({ summary: 'Get total unread notification count' })
  @UseGuards(AccessTokenGuard)
  async countUnread(@User() user): Promise<number> {
    return await this.notificationService.countUnread(user.id);
  }

  @UseGuards(AccessTokenGuard)
  @Get()
  @ApiQuery({ type: DynamicDto })
  @UsePipes(new ParseBoolPipe())
  async findAll(
    @Query() queryParams: DynamicDto,
    @User() user,
  ): Promise<Notification[]> {
    return this.notificationService.findAll(queryParams, user.id);
  }

  @Patch(':id/read')
  async markAsRead(@Param('id') id: number): Promise<Notification> {
    return this.notificationService.markAsRead(id);
  }
}
