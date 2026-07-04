import { optionGenerator } from '@/utils';

export enum Branch {
  DHANMONDI = 'dhanmondi',
}

export const branchOption = optionGenerator(Branch);
