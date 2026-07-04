import { axios } from '@/utils';
import { METACRIDENTIAL } from './endpoints';

export const getMetacridentialCount = async (queryParams = {}) => {
  const response = await axios.get(`${METACRIDENTIAL}/count`, {
    params: queryParams,
  });
  return response.data;
};

export const getAllMetacridentials = async (queryParams = {}) => {
  const response = await axios.get(`${METACRIDENTIAL}`, {
    params: queryParams,
  });
  return response.data;
};

export const getMetacridentialById = async (
  id: number | string,
  queryParams = {}
) => {
  const response = await axios.get(`${METACRIDENTIAL}/${id}`, {
    params: queryParams,
  });
  return response.data;
};

export const createMetacridential = async (value: any) => {
  const response = await axios.post(`${METACRIDENTIAL}`, value);
  return response.data;
};

export const updateMetacridential = async (id: number, value: any) => {
  const response = await axios.patch(`${METACRIDENTIAL}/${id}`, value);
  return response.data;
};

export const deleteMetacridential = async (id: number | string) => {
  const response = await axios.delete(`${METACRIDENTIAL}/${id}`);
  return response.data;
};
