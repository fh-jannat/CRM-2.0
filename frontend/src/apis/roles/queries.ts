import { useMutation, useQuery } from '@tanstack/react-query';

import { STALE_TIME } from '@/constants';
import {
  createRole,
  deleteRole,
  getAllRoles,
  getRoleById,
  getRoleCount,
  updateRole,
} from './apis';
import {
  CREATE_ROLE,
  DELETE_ROLE,
  GET_ALL_ROLE,
  GET_ALL_ROLE_COUNT,
  GET_ROLE_BY_ID,
  UPDATE_ROLE,
} from './keys';

export const useGetRoleCount = (queryParams = {}) => {
  return useQuery({
    queryKey: [GET_ALL_ROLE_COUNT, queryParams],
    queryFn: async () => await getRoleCount(queryParams),
    staleTime: STALE_TIME,
  });
};

export const useGetAllRoles = (queryParams = {}) => {
  return useQuery({
    queryKey: [GET_ALL_ROLE, queryParams],
    queryFn: async () => await getAllRoles(queryParams),
    staleTime: STALE_TIME,
  });
};

export const useGetRoleById = (id: number | string, queryParams = {}) => {
  return useQuery({
    queryKey: [GET_ROLE_BY_ID, id, queryParams],
    queryFn: async () => await getRoleById(id, queryParams),
    staleTime: STALE_TIME,
  });
};

export const useCreateRole = () => {
  return useMutation({
    mutationKey: [CREATE_ROLE],
    mutationFn: async (data: any) => await createRole(data),
  });
};

export const useUpdateRole = () => {
  return useMutation({
    mutationKey: [UPDATE_ROLE],
    mutationFn: async (data: any) => await updateRole(data.id, data),
  });
};

export const useDeleteRole = () => {
  return useMutation({
    mutationKey: [DELETE_ROLE],
    mutationFn: async (id: number | string) => await deleteRole(id),
  });
};
