import { optionGenerator } from '@/utils';

export enum ApplicationStatus {
  PENDING = 'pending',
  APPLIED = 'applied',
  ACCEPTED = 'accepted',
}

export const applicationStatusOption = optionGenerator(ApplicationStatus);
