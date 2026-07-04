import { useMutation, useQuery } from '@tanstack/react-query';
import {
  createUnivesity,
  deleteUnivesity,
  getAllUnivesitys,
  getUniversityOption,
  getUnivesityById,
  getUnivesitysCount,
  updateUnivesity,
} from './apis';
import {
  CREATE_UNIVESITY,
  DELETE_UNIVESITY,
  GET_ALL_UNIVESITYS,
  GET_UNIVESITY_BY_ID,
  GET_UNIVESITY_COUNT,
  UPDATE_UNIVESITY,
} from './keys';
import { STALE_TIME } from '@/constants';
import { stallQueries } from '@/utils';

export const useCreateUnivesity = () => {
  return useMutation({
    mutationKey: [CREATE_UNIVESITY],
    mutationFn: async (univesityData: any) =>
      await createUnivesity(univesityData),
    onSuccess: async () => {
      await stallQueries(GET_ALL_UNIVESITYS);
      await stallQueries(GET_UNIVESITY_COUNT);
    },
  });
};

export const useUpdateUnivesity = () => {
  return useMutation({
    mutationKey: [UPDATE_UNIVESITY],
    mutationFn: async (univesityData: any) =>
      await updateUnivesity(univesityData.id, univesityData),
    onSuccess: async () => {
      await stallQueries(GET_ALL_UNIVESITYS);
      await stallQueries(GET_UNIVESITY_COUNT);
      await stallQueries(GET_UNIVESITY_BY_ID);
    },
  });
};

export const useGetUnivesityById = (
  univesityId: string,
  queryParams: any = {}
) => {
  return useQuery({
    queryKey: [GET_UNIVESITY_BY_ID, univesityId],
    queryFn: async () => await getUnivesityById(univesityId, queryParams),
    staleTime: STALE_TIME,
  });
};

export const useGetAllUnivesitys = (queryParams: any = {}) => {
  return useQuery({
    queryKey: [GET_ALL_UNIVESITYS, queryParams],
    queryFn: async () => await getAllUnivesitys(queryParams),
    staleTime: STALE_TIME,
  });
};

export const useGetUnivesityOption = () => {
  return useQuery({
    queryKey: [GET_ALL_UNIVESITYS, 'option'],
    queryFn: async () => await getUniversityOption(),
    staleTime: STALE_TIME,
  });
};

export const useGetUnivesitysCount = (queryParams: any = {}) => {
  return useQuery({
    queryKey: [GET_UNIVESITY_COUNT, queryParams],
    queryFn: async () => await getUnivesitysCount(queryParams),
    staleTime: STALE_TIME,
  });
};

export const useDeleteUnivesity = () => {
  return useMutation({
    mutationKey: [DELETE_UNIVESITY],
    mutationFn: async (id: string | number | bigint) =>
      await deleteUnivesity(id),
    onSuccess: async () => {
      await stallQueries(GET_ALL_UNIVESITYS);
      await stallQueries(GET_UNIVESITY_COUNT);
    },
  });
};
