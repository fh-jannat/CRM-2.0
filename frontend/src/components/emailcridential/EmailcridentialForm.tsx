'use client';
import { Button, Form, Input } from 'antd';
import React from 'react';
import { useCreateEmailcridential } from '@/apis';
import { handleErrorToast } from '@/utils';
import { toast } from 'react-toastify';

export const EmailcridentialForm: React.FC = () => {
  const [form] = Form.useForm();

  const createEmailCridential = useCreateEmailcridential();

  const handleSubmit = async (values: any) => {
    try {
      values.smtpUser = values.smtpFrom;
      await createEmailCridential.mutateAsync(values);
      toast.success('Email credential updated successfully');
      form.resetFields();
    } catch (error) {
      handleErrorToast(error);
    }
  };

  return (
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
        label='SMTP Host'
        name='smtpHost'
        rules={[{ required: true, message: 'Please enter smtp host' }]}
      >
        <Input placeholder='smtp host' />
      </Form.Item>

      <Form.Item
        label='SMTP Port'
        name='smtpPort'
        rules={[{ required: true, message: 'Please enter smtp port' }]}
      >
        <Input placeholder='smtp port' />
      </Form.Item>

      <Form.Item
        label='From Email'
        name='smtpFrom'
        rules={[
          { required: true, type: 'email', message: 'Please enter from email' },
        ]}
      >
        <Input placeholder='from email' />
      </Form.Item>

      <Form.Item
        label='SMTP Password'
        name='smtpPassword'
        rules={[{ required: true, message: 'Please enter smtp password' }]}
      >
        <Input placeholder='smtp password' />
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
      </div>
    </Form>
  );
};
