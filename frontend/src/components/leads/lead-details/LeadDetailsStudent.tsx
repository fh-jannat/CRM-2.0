'use client';

import { useGetLeadByUserStudent } from '@/apis';
import { LeadBody } from './LeadBody';

export const LeadDetailsStudent = () => {
  const { data: leadInfo, refetch } = useGetLeadByUserStudent();

  return (
    <>
      <LeadBody leadInfo={leadInfo} refetch={refetch} />
    </>
  );
};
