import { useMutation, useQuery } from '@tanstack/react-query';

import { STALE_TIME } from '@/constants';
import {
  createMetacridential,
  deleteMetacridential,
  getAllMetacridentials,
  getMetacridentialById,
  getMetacridentialCount,
  updateMetacridential,
} from './apis';
import {
  CREATE_METACRIDENTIAL,
  DELETE_METACRIDENTIAL,
  GET_ALL_METACRIDENTIAL,
  GET_ALL_METACRIDENTIAL_COUNT,
  GET_METACRIDENTIAL_BY_ID,
  UPDATE_METACRIDENTIAL,
} from './keys';

export const useGetMetacridentialCount = (queryParams = {}) => {
  return useQuery({
    queryKey: [GET_ALL_METACRIDENTIAL_COUNT, queryParams],
    queryFn: async () => await getMetacridentialCount(queryParams),
    staleTime: STALE_TIME,
  });
};

export const useGetAllMetacridentials = (queryParams = {}) => {
  return useQuery({
    queryKey: [GET_ALL_METACRIDENTIAL, queryParams],
    queryFn: async () => await getAllMetacridentials(queryParams),
    staleTime: STALE_TIME,
  });
};

export const useGetMetacridentialById = (
  id: number | string,
  queryParams = {}
) => {
  return useQuery({
    queryKey: [GET_METACRIDENTIAL_BY_ID, id, queryParams],
    queryFn: async () => await getMetacridentialById(id, queryParams),
    staleTime: STALE_TIME,
  });
};

export const useCreateMetacridential = () => {
  return useMutation({
    mutationKey: [CREATE_METACRIDENTIAL],
    mutationFn: async (data: any) => await createMetacridential(data),
  });
};

export const useUpdateMetacridential = () => {
  return useMutation({
    mutationKey: [UPDATE_METACRIDENTIAL],
    mutationFn: async (data: any) => await updateMetacridential(data.id, data),
  });
};

export const useDeleteMetacridential = () => {
  return useMutation({
    mutationKey: [DELETE_METACRIDENTIAL],
    mutationFn: async (id: number | string) => await deleteMetacridential(id),
  });
};
