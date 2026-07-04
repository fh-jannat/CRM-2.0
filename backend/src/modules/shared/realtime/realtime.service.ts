import { Injectable } from '@nestjs/common';
import { AuthService } from '../auth/providers';
import { Socket } from 'socket.io';
import { WsException } from '@nestjs/websockets';

@Injectable()
export class RealtimeService {
  private readonly userSockets: Map<number, Socket> = new Map();
  constructor(private authService: AuthService) {}

  async getUserFromSocket(socket: Socket) {
    try {
      const auth_token = socket.handshake.auth.token;
      // get the token itself without "Bearer"
      // auth_token = auth_token.split(' ')[1];

      const user =
        await this.authService.getUserFromAuthenticationToken(auth_token);

      this.userSockets.set(user.id, socket);

      if (!user) {
        throw new WsException('Invalid credentials.');
      }
      return user;
    } catch (e) {
      // console.log(e);
      // throw new WsException('Invalid credentials.');
    }
  }

  async removeUser(socket: Socket) {
    try {
      const user = await this.getUserFromSocket(socket);
      this.userSockets.delete(user.id);
    } catch (e) {
      console.log(e);
    }
  }

  async getUserSocket(userId: number) {
    return this.userSockets.get(userId);
  }

  async sendMessage(userId: number, message: string) {
    const socket = await this.getUserSocket(userId);
    if (socket) {
      socket.emit('message', message);
    }
    return true;
  }
}
