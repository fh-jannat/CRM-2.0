import { useGetReportConversionStepCount } from '@/apis';
import { Select } from 'antd';
import React, { useState } from 'react';
import {
  Bar,
  BarChart,
  Legend,
  ResponsiveContainer,
  Tooltip,
  XAxis,
  YAxis,
} from 'recharts';
import AppLoader from '../Loader/AppLoader';

export const SuccessConversionReports: React.FC = () => {
  const [dateRange, setDateRange] = useState<number>(365);
  const { data, isLoading } = useGetReportConversionStepCount({
    query: { dayInterval: dateRange },
  });

  return (
    <div className='rounded-lg bg-white px-3 py-6 shadow-lg transition-all duration-300 hover:shadow-xl'>
      <div className='mb-4 flex items-center justify-between gap-2 px-3'>
        <h2 className='whitespace-nowrap text-xl font-semibold text-gray-700'>
          Success Rate
        </h2>
        <Select
          className='min-w-24'
          size='small'
          value={dateRange}
          onChange={(value) => setDateRange(value)}
          options={[
            { value: 7, label: 'Last Week' },
            { value: 30, label: 'Last Month' },
            { value: 90, label: 'Last 3 Months' },
            { value: 365, label: 'Last Year' },
          ]}
        />
      </div>
      <div className='flex h-64 w-full items-center justify-center'>
        {isLoading ? (
          <AppLoader />
        ) : (
          <ResponsiveContainer width='100%' height='100%'>
            <BarChart data={data}>
              <XAxis dataKey='name' tick={{ fontSize: 10 }} />
              <YAxis tick={{ fontSize: 12 }} />
              <Tooltip />
              <Legend wrapperStyle={{ fontSize: 12 }} />
              <Bar dataKey='count' fill='#8884d8' />
            </BarChart>
          </ResponsiveContainer>
        )}
      </div>
    </div>
  );
};

export default SuccessConversionReports;
