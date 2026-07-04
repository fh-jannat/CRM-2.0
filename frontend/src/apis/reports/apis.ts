import { axios } from '@/utils';
import { REPORT } from './endpoints';

export const getReportData = async (queryParams = {}) => {
  const response = await axios.get(`${REPORT}`, {
    params: queryParams,
  });
  return response.data;
};

export const getReportConversionTrendHistory = async () => {
  const response = await axios.get(`kpi/report/conversion-trend-history`);
  return response.data;
};

export const getReportConversionStepsCount = async (queryParams = {}) => {
  const response = await axios.get(`kpi/report/stage-wise-counts`, {
    params: queryParams,
  });
  return response.data;
};
