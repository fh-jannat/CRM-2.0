'use client';
import { useGetAllStagelabels } from '@/apis';
import { ManageLabelForm } from './ManageLabelForm';
import AppLoader from '@/components/Loader/AppLoader';

const LabelManagePage = () => {
  const { data, isLoading } = useGetAllStagelabels();
  if (isLoading) {
    return <AppLoader />;
  }
  return (
    <div>
      {data?.map((item: any) => (
        <ManageLabelForm
          key={item.id}
          stage={item.stage}
          substage={item.substage}
          substageLabel={item.substageLabel}
        />
      ))}
    </div>
  );
};

export default LabelManagePage;
