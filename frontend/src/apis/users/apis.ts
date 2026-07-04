import { axios } from '@/utils';
import { USERS } from './endpoints';

export const getUserCount = async (queryParams = {}) => {
  const response = await axios.get(`${USERS}/count`, {
    params: queryParams,
  });
  return response.data;
};

export const getAllUsers = async (queryParams = {}) => {
  const response = await axios.get(`${USERS}`, {
    params: queryParams,
  });
  return response.data;
};

export const getUserOption = async (
  stage = 'all',
  branchSpecificApplication = false
) => {
  const response = await axios.get(`${USERS}/role-option`, {
    params: { branchSpecificApplication, stage },
  });
  return response.data;
};

export const getUserById = async (id: number | string, queryParams = {}) => {
  const response = await axios.get(`${USERS}/${id}`, { params: queryParams });
  return response.data;
};

export const createUser = async (value: any) => {
  const response = await axios.post(`${USERS}`, value);
  return response.data;
};

export const updateUser = async (id: number, value: any) => {
  const response = await axios.put(`${USERS}/${id}`, value);
  return response.data;
};

export const deleteUser = async (id: number | string) => {
  const response = await axios.delete(`${USERS}/${id}`);
  return response.data;
};
