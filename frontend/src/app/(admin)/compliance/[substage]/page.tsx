'use client';
import { useGetStagelabel } from '@/apis';
import { AllVisaTable } from '@/components/leads/AllVisaTable';
import AppLoader from '@/components/Loader/AppLoader';
import { E_STAGE } from '@/enums';

const HomePage = ({ params }: { params: { substage: string } }) => {
  const { data, isLoading } = useGetStagelabel(
    E_STAGE.COMPLIANCE,
    params.substage
  );
  if (isLoading) {
    return <AppLoader />;
  }

  return <AllVisaTable leadType={data?.substage} />;
};

export default HomePage;
