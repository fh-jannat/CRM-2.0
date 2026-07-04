import { useGetRolesQuery } from '@/apis';
import { StatusChangeForm } from '@/components/forms';
import { Role } from '@/enums';
import { Button, Modal } from 'antd';
import { motion } from 'framer-motion';
import { useState } from 'react';

interface VisaTableProps {
  leadId: string;
  country: string;
  stage: string;
  subStage: string;
  refetch: () => Promise<any>;
}

export const VisaTable: React.FC<VisaTableProps> = ({
  leadId,
  country,
  stage,
  subStage,
  refetch,
}) => {
  const [openModal, setOpenModal] = useState<boolean>(false);

  const { data: roles } = useGetRolesQuery();

  const titleAndValue = (title: string, value: any) => (
    <motion.div
      className='flex flex-wrap gap-[8px] rounded-md p-2 transition-colors duration-300 hover:bg-gray-100'
      whileHover={{ scale: 1.02 }}
    >
      <div className='text-[16px] font-semibold text-gray-700'>{title}:</div>
      <div className='text-[16px] font-medium text-gray-600'>{value}</div>
    </motion.div>
  );

  return (
    <>
      <div className='grid grid-cols-1 gap-4 md:grid-cols-2'>
        {titleAndValue('Country', country)}
        {titleAndValue('Stage', stage)}
        {titleAndValue('Sub Stage', subStage)}
        {[
          Role.ADMIN,
          Role.MANAGER,
          Role.APPLICATION,
          Role.COMPLIANCE,
          Role.COUNSELLOR,
          Role.TEACHER,
        ].some((role) => roles?.includes(role)) ? (
          <Button
            type='primary'
            onClick={() => {
              setOpenModal(true);
            }}
          >
            Change Status
          </Button>
        ) : null}
      </div>
      <Modal
        title={'Change Status'}
        style={{ height: '100vh', overflowY: 'auto', top: 0 }}
        open={openModal}
        onCancel={() => {
          setOpenModal(false);
        }}
        footer={false}
      >
        <StatusChangeForm
          currentStage={stage}
          currentSubStage={subStage}
          country={country}
          id={leadId}
          onSubmit={async () => {
            await refetch();
            setOpenModal(false);
          }}
        />
      </Modal>
    </>
  );
};
