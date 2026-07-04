'use client';
import dynamic from 'next/dynamic';
const Activites = dynamic(() => import('@/components/activities/Activities'), {
  ssr: false,
});
// import Activites from '@/components/activities/Activities';
import React from 'react';

const page = () => {
  return <Activites />;
};

export default page;
