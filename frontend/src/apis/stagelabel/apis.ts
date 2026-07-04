import { axios } from '@/utils';
import { STAGELABEL } from './endpoints';

export const getAllStagelabels = async () => {
  const response = await axios.get(`${STAGELABEL}`);
  return response.data;
};

export const getStagelabel = async (stage: string, label: string) => {
  const response = await axios.get(`${STAGELABEL}/label/${stage}/${label}`);
  return response.data;
};

export const updateStagelabel = async (value: any) => {
  const response = await axios.put(`${STAGELABEL}/label`, value);
  return response.data;
};

export const getMenuLabel = async (stage: string) => {
  const response = await axios.get(`${STAGELABEL}/menu/${stage}`);
  return response.data;
};

export const getOptionLabel = async (stage?: string) => {
  if (!stage) return Promise.resolve(null);
  const response = await axios.get(`${STAGELABEL}/option/${stage}`);
  return response.data;
};
