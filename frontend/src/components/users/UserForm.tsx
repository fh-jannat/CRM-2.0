'use client';
import { Button, Form, Input, Select, Spin } from 'antd';
import React from 'react';
import { activeStatusOptions } from './helper';
import { roleOption } from '@/enums';
import { SelectBranch } from '../common/Selectors/SelectBranch';

interface LeadFormProps {
  form: any;
  loading: boolean;
  handleSubmit: (values: any) => Promise<void>;
  onCancel?: () => void;
}

const UserForm: React.FC<LeadFormProps> = ({
  form,
  loading,
  handleSubmit,
  onCancel,
}) => {
  const handleFormSubmit = async (values: any) => {
    console.log(values);
    handleSubmit(values);
  };

  return (
    <Spin spinning={loading}>
      <Form form={form} layout='vertical' onFinish={handleFormSubmit}>
        <div className='flex flex-row gap-3'>
          <Form.Item name='id' hidden></Form.Item>
          <Form.Item
            label='Full Name'
            name='fullName'
            className='w-1/2'
            rules={[{ required: true, message: 'Please enter full name' }]}
          >
            <Input placeholder='Enter full name' />
          </Form.Item>

          <Form.Item
            label='Email'
            name='email'
            className='w-1/2'
            rules={[{ required: true, message: 'Please enter email' }]}
          >
            <Input placeholder='Enter email' />
          </Form.Item>
        </div>

        <div className='flex flex-row gap-3'>
          <Form.Item
            label='Phone'
            name='phoneNumber'
            className='w-1/2'
            rules={[{ required: true, message: 'Please enter phone number' }]}
          >
            <Input placeholder='Enter phone number' />
          </Form.Item>

          <Form.Item className='w-1/2' label='Active Status' name='status'>
            <Select
              className='w-full'
              placeholder='Select purpose'
              options={activeStatusOptions}
            />
          </Form.Item>
        </div>

        <div className='flex flex-row gap-3'>
          <Form.Item className='w-1/2' label='Branch' name='branchName'>
            <SelectBranch className='w-full' />
          </Form.Item>
          <Form.Item className='w-1/2' label='User role' name='role'>
            <Select
              className='w-full'
              placeholder='Select role'
              options={roleOption}
              onChange={(value) => {
                form.setFieldValue('role', [value]);
              }}
            />
          </Form.Item>
        </div>
        <div className='flex flex-row justify-center gap-3'>
          <Form.Item>
            <Button type='primary' htmlType='submit'>
              Submit
            </Button>
          </Form.Item>
          <Form.Item>
            <Button onClick={onCancel}>Cancel</Button>
          </Form.Item>
        </div>
      </Form>
    </Spin>
  );
};

export default UserForm;
