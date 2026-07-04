import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { Request, Response } from 'express';
import {
  AuthResponse,
  EmailAuthDto,
  CreateAuthDto,
  LoginAuthDto,
  VerifyEmailAuthDto,
  ChangePasswordOtpAuthDto,
} from '../dtos';
import { JwtService } from '@nestjs/jwt';
import { MailsenderService } from '@/modules/shared/mailsender';
import { ConfigService } from '@nestjs/config';
import { UserGeneralService } from '@/modules/v1/user/providers';
import * as bcrypt from 'bcrypt';
import { v4 as uuidv4 } from 'uuid';
import { generate } from 'otp-generator';
import { Profile as GoogleProfile } from 'passport-google-oauth20';
import { Profile as FacebookProfile } from 'passport-facebook';
import { User } from '@/modules/v1/user/entity';
import { Role } from '@/modules/enums/role.enum';

import { EventTriggeredEvent } from '../../event/dtos/event-triggered.event';
import { EventHandlerService } from '../../event/event.service';
import { ACTIVITY } from '@/modules/enums/event.enum';
@Injectable()
export class AuthService {
  constructor(
    private readonly userService: UserGeneralService,
    private readonly jwtService: JwtService,
    private readonly mailSenderService: MailsenderService,
    private readonly configService: ConfigService,
    private readonly eventService: EventHandlerService,
  ) {}

  async isExistingUser(checkEmailAuthDto: EmailAuthDto) {
    const user = await this.userService.findUserByEmail(
      checkEmailAuthDto.email,
    );
    if (user) {
      return true;
    } else {
      return false;
    }
  }

  async getUserById(id: string) {
    return await this.userService.findUserById(+id);
  }

  async seedAdmin(createAuthDto: CreateAuthDto) {
    try {
      const adminCount = await this.userService.countAdminUser();
      if (adminCount > 0) {
        return false;
      }

      createAuthDto.password = await this.hashPassword(createAuthDto.password);

      return await this.userService.createAdminUser(createAuthDto);
    } catch (error) {
      console.log(error);
      return false;
    }
  }

  async register(
    createAuthDto: CreateAuthDto,
    response: Response,
  ): Promise<AuthResponse> {
    const isExistingUser = await this.isExistingUser(createAuthDto);
    if (isExistingUser) {
      throw new HttpException('User already registered', HttpStatus.CONFLICT);
    }
    createAuthDto.password = await this.hashPassword(createAuthDto.password);
    const user = await this.userService.registerUser(createAuthDto);
    user.otp = generate(6, {
      digits: true,
      lowerCaseAlphabets: false,
      upperCaseAlphabets: false,
      specialChars: false,
    });
    await this.userService.updateUser(+user.id, user);
    this.mailSenderService.sendWelcomeEmail({
      to: user.email,
      subject: 'Welcome to our portfolio',
      text: `OTP is ${user.otp}`,
      user: user,
    });
    user.password = null;
    const [accessToken, refreshToken] = await this.generateTokens(user);
    await this.setTokens(response, { accessToken, refreshToken });
    this.eventService.createActivity(
      new EventTriggeredEvent(ACTIVITY.SIGNUP, {
        user: user,
        branch: user.branchName,
        details: 'Registered',
        role: user.role[0],
      }),
    );
    return { user, status: 'success', accessToken, refreshToken };
  }

  async login(loginAuthDto: LoginAuthDto, response: Response) {
    const user = await this.userService.findUserByEmail(loginAuthDto.email);
    if (!user) {
      throw new HttpException('User not found', HttpStatus.NOT_FOUND);
    }
    if (!user.isVerified) {
      throw new HttpException('User not verified', HttpStatus.UNAUTHORIZED);
    }
    if (user.status !== 'active') {
      throw new HttpException('User not active', HttpStatus.UNAUTHORIZED);
    }
    const isPasswordCorrect = await this.comparePassword(
      loginAuthDto.password,
      user.password,
    );

    console.log('INPUT PASSWORD:', loginAuthDto.password);
console.log('DB HASH:', user.password);
console.log('MATCH:', isPasswordCorrect);


    if (!isPasswordCorrect) {
      throw new HttpException('Invalid credentials', HttpStatus.UNAUTHORIZED);
    }
    user.password = null;
    const [accessToken, refreshToken] = await this.generateTokens(user);
    await this.setTokens(response, { accessToken, refreshToken });
    this.eventService.createActivity(
      new EventTriggeredEvent(ACTIVITY.LOGIN, {
        user: user,
        branch: user.branchName,
        details: 'Logged in',
        role: user.role[0],
      }),
    );
    return { user, status: 'success', accessToken, refreshToken };
  }

  async refreshToken(token: string, response: Response) {
    const user = await this.getUserFromAuthenticationRefreshToken(token);
    if (!user) {
      throw new HttpException('Invalid token', HttpStatus.UNAUTHORIZED);
    }
    const [accessToken, refreshToken] = await this.generateTokens(user);
    await this.setTokens(response, { accessToken, refreshToken });
    return { user, status: 'success', accessToken, refreshToken };
  }

