import { axios } from '@/utils';
import { APPLICATION } from './endpoints';

export const getApplicationCount = async (queryParams = {}) => {
  const response = await axios.get(`${APPLICATION}/count`, {
    params: queryParams,
  });
  return response.data;
};

export const getAllApplications = async (queryParams = {}) => {
  const response = await axios.get(`${APPLICATION}`, {
    params: queryParams,
  });
  return response.data;
};

export const getApplicationById = async (
  id: number | string,
  queryParams = {}
) => {
  const response = await axios.get(`${APPLICATION}/${id}`, {
    params: queryParams,
  });
  return response.data;
};

export const createApplication = async (value: any) => {
  const response = await axios.post(`${APPLICATION}`, value);
  return response.data;
};

export const updateApplication = async (id: number, value: any) => {
  const response = await axios.put(`${APPLICATION}/${id}`, value);
  return response.data;
};

export const deleteApplication = async (id: number | string) => {
  const response = await axios.delete(`${APPLICATION}/${id}`);
  return response.data;
};
