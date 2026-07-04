'use client';
import { Button, Form, FormInstance, Input, Spin } from 'antd';
import React from 'react';

interface MetacridentialFormProps {
  form: FormInstance;
  onSubmit: (values: any) => void;
  loading: boolean;
  onCancel?: () => void;
}

export const MetacridentialForm: React.FC<MetacridentialFormProps> = ({
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
          label='App Id'
          name='appId'
          rules={[{ required: true, message: 'Please enter app id' }]}
        >
          <Input placeholder='app id' />
        </Form.Item>

        <Form.Item
          label='App Secret'
          name='appSecret'
          rules={[{ required: true, message: 'Please enter app secret' }]}
        >
          <Input placeholder='app secret' />
        </Form.Item>

        <Form.Item
          label='Page Id'
          name='pageId'
          rules={[{ required: true, message: 'Please enter page id' }]}
        >
          <Input placeholder='page id' />
        </Form.Item>

        <Form.Item
          label='Access Token'
          name='pageAccessToken'
          rules={[{ required: true, message: 'Please enter Access Token' }]}
        >
          <Input placeholder='page access token' />
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
