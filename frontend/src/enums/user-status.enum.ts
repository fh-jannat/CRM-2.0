import { optionGenerator } from '@/utils/optionGenerator';

export enum UserStatus {
  ACTIVE = 'active',
  INACTIVE = 'inactive',
}

export const userStatusOption = optionGenerator(UserStatus);
