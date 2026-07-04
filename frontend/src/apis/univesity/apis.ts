import { axios } from '@/utils';
import { UNIVESITY_ENDPOINT } from './endpoints';

export const createUnivesity = async (values: any) => {
  const response = await axios.post(UNIVESITY_ENDPOINT, values);
  return response.data;
};

export const updateUnivesity = async (univesityId: string, values: any) => {
  const response = await axios.put(
    `${UNIVESITY_ENDPOINT}/${univesityId}`,
    values
  );
  return response.data;
};

export const getUnivesityById = async (
  univesityId: string,
  queryParams: any
) => {
  if (!univesityId) return null;
  const response = await axios.get(`${UNIVESITY_ENDPOINT}/${univesityId}`, {
    params: queryParams,
  });
  return response.data;
};

export const getAllUnivesitys = async (queryParams: any) => {
  const response = await axios.get(UNIVESITY_ENDPOINT, { params: queryParams });
  return response.data;
};

export const getUniversityOption = async () => {
  const response = await axios.get(`${UNIVESITY_ENDPOINT}/options`);
  return response.data;
};

export const getUnivesitysCount = async (queryParams: any) => {
  const response = await axios.get(`${UNIVESITY_ENDPOINT}/count`, {
    params: queryParams,
  });
  return response.data;
};

export const deleteUnivesity = async (
  univesityId: string | number | bigint
) => {
  const response = await axios.delete(`${UNIVESITY_ENDPOINT}/${univesityId}`);
  return response.data;
};
