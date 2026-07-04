import { useGetReportConversionTrendHistory } from '@/apis';
import React from 'react';
import {
  Legend,
  Line,
  LineChart,
  ResponsiveContainer,
  Tooltip,
  XAxis,
  YAxis,
} from 'recharts';
import AppLoader from '../Loader/AppLoader';

export const ConversionReports: React.FC = () => {
  const { data, isLoading } = useGetReportConversionTrendHistory();

  const chartData = data?.generated?.map((item: any, index: number) => ({
    month: item.month,
    generated: item.count,
    successful: data?.successful?.[index].count,
  }));

  return (
    <>
      {isLoading ? (
        <AppLoader />
      ) : (
        <div className='h-64'>
          <ResponsiveContainer width='100%' height='100%'>
            <LineChart data={chartData}>
              <XAxis dataKey='month' tick={{ fontSize: 10 }} />
              <YAxis tick={{ fontSize: 10 }} />
              <Tooltip />
              <Legend wrapperStyle={{ fontSize: 12 }} />
              <Line
                type='monotone'
                dataKey='generated'
                stroke='#8884d8'
                strokeWidth={2}
                dot={false}
              />
              <Line
                type='monotone'
                dataKey='successful'
                stroke='#82ca9d'
                strokeWidth={2}
                dot={false}
              />
            </LineChart>
          </ResponsiveContainer>
        </div>
      )}
    </>
  );
};

export default ConversionReports;
