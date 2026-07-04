import { useGetAllStats } from '@/apis';
import { motion } from 'framer-motion';
import React, { useEffect, useState } from 'react';
import CountUp from 'react-countup';

interface DataItem {
  label: string;
  number: number;
  icon: string;
  color: ColorScheme;
}

interface ColorScheme {
  from: string;
  to: string;
  hover: string;
  text: string;
  solid: string;
}

const colorSchemes: ColorScheme[] = [
  {
    from: 'from-blue-600',
    to: 'to-blue-800',
    hover: 'hover:from-blue-700 hover:to-blue-900',
    text: 'text-blue-100',
    solid: '#3B82F6',
  },
  {
    from: 'from-indigo-600',
    to: 'to-indigo-800',
    hover: 'hover:from-indigo-700 hover:to-indigo-900',
    text: 'text-indigo-100',
    solid: '#6366F1',
  },
  {
    from: 'from-teal-600',
    to: 'to-teal-800',
    hover: 'hover:from-teal-700 hover:to-teal-900',
    text: 'text-teal-100',
    solid: '#14B8A6',
  },
  {
    from: 'from-gray-600',
    to: 'to-gray-800',
    hover: 'hover:from-gray-700 hover:to-gray-900',
    text: 'text-gray-100',
    solid: '#4B5563',
  },
];

const GridBoxComponent: React.FC = () => {
  const { data, isLoading } = useGetAllStats();
  const [formattedData, setFormattedData] = useState<DataItem[]>([]);

  useEffect(() => {
    if (data?.data) {
      setFormattedData(formatData(data.data));
    }
  }, [data]);

  const formatData = (data: Record<string, number>): DataItem[] => {
    return Object.keys(data).map((key, index) => ({
      label: key,
      number: data[key],
      icon: `/dash/${index + 1}.png`,
      color: colorSchemes[index % colorSchemes.length],
    }));
  };

  if (isLoading) {
    return (
      <div className='flex h-32 items-center justify-center'>
        <div className='h-8 w-8 animate-spin rounded-full border-b-2 border-t-2 border-blue-600'></div>
      </div>
    );
  }

  return (
    <div className='rounded-xl'>
      <div className='grid grid-cols-2 gap-3 md:gap-4'>
        {formattedData.map((item, index) => (
          <motion.div
            key={item.label}
            initial={{ opacity: 0, y: 10 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.3, delay: index * 0.05 }}
            whileHover={{ scale: 1.02 }}
            className={`relative overflow-hidden rounded-lg bg-gradient-to-br ${item.color.from} ${item.color.to} transform p-3 shadow-lg transition-all duration-300 ease-in-out ${item.color.hover}`}
          >
            <div className='absolute -right-12 -top-12 h-36 w-36 rounded-full bg-white opacity-5'></div>
            <div className='relative z-10'>
              <div className='mb-2 flex items-center justify-between'>
                <motion.div
                  whileHover={{ rotate: 180 }}
                  className='rounded-md bg-white bg-opacity-10 p-1.5'
                >
                  <img src={item.icon} alt={item.label} className='h-5 w-5' />
                </motion.div>
                <div
                  className={`${item.color.text} text-xs font-medium text-opacity-90`}
                >
                  {item.label}
                </div>
              </div>
              <div
                className={`text-xl font-bold md:text-2xl ${item.color.text} mb-1 flex justify-start`}
              >
                <motion.span
                  initial={{ scale: 0.5 }}
                  animate={{ scale: 1 }}
                  transition={{ type: 'spring', stiffness: 100 }}
                >
                  <CountUp end={item.number} duration={1.5} separator=',' />
                </motion.span>
              </div>
              <div className={`${item.color.text} text-xs text-opacity-90`}>
                Total {item.label}
              </div>
            </div>
            <motion.div
              className='absolute bottom-0 left-0 right-0 h-1 bg-white bg-opacity-20'
              initial={{ scaleX: 0 }}
              whileHover={{ scaleX: 1 }}
              transition={{ duration: 0.3 }}
            />
          </motion.div>
        ))}
      </div>
    </div>
  );
};

export default GridBoxComponent;
