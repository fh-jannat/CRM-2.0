import { optionGenerator } from '@/utils';

export enum COUNTRY {
  AUSTRALIA = 'Australia',
  USA = 'USA',
  EUROPE = 'Europe',
  NEWZEALAND = 'New Zealand',
  UAE = 'UAE',
  MALAYSIA = 'Malaysia',
  UK = 'UK',
  DENMARK = 'Denmark',
  CANADA = 'Canada',
}

export const countryOption = optionGenerator(COUNTRY);
