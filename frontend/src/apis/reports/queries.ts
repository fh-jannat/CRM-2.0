import { useQuery } from '@tanstack/react-query';

import { STALE_TIME } from '@/constants';
import {
  GET_REPORT_DATA,
  GET_REPORT_HISTORY,
  GET_REPORT_STEP_COUNT,
} from './keys';
import {
  getReportConversionStepsCount,
  getReportConversionTrendHistory,
  getReportData,
} from './apis';

export const useGetReportData = (queryParams = {}) => {
  return useQuery({
    queryKey: [GET_REPORT_DATA, queryParams],
    queryFn: async () => await getReportData(queryParams),
    staleTime: STALE_TIME,
  });
};

export const useGetReportConversionTrendHistory = () => {
  return useQuery({
    queryKey: [GET_REPORT_HISTORY],
    queryFn: async () => await getReportConversionTrendHistory(),
    staleTime: STALE_TIME,
  });
};

export const useGetReportConversionStepCount = (queryParams = {}) => {
  return useQuery({
    queryKey: [GET_REPORT_STEP_COUNT, queryParams],
    queryFn: async () => await getReportConversionStepsCount(queryParams),
    staleTime: STALE_TIME,
  });
};
