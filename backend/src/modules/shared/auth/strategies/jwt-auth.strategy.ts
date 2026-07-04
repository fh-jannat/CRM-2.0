import { ExtractJwt, Strategy } from 'passport-jwt';
import { PassportStrategy } from '@nestjs/passport';
import { HttpException, Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { Request } from 'express';
import { AuthService } from '../providers';

export type JwtAccessPayload = {
  id: string;
  email: string;
};

@Injectable()
export class JwtAuthStrategy extends PassportStrategy(
  Strategy,
  'access-token',
) {
  constructor(
    configService: ConfigService,
    private authService: AuthService,
  ) {
    super({
      jwtFromRequest: JwtAuthStrategy.extractJwtFromCookie,
      ignoreExpiration: false,
      secretOrKey: configService.get<string>('JWT_ACCESS_SECRET_KEY'),
    });
  }

  async validate(payload: JwtAccessPayload) {
    if (!payload) {
      throw new HttpException('Token expired', 498);
    }
    const user = await this.authService.getUserById(payload.id);
    if (!user) {
      throw new HttpException('Token expired', 498);
    }
    return user;
  }

  static extractJwtFromCookie(req: Request) {
    const token = null;
    return token || ExtractJwt.fromAuthHeaderAsBearerToken()(req);
  }
}
