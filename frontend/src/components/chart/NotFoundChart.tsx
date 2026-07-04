'use client';

import React from 'react';
import { ResponsiveContainer } from 'recharts';
import { EmptyState } from '../common/empty';

interface BarChartProps {
  stage: string;
}

const CustomNotFoundChart: React.FC<BarChartProps> = ({ stage }) => {
  return (
    <div className='h-96 w-full rounded border p-4 shadow-md'>
      <h2 className='text-md mb-4 font-semibold capitalize'>
        {stage === 'potential' ? 'Student' : stage}
      </h2>
      <ResponsiveContainer>
        <EmptyState
          message='No data available'
          description='There is no data available for this chart'
        />
      </ResponsiveContainer>
    </div>
  );
};

export default CustomNotFoundChart;
