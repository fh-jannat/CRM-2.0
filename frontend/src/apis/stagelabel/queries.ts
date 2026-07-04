import { useMutation, useQuery } from '@tanstack/react-query';

import { STALE_TIME } from '@/constants';
import {
  getAllStagelabels,
  getMenuLabel,
  getOptionLabel,
  getStagelabel,
  updateStagelabel,
} from './apis';
import {
  GET_ALL_STAGELABEL,
  GET_STAGE_MENU,
  GET_STAGE_OPTION,
  GET_STAGELABEL,
  UPDATE_STAGELABEL,
} from './keys';

export const useGetAllStagelabels = () => {
  return useQuery({
    queryKey: [GET_ALL_STAGELABEL],
    queryFn: async () => await getAllStagelabels(),
    staleTime: STALE_TIME,
  });
};

export const useGetStagelabel = (stage: string, label: string) => {
  return useQuery({
    queryKey: [GET_STAGELABEL, stage, label],
    queryFn: async () => await getStagelabel(stage, label),
    staleTime: STALE_TIME,
  });
};

export const useUpdateStagelabel = () => {
  return useMutation({
    mutationKey: [UPDATE_STAGELABEL],
    mutationFn: async (data: any) => await updateStagelabel(data),
  });
};

export const useGetMenu = (stage: string) => {
  return useQuery({
    queryKey: [GET_STAGE_MENU, stage],
    queryFn: async () => await getMenuLabel(stage),
    staleTime: STALE_TIME,
  });
};

export const useGetStageOption = (stage?: string) => {
  return useQuery({
    queryKey: [GET_STAGE_OPTION, stage],
    queryFn: async () => await getOptionLabel(stage),
    staleTime: STALE_TIME,
  });
};
