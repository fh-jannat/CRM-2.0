'use client';
import { useGetStagelabel } from '@/apis';
import AllAdmissionTable from '@/components/leads/AllAdmissionTable';
import AppLoader from '@/components/Loader/AppLoader';
import { E_STAGE } from '@/enums';

const HomePage = ({ params }: { params: { substage: string } }) => {
  const { data, isLoading } = useGetStagelabel(
    E_STAGE.ADMISSION,
    params.substage
  );
  if (isLoading) {
    return <AppLoader />;
  }

  return <AllAdmissionTable leadType={data?.substage} />;
};

export default HomePage;
