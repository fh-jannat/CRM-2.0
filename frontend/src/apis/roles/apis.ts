import { axios } from '@/utils';
import { ROLES } from './endpoints';

export const getRoleCount = async (queryParams = {}) => {
  const response = await axios.get(`${ROLES}/count`, {
    params: queryParams,
  });
  return response.data;
};

export const getAllRoles = async (queryParams = {}) => {
  const response = await axios.get(`${ROLES}`, {
    params: queryParams,
  });
  return response.data;
};

export const getRoleById = async (id: number | string, queryParams = {}) => {
  const response = await axios.get(`${ROLES}/${id}`, { params: queryParams });
  return response.data;
};

export const createRole = async (value: any) => {
  const response = await axios.post(`${ROLES}`, value);
  return response.data;
};

export const updateRole = async (id: number, value: any) => {
  const response = await axios.put(`${ROLES}/${id}`, value);
  return response.data;
};

export const deleteRole = async (id: number | string) => {
  const response = await axios.delete(`${ROLES}/${id}`);
  return response.data;
};
