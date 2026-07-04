'use client';
import { useGetStagelabel } from '@/apis';
import AllStudentsTable from '@/components/leads/AllStusentTable';
import AppLoader from '@/components/Loader/AppLoader';

import { E_STAGE } from '@/enums';

const HomePage = ({ params }: { params: { substage: string } }) => {
  const { data, isLoading } = useGetStagelabel(
    E_STAGE.POTENTIAL,
    params.substage
  );
  if (isLoading) {
    return <AppLoader />;
  }

  return <AllStudentsTable leadType={data?.substage} />;
};

export default HomePage;
