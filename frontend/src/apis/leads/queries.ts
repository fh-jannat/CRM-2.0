import { useMutation, useQuery } from '@tanstack/react-query';
import {
  createLead,
  deleteLead,
  getAllLeads,
  getLeadById,
  getLeadByUserStudent,
  getLeadsCount,
  resendAuthMail,
  updateLead,
  updateLeadStage,
} from './apis';
import {
  CREATE_LEAD,
  DELETE_LEAD,
  GET_ALL_LEADS,
  GET_LEAD_BY_ID,
  GET_LEAD_BY_USER_STUDENT,
  GET_LEAD_COUNT,
  RESEND_AUTH_MAIL,
  UPDATE_LEAD,
} from './keys';
import { STALE_TIME } from '@/constants';
import { stallQueries } from '@/utils';

export const useCreateLead = () => {
  return useMutation({
    mutationKey: [CREATE_LEAD],
    mutationFn: async (leadData: any) => await createLead(leadData),
    onSuccess: async () => {
      await stallQueries(GET_ALL_LEADS);
      await stallQueries(GET_LEAD_COUNT);
    },
  });
};

export const useUpdateLead = () => {
  return useMutation({
    mutationKey: [UPDATE_LEAD],
    mutationFn: async (leadData: any) =>
      await updateLead(leadData.id, leadData),
    onSuccess: async () => {
      await stallQueries(GET_ALL_LEADS);
      await stallQueries(GET_LEAD_COUNT);
      await stallQueries(GET_LEAD_BY_ID);
    },
  });
};

export const useUpdateLeadStage = () => {
  return useMutation({
    mutationKey: [UPDATE_LEAD, 'stage'],
    mutationFn: async (leadData: any) =>
      await updateLeadStage(leadData.id, leadData),
    onSuccess: async () => {
      await stallQueries(GET_ALL_LEADS);
      await stallQueries(GET_LEAD_COUNT);
      await stallQueries(GET_LEAD_BY_ID);
    },
  });
};

export const useResendAuthMail = () => {
  return useMutation({
    mutationKey: [RESEND_AUTH_MAIL],
    mutationFn: async (leadId: number | string) => await resendAuthMail(leadId),
  });
};

export const useGetLeadById = (leadId: string, queryParams: any = {}) => {
  return useQuery({
    queryKey: [GET_LEAD_BY_ID, leadId, queryParams],
    queryFn: async () => await getLeadById(leadId, queryParams),
    staleTime: STALE_TIME,
  });
};

export const useGetLeadByUserStudent = () => {
  return useQuery({
    queryKey: [GET_LEAD_BY_USER_STUDENT],
    queryFn: async () => await getLeadByUserStudent(),
    staleTime: STALE_TIME,
  });
};

export const useGetAllLeads = (queryParams: any = {}) => {
  return useQuery({
    queryKey: [GET_ALL_LEADS, queryParams],
    queryFn: async () => await getAllLeads(queryParams),
    staleTime: STALE_TIME,
  });
};

export const useGetLeadsCount = (queryParams: any = {}) => {
  return useQuery({
    queryKey: [GET_LEAD_COUNT, queryParams],
    queryFn: async () => await getLeadsCount(queryParams),
    staleTime: STALE_TIME,
  });
};

export const useDeleteLead = () => {
  return useMutation({
    mutationKey: [DELETE_LEAD],
    mutationFn: async (id: string | number) => await deleteLead(id),
    onSuccess: async () => {
      await stallQueries(GET_ALL_LEADS);
      await stallQueries(GET_LEAD_COUNT);
    },
  });
};
