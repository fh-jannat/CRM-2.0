import { axios } from '@/utils';
import { STAT } from './endpoints';

export const getStatCount = async (queryParams = {}) => {
  const response = await axios.get(`${STAT}/count`, {
    params: queryParams,
  });
  return response.data;
};

export const getAllStats = async (queryParams = {}) => {
  const response = await axios.get(`${STAT}`, {
    params: queryParams,
  });
  return response.data;
};

export const getStatById = async (id: number | string, queryParams = {}) => {
  const response = await axios.get(`${STAT}/${id}`, {
    params: queryParams,
  });
  return response.data;
};

export const createStat = async (value: any) => {
  const response = await axios.post(`${STAT}`, value);
  return response.data;
};

export const updateStat = async (id: number, value: any) => {
  const response = await axios.put(`${STAT}/${id}`, value);
  return response.data;
};

export const deleteStat = async (id: number | string) => {
  const response = await axios.delete(`${STAT}/${id}`);
  return response.data;
};
