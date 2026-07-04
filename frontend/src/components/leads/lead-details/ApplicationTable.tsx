import { useGetRolesQuery, useUpdateApplication } from '@/apis';
import ActionButton from '@/components/common/ActionButton';
import { ApplicationForm } from '@/components/leads/lead-details/ApplicationForm';
import { Role } from '@/enums';
import { handleErrorToast } from '@/utils/handleErrorToast';
import { Form, Modal, Table, TableColumnsType } from 'antd';
import dayjs from 'dayjs';
import { useState } from 'react';
import { toast } from 'react-toastify';

interface ApplicationTableProps {
  data: any;
  refetch: () => Promise<any>;
}

export const ApplicationTable: React.FC<ApplicationTableProps> = ({
  data,
  refetch,
}) => {
  const [form] = Form.useForm();
  const [openModal, setOpenModal] = useState<boolean>(false);

  const updateApplication = useUpdateApplication();
  const { data: roles } = useGetRolesQuery();

  const handleApplicationForm = async (value: any) => {
    try {
      await updateApplication.mutateAsync(value);
      toast.success('Application updated successfully');
    } catch (error) {
      handleErrorToast(error);
    } finally {
      await refetch();
      setOpenModal(false);
      form.resetFields();
    }
  };

  const columns: TableColumnsType<any> = [
    {
      title: 'Sl',
      render: (_, __, index) => index + 1,
      responsive: ['md'],
    },
    {
      title: 'University',
      dataIndex: ['university', 'universityName'],
    },
    {
      title: 'Country',
      dataIndex: ['university', 'country'],
      responsive: ['md'],
    },
    {
      title: 'Status',
      dataIndex: 'applicationStatus',
    },
    {
      title: 'Course Label',
      dataIndex: 'courseLabel',
    },
    {
      title: 'Intake Year',
      dataIndex: 'intakeYear',
      responsive: ['md'],
    },
    {
      title: 'Intake Month',
      dataIndex: 'intakeMonth',
      responsive: ['md'],
    },
    {
      title: 'Course Details',
      dataIndex: 'courseDetails',
      responsive: ['lg'],
    },
    {
      title: 'Created On',
      render: (record) => (
        <>{dayjs(record.createdAt).format('MMM D, YYYY h:mm A')}</>
      ),
      responsive: ['md'],
    },
  ];

  if (
    [
      Role.ADMIN,
      Role.MANAGER,
      Role.APPLICATION,
      Role.COMPLIANCE,
      Role.COUNSELLOR,
      Role.TEACHER,
    ].some((role) => roles?.includes(role))
  ) {
    columns.push({
      title: 'Actions',
      width: '100px',
      render: (_, record) => (
        <div className='flex flex-row gap-1'>
          <ActionButton.Edit
            onClick={async () => {
              form.setFieldsValue(record);
              form.setFieldValue('universityId', record.university.id);
              setOpenModal(true);
            }}
          />
        </div>
      ),
    });
  }

  return (
    <div className='overflow-x-auto'>
      <Table
        columns={columns}
        pagination={false}
        dataSource={data}
        className='border border-slate-200'
      />
      <Modal
        title={'Update Application'}
        open={openModal}
        onCancel={() => {
          form.resetFields();
          setOpenModal(false);
        }}
        footer={false}
        className='w-full max-w-4xl'
      >
        <ApplicationForm
          form={form}
          onSubmit={handleApplicationForm}
          onCancel={() => setOpenModal(false)}
        />
      </Modal>
    </div>
  );
};
