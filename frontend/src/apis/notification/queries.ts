import { useMutation, useQuery } from '@tanstack/react-query';

import { STALE_TIME } from '@/constants';
import {
  createNotification,
  deleteNotification,
  getAllNotifications,
  getNotificationById,
  getNotificationCount,
  getNotificationCountUnread,
  updateNotification,
} from './apis';
import {
  CREATE_NOTIFICATION,
  DELETE_NOTIFICATION,
  GET_ALL_NOTIFICATION,
  GET_ALL_NOTIFICATION_COUNT,
  GET_ALL_NOTIFICATION_UNREAD_COUNT,
  GET_NOTIFICATION_BY_ID,
  UPDATE_NOTIFICATION,
} from './keys';
import { stallQueries } from '@/utils';

export const useGetNotificationCount = (queryParams = {}) => {
  return useQuery({
    queryKey: [GET_ALL_NOTIFICATION_COUNT, queryParams],
    queryFn: async () => await getNotificationCount(queryParams),
    staleTime: STALE_TIME,
  });
};

export const useGetNotificationCountUnread = (queryParams = {}) => {
  return useQuery({
    queryKey: [GET_ALL_NOTIFICATION_UNREAD_COUNT, queryParams],
    queryFn: async () => await getNotificationCountUnread(queryParams),
    staleTime: STALE_TIME,
  });
};

export const useGetAllNotifications = (queryParams = {}) => {
  return useQuery({
    queryKey: [GET_ALL_NOTIFICATION, queryParams],
    queryFn: async () => await getAllNotifications(queryParams),
    staleTime: STALE_TIME,
  });
};

export const useGetNotificationById = (
  id: number | string,
  queryParams = {}
) => {
  return useQuery({
    queryKey: [GET_NOTIFICATION_BY_ID, id, queryParams],
    queryFn: async () => await getNotificationById(id, queryParams),
    staleTime: STALE_TIME,
  });
};

export const useCreateNotification = () => {
  return useMutation({
    mutationKey: [CREATE_NOTIFICATION],
    mutationFn: async (data: any) => await createNotification(data),
  });
};

export const useUpdateNotification = () => {
  return useMutation({
    mutationKey: [UPDATE_NOTIFICATION],
    mutationFn: async (data: any) => await updateNotification(data.id, data),
    onSuccess: async () => {
      await stallQueries(GET_ALL_NOTIFICATION_UNREAD_COUNT);
    },
  });
};

export const useDeleteNotification = () => {
  return useMutation({
    mutationKey: [DELETE_NOTIFICATION],
    mutationFn: async (id: number | string) => await deleteNotification(id),
  });
};
