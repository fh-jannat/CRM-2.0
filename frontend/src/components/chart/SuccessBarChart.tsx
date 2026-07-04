'use client';

import React from 'react';
import {
  LineChart,
  Line,
  XAxis,
  YAxis,
  Tooltip,
  ResponsiveContainer,
  CartesianGrid,
  Legend,
} from 'recharts';

interface BarChartProps {
  data: any;
}

const SuccessBarChart: React.FC<BarChartProps> = ({ data }) => {
  const chartData = data?.generated?.map((item: any, index: number) => ({
    month: item.month,
    generated: item.count,
    successful: data?.successful?.[index].count,
  }));

  return (
    <div className='h-96 w-full rounded border p-4 shadow-md'>
      <ResponsiveContainer width='100%' height={400}>
        <LineChart
          data={chartData}
          margin={{
            top: 40,
            right: 30,
            left: 20,
            bottom: 5,
          }}
        >
          <CartesianGrid strokeDasharray='3 3' />
          <XAxis dataKey='month' />
          <YAxis />
          <Tooltip />
          <Legend />
          <Line type='monotone' dataKey='generated' stroke='#8884d8' />
          <Line type='monotone' dataKey='successful' stroke='#82ca9d' />
        </LineChart>
      </ResponsiveContainer>
    </div>
  );
};

export default SuccessBarChart;
