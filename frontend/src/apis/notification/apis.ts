import { axios } from '@/utils';
import { NOTIFICATIONS } from './endpoints';

export const getNotificationCount = async (queryParams = {}) => {
  const response = await axios.get(`${NOTIFICATIONS}/count`, {
    params: queryParams,
  });
  return response.data;
};

export const getNotificationCountUnread = async (queryParams = {}) => {
  const response = await axios.get(`${NOTIFICATIONS}/unread-count`, {
    params: queryParams,
  });
  return response.data;
};

export const getAllNotifications = async (queryParams = {}) => {
  const response = await axios.get(`${NOTIFICATIONS}`, {
    params: queryParams,
  });
  return response.data;
};

export const getNotificationById = async (
  id: number | string,
  queryParams = {}
) => {
  const response = await axios.get(`${NOTIFICATIONS}/${id}`, {
    params: queryParams,
  });
  return response.data;
};

export const createNotification = async (value: any) => {
  const response = await axios.post(`${NOTIFICATIONS}`, value);
  return response.data;
};

export const updateNotification = async (id: number, value: any) => {
  const response = await axios.patch(`${NOTIFICATIONS}/${id}/read`, value);
  return response.data;
};

export const deleteNotification = async (id: number | string) => {
  const response = await axios.delete(`${NOTIFICATIONS}/${id}`);
  return response.data;
};
