import { axios } from '@/utils';
import { TASK } from './endpoints';

export const getTaskCount = async (queryParams = {}) => {
  const response = await axios.get(`${TASK}/count`, {
    params: queryParams,
  });
  return response.data;
};

export const getAllTasks = async (queryParams = {}) => {
  const response = await axios.get(`${TASK}`, {
    params: queryParams,
  });
  return response.data;
};

export const getTaskById = async (id: number | string, queryParams = {}) => {
  const response = await axios.get(`${TASK}/${id}`, { params: queryParams });
  return response.data;
};

export const createTask = async (value: any) => {
  const response = await axios.post(`${TASK}`, value);
  return response.data;
};

export const updateTask = async (id: number, value: any) => {
  const response = await axios.put(`${TASK}/${id}`, value);
  return response.data;
};

export const deleteTask = async (id: number | string) => {
  const response = await axios.delete(`${TASK}/${id}`);
  return response.data;
};
