import {
  Body,
  Controller,
  Get,
  HttpCode,
  Post,
  Req,
  Res,
  UseGuards,
} from '@nestjs/common';
import {
  ApiBearerAuth,
  ApiBody,
  ApiCreatedResponse,
  ApiOkResponse,
  ApiOperation,
  ApiTags,
} from '@nestjs/swagger';
import { Request, Response } from 'express';
import { AuthService } from '../providers';
import {
  EmailAuthDto,
  CreateAuthDto,
  LoginAuthDto,
  VerifyEmailAuthDto,
  ChangePasswordOtpAuthDto,
} from '../dtos';
import { AccessTokenGuard, FacebookGuard, GoogleGuard } from '../guards';
import { User } from '@/common/decorator/user.decorator';

@ApiTags('v1/auth')
@Controller({ path: 'auth', version: '1' })
export class AuthGeneralController {
  constructor(private readonly authService: AuthService) {}

  @ApiTags('v1/seed')
  @ApiOperation({
    summary: 'Create an admin account with provided data if correct',
  })
  @ApiCreatedResponse({
    description: 'Create an admin account with provided data if correct',
  })
  @Post('seed/admin')
  async seedAdmin(@Body() createAuthDto: CreateAuthDto) {
    const ret = await this.authService.seedAdmin(createAuthDto);
    return {
      message: `Admin creation ${ret ? 'success' : 'failed'}`,
      user: ret,
    };
  }

  @ApiOperation({ summary: 'Check email exist in database' })
  @ApiOkResponse({
    description: 'Is existing user',
  })
  @HttpCode(200)
  @Post('local/check-email')
  async isExistingUser(@Body() checkEmailAuthDto: EmailAuthDto) {
    const ret = await this.authService.isExistingUser(checkEmailAuthDto);
    return { status: 'success', existinguser: ret };
  }

  @ApiOperation({ summary: 'Create an account with provided data if correct' })
  @ApiCreatedResponse({
    description: 'Create an account with provided data if correct',
  })
  @Post('local/register')
  async register(
    @Body() createAuthDto: CreateAuthDto,
    @Res() response: Response,
  ) {
    const ret = await this.authService.register(createAuthDto, response);
    return response.send(ret);
  }

  @ApiTags('v1/login')
  @ApiOperation({ summary: 'Logs in user' })
  @ApiOkResponse({
    description: 'Logs in user',
  })
  @HttpCode(200)
  @Post('local/login')
  async login(@Body() loginAuthDto: LoginAuthDto, @Res() response: Response) {
    const ret = await this.authService.login(loginAuthDto, response);
    return response.send(ret);
  }

  @ApiOperation({ summary: 'Refersh token' })
  @ApiOkResponse({
    description: 'Refresh user token',
  })
  @HttpCode(200)
  @ApiBody({ schema: { example: { token: 'token' } } })
  @Post('local/refresh-token')
  async refreshToken(@Body('token') token: string, @Res() response: Response) {
    const ret = await this.authService.refreshToken(token, response);
    return response.send(ret);
  }

  @ApiOperation({ summary: 'Sent forget-password otp' })
  @ApiOkResponse({
    description: 'Sent forget-password otp',
  })
  @HttpCode(200)
  @Post('local/forgot-password')
  async forgetPassword(@Body() forgotPasswordAuthDto: EmailAuthDto) {
    const ret = await this.authService.forgetPassword(forgotPasswordAuthDto);
    return { status: 'success', message: `An email is sent at ${ret.email}` };
  }

  @ApiOperation({ summary: 'Verify otp' })
  @ApiOkResponse({
    description: 'Verify otp',
  })
  @HttpCode(200)
  @Post('local/receive-otp')
  async receiveOtp(@Body() verifyEmailAuthDto: VerifyEmailAuthDto) {
    const ret = await this.authService.receiveOtp(verifyEmailAuthDto);
    return {
      status: 'success',
      isVerified: ret,
      message: `Otp verification ${ret ? 'success' : 'failed'}`,
    };
  }

  @ApiOperation({ summary: 'Set new password with otp' })
  @ApiOkResponse({
    description: 'Set new password with otp',
  })
  @HttpCode(200)
  @Post('local/otp-newpassword')
  async setNewPassword(
    @Body() changePasswordOtpAuthDto: ChangePasswordOtpAuthDto,
  ) {
    const ret = await this.authService.setNewPassword(changePasswordOtpAuthDto);
    return {
      status: 'success',
      message: `User password change ${ret ? 'success' : 'failed'}`,
    };
  }

  @ApiOperation({ summary: 'Check User Login' })
  @ApiOkResponse({
    description: 'Check User Login',
  })
  @ApiBearerAuth()
  @HttpCode(200)
  @UseGuards(AccessTokenGuard)
  @Get('local/isloggedin')
  async isloggedin() {
    return { status: 'success' };
  }

  @ApiOperation({ summary: 'Get Logged in user' })
  @ApiOkResponse({
    description: 'Get Logged in user',
  })
  @ApiBearerAuth()
  @HttpCode(200)
  @UseGuards(AccessTokenGuard)
  @Get('local/user')
  async getUser(@User() user) {
    return { status: 'success', user };
  }

  @ApiOperation({ summary: 'Logs out user' })
  @ApiOkResponse({
    description: 'Logs out user',
  })
  @HttpCode(200)
  @UseGuards(AccessTokenGuard)
  @Get('local/logout')
  async logout(@Res() response: Response) {
    response.clearCookie('access_token');
    response.clearCookie('refresh_token');
    return response.send('Cookies cleared');
  }

  @ApiOkResponse({
    description: 'Google login url',
  })
  @HttpCode(200)
  @Get('google/login')
  @UseGuards(GoogleGuard)
  async googleLogin() {}

  @ApiOkResponse({
    description: 'Google callback url',
  })
  @HttpCode(200)
  @Get('google/callback')
  @UseGuards(GoogleGuard)
  async googleLoginCallback(
    @Req() request: Request,
    @Res() response: Response,
  ) {
    const ret = await this.authService.setLoginCookie(request, response);
    return response.send(ret);
  }

  @ApiOkResponse({
    description: 'Facebook login url',
  })
  @HttpCode(200)
  @Get('facebook/login')
  @UseGuards(FacebookGuard)
  async facebookLogin() {
    console.log('Facebook login url');
  }

  @ApiOkResponse({
    description: 'Facebook callback url',
  })
  @HttpCode(200)
  @Get('facebook/callback')
  @UseGuards(FacebookGuard)
  async facebookLoginCallback(
    @Req() request: Request,
    @Res() response: Response,
  ) {
    const ret = await this.authService.setLoginCookie(request, response);
    return response.send(ret);
  }

  @ApiOkResponse({
    description: 'Get user role',
  })
  @HttpCode(200)
  @UseGuards(AccessTokenGuard)
  @ApiBearerAuth()
  @Get('local/role')
  async getRoles(@User() user) {
    return { status: 'success', role: user.role };
  }
}
