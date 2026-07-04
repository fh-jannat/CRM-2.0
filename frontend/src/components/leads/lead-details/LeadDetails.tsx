'use client';

import { useGetLeadById } from '@/apis';
import { useParams } from 'next/navigation';
import { LeadBody } from './LeadBody';

export const LeadDetails = () => {
  const params = useParams();

  const { data: leadInfo, refetch } = useGetLeadById(params?.leadId as string, {
    query: {
      relations: {
        remarks: true,
        leadDocs: true,
        leadApplications: {
          university: true,
        },
        assigned: true,
      },
    },
  });

  return (
    <>
      <LeadBody leadInfo={leadInfo} refetch={refetch} />
    </>
  );
};
