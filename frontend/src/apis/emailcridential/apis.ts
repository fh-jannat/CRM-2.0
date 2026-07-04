import { axios } from '@/utils';
import { EMIALCRIDENTIAL } from './endpoints';

export const createEmailcridential = async (value: any) => {
  const response = await axios.post(`${EMIALCRIDENTIAL}`, value);
  return response.data;
};

export const sendEmail = async (value: any) => {
  const response = await axios.post(`${EMIALCRIDENTIAL}/sendmail`, value);
  return response.data;
};
