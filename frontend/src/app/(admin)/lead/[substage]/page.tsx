'use client';
import { useGetStagelabel } from '@/apis';
import { AllLeadsTable } from '@/components/leads';
import AppLoader from '@/components/Loader/AppLoader';
import { E_STAGE } from '@/enums';

const HomePage = ({ params }: { params: { substage: string } }) => {
  const { data, isLoading } = useGetStagelabel(E_STAGE.LEAD, params.substage);
  if (isLoading) {
    return <AppLoader />;
  }

  return <AllLeadsTable leadType={data?.substage} />;
};

export default HomePage;
