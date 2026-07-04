import { optionGenerator } from '@/utils';

export enum TaskStatus {
  PENDING = 'pending',
  PICKED = 'picked up',
  COMPLETE = 'complete',
}

export const taskStatusOption = optionGenerator(TaskStatus);
