import { axios } from '@/utils';
import { BRANCH } from './endpoints';

export const getBranchCount = async (queryParams = {}) => {
  const response = await axios.get(`${BRANCH}/count`, {
    params: queryParams,
  });
  return response.data;
};

export const getBranchOption = async () => {
  const response = await axios.get(`${BRANCH}/option`);
  return response.data;
};

export const getAllBranchs = async (queryParams = {}) => {
  const response = await axios.get(`${BRANCH}`, {
    params: queryParams,
  });
  return response.data;
};

export const getBranchById = async (id: number | string, queryParams = {}) => {
  const response = await axios.get(`${BRANCH}/${id}`, {
    params: queryParams,
  });
  return response.data;
};

export const createBranch = async (value: any) => {
  const response = await axios.post(`${BRANCH}`, value);
  return response.data;
};

export const updateBranch = async (id: number, value: any) => {
  const response = await axios.put(`${BRANCH}/${id}`, value);
  return response.data;
};

export const deleteBranch = async (id: number | string) => {
  const response = await axios.delete(`${BRANCH}/${id}`);
  return response.data;
};
