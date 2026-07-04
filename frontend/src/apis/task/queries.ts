import { useMutation, useQuery } from '@tanstack/react-query';

import { STALE_TIME } from '@/constants';
import {
  createTask,
  deleteTask,
  getAllTasks,
  getTaskById,
  getTaskCount,
  updateTask,
} from './apis';
import {
  CREATE_TASK,
  DELETE_TASK,
  GET_ALL_TASK,
  GET_ALL_TASK_COUNT,
  GET_TASK_BY_ID,
  UPDATE_TASK,
} from './keys';

export const useGetTaskCount = (queryParams = {}) => {
  return useQuery({
    queryKey: [GET_ALL_TASK_COUNT, queryParams],
    queryFn: async () => await getTaskCount(queryParams),
    staleTime: STALE_TIME,
  });
};

export const useGetAllTasks = (queryParams = {}) => {
  return useQuery({
    queryKey: [GET_ALL_TASK, queryParams],
    queryFn: async () => await getAllTasks(queryParams),
    staleTime: STALE_TIME,
  });
};

export const useGetTaskById = (id: number | string, queryParams = {}) => {
  return useQuery({
    queryKey: [GET_TASK_BY_ID, id, queryParams],
    queryFn: async () => await getTaskById(id, queryParams),
    staleTime: STALE_TIME,
  });
};

export const useCreateTask = () => {
  return useMutation({
    mutationKey: [CREATE_TASK],
    mutationFn: async (data: any) => await createTask(data),
  });
};

export const useUpdateTask = () => {
  return useMutation({
    mutationKey: [UPDATE_TASK],
    mutationFn: async (data: any) => await updateTask(data.id, data),
  });
};

export const useDeleteTask = () => {
  return useMutation({
    mutationKey: [DELETE_TASK],
    mutationFn: async (id: number | string) => await deleteTask(id),
  });
};
