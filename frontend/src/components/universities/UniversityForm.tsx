'use client';
import { Button, Form, FormInstance, Input, Select, Spin } from 'antd';
import React from 'react';
import { countryOption } from '@/enums';

interface UniversityFormProps {
  form: FormInstance;
  onSubmit: (values: any) => void;
  loading: boolean;
  onCancel?: () => void;
}

export const UniversityForm: React.FC<UniversityFormProps> = ({
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
          label='University Name'
          name='universityName'
          rules={[{ required: true, message: 'Please enter university name' }]}
        >
          <Input placeholder='Enter university name' />
        </Form.Item>

        <Form.Item
          label='Country'
          name='country'
          rules={[{ required: true, message: 'Please enter country name' }]}
        >
          <Select
            showSearch
            placeholder='Select country'
            options={countryOption}
          />
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
