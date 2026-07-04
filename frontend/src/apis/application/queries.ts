import { useMutation, useQuery } from '@tanstack/react-query';

import { STALE_TIME } from '@/constants';
import {
  createApplication,
  deleteApplication,
  getAllApplications,
  getApplicationById,
  getApplicationCount,
  updateApplication,
} from './apis';
import {
  CREATE_APPLICATION,
  DELETE_APPLICATION,
  GET_ALL_APPLICATION,
  GET_ALL_APPLICATION_COUNT,
  GET_APPLICATION_BY_ID,
  UPDATE_APPLICATION,
} from './keys';
import { stallQueries } from '@/utils';
import { GET_ALL_LEADS } from '../leads/keys';

export const useGetApplicationCount = (queryParams = {}) => {
  return useQuery({
    queryKey: [GET_ALL_APPLICATION_COUNT, queryParams],
    queryFn: async () => await getApplicationCount(queryParams),
    staleTime: STALE_TIME,
  });
};

export const useGetAllApplications = (queryParams = {}) => {
  return useQuery({
    queryKey: [GET_ALL_APPLICATION, queryParams],
    queryFn: async () => await getAllApplications(queryParams),
    staleTime: STALE_TIME,
  });
};

export const useGetApplicationById = (
  id: number | string,
  queryParams = {}
) => {
  return useQuery({
    queryKey: [GET_APPLICATION_BY_ID, id, queryParams],
    queryFn: async () => await getApplicationById(id, queryParams),
    staleTime: STALE_TIME,
  });
};

export const useCreateApplication = () => {
  return useMutation({
    mutationKey: [CREATE_APPLICATION],
    mutationFn: async (data: any) => await createApplication(data),
  });
};

export const useUpdateApplication = () => {
  return useMutation({
    mutationKey: [UPDATE_APPLICATION],
    mutationFn: async (data: any) => await updateApplication(data.id, data),
    onSuccess: async () => {
      await stallQueries(GET_ALL_LEADS);
    },
  });
};

export const useDeleteApplication = () => {
  return useMutation({
    mutationKey: [DELETE_APPLICATION],
    mutationFn: async (id: number | string) => await deleteApplication(id),
  });
};
