// import { User } from '@/modules/v1/user/schema';

import { User } from '@/modules/v1/user/entity';

export class AuthResponse {
  user: User;
  status: string;
  accessToken: string;
  refreshToken: string;
}
