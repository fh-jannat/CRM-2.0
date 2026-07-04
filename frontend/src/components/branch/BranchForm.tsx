'use client';
import { Button, Form, FormInstance, Input, Spin } from 'antd';
import React from 'react';

interface BranchFormProps {
  form: FormInstance;
  onSubmit: (values: any) => void;
  loading: boolean;
  onCancel?: () => void;
}

export const BranchForm: React.FC<BranchFormProps> = ({
  onCancel,
  form,
  onSubmit,
  loading,
}) => {
  const handleSubmit = async (values: any) => {
    onSubmit(values);
  };

  return (
    <Spin spinning={loading}>
      <Form
        form={form}
        layout='vertical'
        onFinish={handleSubmit}
        onFinishFailed={(error) => {
          console.log(error);
        }}
      >
        <Form.Item name={'id'} hidden />

        <Form.Item
          label='Branch Name'
          name='branch'
          rules={[{ required: true, message: 'Please enter branch name' }]}
        >
          <Input placeholder='Enter branch name' />
        </Form.Item>

        <Form.Item
          label='Branch Details'
          name='details'
          rules={[{ required: true, message: 'Please enter branch details' }]}
        >
          <Input.TextArea rows={4} placeholder='Enter branch details' />
        </Form.Item>

        <div
          style={{ display: 'flex', justifyContent: 'center' }}
          className='space-x-4'
        >
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
