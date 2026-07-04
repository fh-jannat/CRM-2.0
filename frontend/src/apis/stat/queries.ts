import { useMutation, useQuery } from '@tanstack/react-query';

import { STALE_TIME } from '@/constants';
import {
  createStat,
  deleteStat,
  getAllStats,
  getStatById,
  getStatCount,
  updateStat,
} from './apis';
import {
  CREATE_STAT,
  DELETE_STAT,
  GET_ALL_STAT,
  GET_ALL_STAT_COUNT,
  GET_STAT_BY_ID,
  UPDATE_STAT,
} from './keys';

export const useGetStatCount = (queryParams = {}) => {
  return useQuery({
    queryKey: [GET_ALL_STAT_COUNT, queryParams],
    queryFn: async () => await getStatCount(queryParams),
    staleTime: STALE_TIME,
  });
};

export const useGetAllStats = (queryParams = {}) => {
  return useQuery({
    queryKey: [GET_ALL_STAT, queryParams],
    queryFn: async () => await getAllStats(queryParams),
    staleTime: STALE_TIME,
  });
};

export const useGetStatById = (id: number | string, queryParams = {}) => {
  return useQuery({
    queryKey: [GET_STAT_BY_ID, id, queryParams],
    queryFn: async () => await getStatById(id, queryParams),
    staleTime: STALE_TIME,
  });
};

export const useCreateStat = () => {
  return useMutation({
    mutationKey: [CREATE_STAT],
    mutationFn: async (data: any) => await createStat(data),
  });
};

export const useUpdateStat = () => {
  return useMutation({
    mutationKey: [UPDATE_STAT],
    mutationFn: async (data: any) => await updateStat(data.id, data),
  });
};

export const useDeleteStat = () => {
  return useMutation({
    mutationKey: [DELETE_STAT],
    mutationFn: async (id: number | string) => await deleteStat(id),
  });
};
