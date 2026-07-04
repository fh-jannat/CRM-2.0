import React, { useState } from 'react';
import { Button, Input, Select } from 'antd';
import CreateAdminForm from './AdminForm';
import AdminTable from './AdminTable';
import { PlusOutlined } from '@ant-design/icons';

const { Option } = Select;

const AdminManagement: React.FC = () => {
  const [visible, setVisible] = useState(false);
  const [adminData, setAdminData] = useState<any[]>([
    {
      id: 1,
      name: 'John Doe',
      email: 'john@example.com',
      phoneNumber: '123-456-7890',
      date: '2024-03-01',
      status: 'active',
    },
    {
      id: 2,
      name: 'Jane Smith',
      email: 'jane@example.com',
      phoneNumber: '987-654-3210',
      date: '2024-03-02',
      status: 'pending',
    },
    {
      id: 3,
      name: 'Alice Johnson',
      email: 'alice@example.com',
      phoneNumber: '456-789-0123',
      date: '2024-03-03',
      status: 'active',
    },
    {
      id: 4,
      name: 'Bob Brown',
      email: 'bob@example.com',
      phoneNumber: '789-012-3456',
      date: '2024-03-04',
      status: 'pending',
    },
    {
      id: 5,
      name: 'Eva Green',
      email: 'eva@example.com',
      phoneNumber: '012-345-6789',
      date: '2024-03-05',
      status: 'active',
    },
  ]);

  const handleOk = (values: any) => {
    setAdminData([...adminData, { ...values, id: adminData.length + 1 }]);
    setVisible(false);
  };

  const handleCancel = () => {
    setVisible(false);
  };

  const onAddAdmin = () => {
    setVisible(true);
  };

  return (
    <div>
      <div style={{ marginBottom: 16 }} className=' flex justify-end'>
        <Button type='primary' icon={<PlusOutlined />} onClick={onAddAdmin}>
          Add Admin
        </Button>
      </div>
      <CreateAdminForm
        visible={visible}
        onCancel={handleCancel}
        onOk={handleOk}
      />
      <Input.Group compact style={{ marginBottom: 16 }}>
        <Input style={{ width: '20%' }} placeholder='Search by name' />
        <Input style={{ width: '20%' }} placeholder='Search by email' />
        <Input style={{ width: '20%' }} placeholder='Search by phone' />
        <Input style={{ width: '20%' }} placeholder='Search by date' />
        <Select defaultValue='All' style={{ width: '20%' }}>
          <Option value='All'>All</Option>
          <Option value='Active'>Active</Option>
          <Option value='Pending'>Pending</Option>
        </Select>
      </Input.Group>
      <AdminTable data={adminData} />
    </div>
  );
};

export default AdminManagement;
