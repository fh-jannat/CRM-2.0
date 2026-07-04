'use client';

import React from 'react';
import {
  XAxis,
  YAxis,
  Tooltip,
  ResponsiveContainer,
  CartesianGrid,
  Legend,
  BarChart,
  Bar,
} from 'recharts';

interface BarChartProps {
  data: any;
}

const StepCountBarChart: React.FC<BarChartProps> = ({ data }) => {
  return (
    <div className='h-96 w-full rounded border p-4 shadow-md'>
      <ResponsiveContainer width='100%' height={300}>
        <BarChart
          data={data}
          margin={{
            top: 20,
            right: 30,
            left: 20,
            bottom: 5,
          }}
        >
          <CartesianGrid strokeDasharray='3 3' />
          <XAxis dataKey='name' />
          <YAxis />
          <Tooltip />
          <Legend />
          <Bar dataKey='count' fill='#8884d8' />
        </BarChart>
      </ResponsiveContainer>
    </div>
  );
};

export default StepCountBarChart;
