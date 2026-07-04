'use client';

import dynamic from 'next/dynamic';
const LabelManagePage = dynamic(() => import('./ManageLabelPage'), {
  ssr: false,
});

const Page = () => {
  return <LabelManagePage />;
};

export default Page;
