import { useLeadContext } from '@/contexts/AddNewLeadContext';
import { Table, TableColumnsType } from 'antd';
import React from 'react';
import dayjs from 'dayjs';

const ApplicationList = () => {
  const { applications } = useLeadContext();

  const columns: TableColumnsType<any> = [
    {
      title: 'Sl',
      render: (_, __, index) => index + 1,
    },
    {
      title: 'University',
      dataIndex: ['university', 'universityName'],
    },
    {
      title: 'Country',
      dataIndex: ['university', 'country'],
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
    },
    {
      title: 'Intake Month',
      dataIndex: 'intakeMonth',
    },
    {
      title: 'Course Details',
      dataIndex: 'courseDetails',
    },
    {
      title: 'Created On',
      render: (record) => (
        <>{dayjs(record.createdAt).format('MMM D, YYYY h:mm A')}</>
      ),
    },
  ];
  return (
    <>
      <Table
        dataSource={applications}
        columns={columns}
        rowKey='courseLabel'
        pagination={false}
      />
    </>
  );
};

export default ApplicationList;
