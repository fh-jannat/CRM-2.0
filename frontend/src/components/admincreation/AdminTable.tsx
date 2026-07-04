import React from 'react';
import { Table, Avatar } from 'antd';

interface AdminTableProps {
  data: any[];
}

const AdminTable: React.FC<AdminTableProps> = ({ data }) => {
  const columns = [
    {
      title: 'ID',
      dataIndex: 'id',
      key: 'id',
    },
    {
      title: 'Name',
      dataIndex: 'name',
      fixed: 'left' as const,

      key: 'name',
      render: (text: string, record: any) => (
        <div className='flex items-center'>
          <div className='flex items-center space-x-2'>
            {record.avatar ? (
              <Avatar src={record.avatar} />
            ) : (
              <Avatar>{text.charAt(0)}</Avatar>
            )}
            <span>{text}</span>
          </div>
        </div>
      ),
    },
    {
      title: 'Email',
      dataIndex: 'email',
      key: 'email',
    },
    {
      title: 'Phone Number',
      dataIndex: 'phoneNumber',
      key: 'phoneNumber',
    },
    {
      title: 'Date',
      dataIndex: 'date',
      key: 'date',
    },
    {
      title: 'Status',
      dataIndex: 'status',
      fixed: 'right' as const,
      key: 'status',
      render: (text: string) => (
        <button
          className={`w-20 rounded-md px-2 py-1 text-white ${text === 'active' ? 'bg-green-500' : 'bg-red-500'}`}
        >
          {text?.toUpperCase()}
        </button>
      ),
    },
  ];

  return (
    <Table columns={columns} dataSource={data} pagination={{ pageSize: 10 }} />
  );
};

export default AdminTable;
