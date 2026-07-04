import { axios } from '@/utils';
import { ACTIVITY } from './endpoints';

export const getActivityCount = async (queryParams = {}) => {
  const response = await axios.get(`${ACTIVITY}/count`, {
    params: queryParams,
  });
  return response.data;
};

export const getAllActivitys = async (queryParams = {}) => {
  const response = await axios.get(`${ACTIVITY}`, {
    params: queryParams,
  });
  return response.data;
};

export const getActivityById = async (
  id: number | string,
  queryParams = {}
) => {
  const response = await axios.get(`${ACTIVITY}/${id}`, {
    params: queryParams,
  });
  return response.data;
};

export const createActivity = async (value: any) => {
  const response = await axios.post(`${ACTIVITY}`, value);
  return response.data;
};

export const updateActivity = async (id: number, value: any) => {
  const response = await axios.put(`${ACTIVITY}/${id}`, value);
  return response.data;
};

export const deleteActivity = async (id: number | string) => {
  const response = await axios.delete(`${ACTIVITY}/${id}`);
  return response.data;
};
