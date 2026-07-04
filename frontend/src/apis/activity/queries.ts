import { useMutation, useQuery } from '@tanstack/react-query';

import { STALE_TIME } from '@/constants';
import {
  createActivity,
  deleteActivity,
  getAllActivitys,
  getActivityById,
  getActivityCount,
  updateActivity,
} from './apis';
import {
  CREATE_ACTIVITY,
  DELETE_ACTIVITY,
  GET_ALL_ACTIVITY,
  GET_ALL_ACTIVITY_COUNT,
  GET_ACTIVITY_BY_ID,
  UPDATE_ACTIVITY,
} from './keys';

export const useGetActivityCount = (queryParams = {}) => {
  return useQuery({
    queryKey: [GET_ALL_ACTIVITY_COUNT, queryParams],
    queryFn: async () => await getActivityCount(queryParams),
    staleTime: STALE_TIME,
  });
};

export const useGetAllActivitys = (queryParams = {}) => {
  return useQuery({
    queryKey: [GET_ALL_ACTIVITY, queryParams],
    queryFn: async () => await getAllActivitys(queryParams),
    staleTime: STALE_TIME,
  });
};

export const useGetActivityById = (id: number | string, queryParams = {}) => {
  return useQuery({
    queryKey: [GET_ACTIVITY_BY_ID, id, queryParams],
    queryFn: async () => await getActivityById(id, queryParams),
    staleTime: STALE_TIME,
  });
};

export const useCreateActivity = () => {
  return useMutation({
    mutationKey: [CREATE_ACTIVITY],
    mutationFn: async (data: any) => await createActivity(data),
  });
};

export const useUpdateActivity = () => {
  return useMutation({
    mutationKey: [UPDATE_ACTIVITY],
    mutationFn: async (data: any) => await updateActivity(data.id, data),
  });
};

export const useDeleteActivity = () => {
  return useMutation({
    mutationKey: [DELETE_ACTIVITY],
    mutationFn: async (id: number | string) => await deleteActivity(id),
  });
};
