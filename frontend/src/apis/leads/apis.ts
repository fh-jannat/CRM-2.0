import { axios } from '@/utils';
import { LEAD_ENDPOINT } from './endpoints';

export const createLead = async (values: any) => {
  const response = await axios.post(LEAD_ENDPOINT, values);
  return response.data;
};

export const updateLead = async (leadId: string, values: any) => {
  const response = await axios.put(`${LEAD_ENDPOINT}/${leadId}`, values);
  return response.data;
};

export const updateLeadStage = async (leadId: string, values: any) => {
  const response = await axios.put(
    `${LEAD_ENDPOINT}/stagechange/${leadId}`,
    values
  );
  return response.data;
};

export const resendAuthMail = async (leadId: string | number) => {
  const response = await axios.post(`${LEAD_ENDPOINT}/resend`, { leadId });
  return response.data;
};

export const getLeadById = async (leadId: string, queryParams: any) => {
  if (!leadId) return null;
  const response = await axios.get(`${LEAD_ENDPOINT}/${leadId}`, {
    params: queryParams,
  });
  return response.data;
};

export const getLeadByUserStudent = async () => {
  const response = await axios.get(`${LEAD_ENDPOINT}/student`);
  return response.data;
};

export const getAllLeads = async (queryParams: any) => {
  const response = await axios.get(LEAD_ENDPOINT, { params: queryParams });
  return response.data;
};

export const getLeadsCount = async (queryParams: any) => {
  const response = await axios.get(`${LEAD_ENDPOINT}/count`, {
    params: queryParams,
  });
  return response.data;
};

export const deleteLead = async (leadId: string | number) => {
  const response = await axios.delete(`${LEAD_ENDPOINT}/${leadId}`);
  return response.data;
};
