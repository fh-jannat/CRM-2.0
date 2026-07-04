'use client';
// import { AllTable } from '@/components/leads';
import dynamic from 'next/dynamic';

const AllTable = dynamic(() => import('@/components/leads/AllTable'), {
  ssr: false,
});

const HomePage = () => {
  return <AllTable />;
};

export default HomePage;
