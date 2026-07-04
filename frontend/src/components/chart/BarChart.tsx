'use client';

import React, { useState } from 'react';
import {
  PieChart,
  Pie,
  Tooltip,
  ResponsiveContainer,
  Cell,
  LabelList,
} from 'recharts';

interface BarChartProps {
  data: { finalStatus: string; count: number }[];
  stage: string;
}

const CustomPieChart: React.FC<BarChartProps> = ({ data, stage }) => {
  const [activeIndex, setActiveIndex] = useState<number | null>(null);
  const chartData = data?.map((item) => ({
    finalStatus: item.finalStatus?.toUpperCase(),
    count: parseInt(item.count?.toString(), 10),
  }));

  const COLORS = [
    '#D2DFFF',
    '#4378FF',
    '#82ca9d',
    '#ff7300',
    '#8884d8',
    '#FFBB28',
    '#FF8042',
    '#8dd1e1',
    '#a4de6c',
    '#d0ed57',
    '#ffc658',
    '#d4a5a5',
    '#c48c48',
    '#a6c48a',
    '#ad8cde',
    '#ffc0cb',
    '#ff7f50',
    '#9fe2bf',
    '#40e0d0',
    '#6495ed',
  ]; // Array of 20 colors

  const handleMouseEnter = (index: number) => {
    setActiveIndex(index);
  };

  const handleMouseLeave = () => {
    setActiveIndex(null);
  };

  return (
    <div className='flex h-96 w-full rounded border p-4 shadow-md'>
      <h2 className='text-md mb-4 font-semibold capitalize'>
        {stage === 'potential' ? 'Student' : stage}
      </h2>

      <ResponsiveContainer width='75%' height='100%'>
        <PieChart>
          <Pie
            data={chartData}
            dataKey='count'
            nameKey='finalStatus'
            cx='50%'
            cy='50%'
            outerRadius={120} // Increased the radius for a larger pie chart
            fill='#8884d8'
            onMouseEnter={(data, index) => handleMouseEnter(index)}
            onMouseLeave={handleMouseLeave}
            label={(entry) => `${entry.finalStatus}: ${entry.count}`} // Display label and count on the chart
          >
            <LabelList dataKey='count' position='inside' />{' '}
            {/* Display count inside the pie slices */}
            {chartData?.map((entry, index) => (
              <Cell
                key={`cell-${index}`}
                fill={
                  index === activeIndex
                    ? '#4378FF'
                    : COLORS[index % COLORS.length]
                }
              />
            ))}
          </Pie>
          <Tooltip
            itemStyle={{ color: 'white' }}
            contentStyle={{ backgroundColor: '#212B36', border: '#212B36' }}
          />
        </PieChart>
      </ResponsiveContainer>

      <div className='flex w-1/3 flex-col items-start justify-center pl-4'>
        {chartData?.map((item, index) => (
          <div key={index} className='mb-2 flex items-center'>
            <div
              style={{
                backgroundColor: COLORS[index % COLORS.length],
                width: '20px',
                height: '20px',
                marginRight: '10px',
              }}
            />
            <span className='text-gray-700'>
              {item.finalStatus}: {item.count.toLocaleString()}
            </span>
          </div>
        ))}
      </div>
    </div>
  );
};

export default CustomPieChart;
