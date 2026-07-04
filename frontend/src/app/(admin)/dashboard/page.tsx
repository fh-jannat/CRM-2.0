'use client';
import React from 'react';
import dynamic from 'next/dynamic';
import { motion } from 'framer-motion';
// import ConversionReports from '@/components/reports/ConversionReports';
// import SuccessConversionReports from '@/components/reports/SuccessConversionReports';
import AppLoader from '@/components/Loader/AppLoader';

const ConversionReports = dynamic(
  () => import('@/components/reports/ConversionReports'),
  {
    ssr: false,
    loading: () => <AppLoader />,
  }
);

const SuccessConversionReports = dynamic(
  () => import('@/components/reports/SuccessConversionReports'),
  {
    ssr: false,
    loading: () => <AppLoader />,
  }
);

const Summary = dynamic(
  () => import('@/components/dashboard/summary/Summary'),
  {
    ssr: false,
    loading: () => <AppLoader />,
  }
);

const TasksTable = dynamic(() => import('@/components/tasks/TasksTable'), {
  ssr: false,
  loading: () => <AppLoader />,
});

const VendorHome: React.FC = () => {
  return (
    <div className='container mx-auto px-4'>
      <div className='grid grid-cols-1 gap-8 lg:grid-cols-3'>
        <motion.div
          className='lg:col-span-1'
          initial={{ opacity: 0, x: -20 }}
          animate={{ opacity: 1, x: 0 }}
          transition={{ duration: 0.5, delay: 0.2 }}
        >
          <div className='mb-8 rounded-lg bg-white p-6 shadow-lg transition-all duration-300 hover:shadow-xl'>
            <h2 className='mb-4 text-xl font-semibold text-gray-700'>
              Summary
            </h2>
            <Summary />
          </div>
        </motion.div>
        <motion.div
          className='lg:col-span-2'
          initial={{ opacity: 0, x: 20 }}
          animate={{ opacity: 1, x: 0 }}
          transition={{ duration: 0.5, delay: 0.4 }}
        >
          <div className='mb-8 grid grid-cols-1 gap-8 md:grid-cols-2'>
            <div className='rounded-lg bg-white p-6 shadow-lg transition-all duration-300 hover:shadow-xl'>
              <h2 className='mb-4 text-xl font-semibold text-gray-700'>
                Conversion Trend
              </h2>
              <ConversionReports />
            </div>
            <SuccessConversionReports />
          </div>
        </motion.div>
      </div>
      <motion.div
        className='rounded-lg bg-white p-6 shadow-lg transition-all duration-300 hover:shadow-xl'
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.5, delay: 0.6 }}
      >
        <h2 className='mb-4 text-xl font-semibold text-gray-700'>
          Recent Tasks
        </h2>
        <TasksTable />
      </motion.div>
    </div>
  );
};

export default VendorHome;
