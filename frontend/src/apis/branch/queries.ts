import { useMutation, useQuery } from '@tanstack/react-query';

import { STALE_TIME } from '@/constants';
import {
  createBranch,
  deleteBranch,
  getAllBranchs,
  getBranchById,
  getBranchCount,
  getBranchOption,
  updateBranch,
} from './apis';
import {
  CREATE_BRANCH,
  DELETE_BRANCH,
  GET_ALL_BRANCH,
  GET_ALL_BRANCH_COUNT,
  GET_ALL_BRANCH_OPTION,
  GET_BRANCH_BY_ID,
  UPDATE_BRANCH,
} from './keys';

export const useGetBranchCount = (queryParams = {}) => {
  return useQuery({
    queryKey: [GET_ALL_BRANCH_COUNT, queryParams],
    queryFn: async () => await getBranchCount(queryParams),
    staleTime: STALE_TIME,
  });
};

export const useGetBranchOption = (queryParams = {}) => {
  return useQuery({
    queryKey: [GET_ALL_BRANCH_OPTION, queryParams],
    queryFn: async () => await getBranchOption(),
    staleTime: STALE_TIME,
  });
};

export const useGetAllBranchs = (queryParams = {}) => {
  return useQuery({
    queryKey: [GET_ALL_BRANCH, queryParams],
    queryFn: async () => await getAllBranchs(queryParams),
    staleTime: STALE_TIME,
  });
};

export const useGetBranchById = (id: number | string, queryParams = {}) => {
  return useQuery({
    queryKey: [GET_BRANCH_BY_ID, id, queryParams],
    queryFn: async () => await getBranchById(id, queryParams),
    staleTime: STALE_TIME,
  });
};

export const useCreateBranch = () => {
  return useMutation({
    mutationKey: [CREATE_BRANCH],
    mutationFn: async (data: any) => await createBranch(data),
  });
};

export const useUpdateBranch = () => {
  return useMutation({
    mutationKey: [UPDATE_BRANCH],
    mutationFn: async (data: any) => await updateBranch(data.id, data),
  });
};

export const useDeleteBranch = () => {
  return useMutation({
    mutationKey: [DELETE_BRANCH],
    mutationFn: async (id: number | string) => await deleteBranch(id),
  });
};