  public async registerGoogle(profile: GoogleProfile) {
    const user = await this.userService.registerUser({
      fullName: profile.displayName,
      email: profile.emails[0]?.value ?? `${profile.id}@google.com`,
      password: `google`,
      provider: profile.provider,
      providerId: profile.id,
      role: [Role.USER],
    });
    return user;
  }

  public async registerFacebook(profile: FacebookProfile) {
    const user = await this.userService.registerUser({
      fullName: profile.displayName,
      email: profile.emails[0]?.value ?? `${profile.id}@facebook.com`,
      password: `facebook`,
      provider: profile.provider,
      providerId: profile.id,
      role: [Role.USER],
    });

    return user;
  }

  public async setLoginCookie(request: Request, response: Response) {
    try {
      const user = request.user;
      const [accessToken, refreshToken] = await this.generateTokens(user);
      await this.setTokens(response, { accessToken, refreshToken });
      return user;
    } catch (err) {
      console.log(err);
      throw new HttpException(err.response, err.status);
    }
  }

  async forgetPassword(forgotPasswordAuthDto: EmailAuthDto): Promise<User> {
    const user = await this.userService.findUserByEmail(
      forgotPasswordAuthDto.email,
    );
    if (!user) {
      throw new HttpException('User not found', HttpStatus.NOT_FOUND);
    }

    user.otp = generate(6, {
      digits: true,
      lowerCaseAlphabets: false,
      upperCaseAlphabets: false,
      specialChars: false,
    });
    await this.userService.updateUser(user.id, user);
    this.mailSenderService.sendResetPasswordEmail({
      to: user.email,
      subject: 'Account recovery',
      text: `${user.otp}`,
      user: user,
    });
    return user;
  }

  async receiveOtp(verifyEmailAuthDto: VerifyEmailAuthDto): Promise<boolean> {
    const user = await this.userService.findUserByEmail(
      verifyEmailAuthDto.email,
    );
    if (!user) {
      throw new HttpException('User not found', HttpStatus.NOT_FOUND);
    }
    if (user.otp !== verifyEmailAuthDto.otp) {
      throw new HttpException('Invalid otp', HttpStatus.UNAUTHORIZED);
    }
    user.isVerified = true;
    if (verifyEmailAuthDto.removeotp) {
      user.otp = null;
    }
    await this.userService.updateUser(user.id, user);
    return true;
  }

  async setNewPassword(changePasswordOtpAuthDto: ChangePasswordOtpAuthDto) {
    const user = await this.userService.findUserByEmail(
      changePasswordOtpAuthDto.email,
    );
    if (!user) {
      throw new HttpException('User not found', HttpStatus.NOT_FOUND);
    }
    if (user.otp !== changePasswordOtpAuthDto.otp) {
      throw new HttpException('Invalid otp', HttpStatus.UNAUTHORIZED);
    }
    user.password = await this.hashPassword(changePasswordOtpAuthDto.password);
    user.otp = null;
    await this.userService.updateUser(user.id, user);
    return true;
  }

  private hashPassword(password: string) {
    return bcrypt.hash(password, 10);
  }

  private async comparePassword(password: string, hash: string) {
    return await bcrypt.compare(password, hash);
  }

  private async generateTokens(user) {
    const jwtid = uuidv4();
    const accessToken = await this.jwtService.signAsync(
      {
        id: user.id,
        email: user.email,
      },
      {
        issuer: 'mohsin',
        secret: this.configService.get('JWT_ACCESS_SECRET_KEY'),
        expiresIn: this.configService.get('JWT_ACCESS_EXPIRATION_TIME'),
      },
    );
    const refreshToken = await this.jwtService.signAsync(
      {
        id: user.id,
        email: user.email,
      },
      {
        jwtid,
        issuer: 'mohsin',
        secret: this.configService.get('JWT_REFRESH_SECRET_KEY'),
        expiresIn: this.configService.get('JWT_REFRESH_EXPIRATION_TIME'),
      },
    );
    return [accessToken, refreshToken];
  }

  private async setTokens(
    res: Response,
    {
      accessToken,
      refreshToken,
    }: { accessToken: string; refreshToken?: string },
  ) {
    const domain = this.configService.get('DOMAIN');
    res.cookie('access_token', accessToken, {
      maxAge: +this.configService.get('JWT_ACCESS_EXPIRATION_SECOND'),
      httpOnly: true,
      // sameSite: true,
      domain: domain,
    });

    if (refreshToken) {
      res.cookie('refresh_token', refreshToken, {
        maxAge: +this.configService.get('JWT_REFRESH_EXPIRATION_SECOND'),
        httpOnly: true,
        // sameSite: true,
        domain: domain,
      });
    }
  }

  public async getUserFromAuthenticationToken(token: string) {
    const payload: any = this.jwtService.verify(token, {
      secret: this.configService.get('JWT_ACCESS_SECRET_KEY'),
    });

    const userId = payload.id;

    if (userId) {
      return this.userService.findUserByIdPassword(userId);
    }
  }

  public async getUserFromAuthenticationRefreshToken(token: string) {
    const payload: any = this.jwtService.verify(token, {
      secret: this.configService.get('JWT_REFRESH_SECRET_KEY'),
    });

    const userId = payload.id;

    if (userId) {
      return this.userService.findUserByIdPassword(userId);
    }
  }
}
