import React, { useState } from 'react';
import { Button, Form, Input, Modal } from 'antd';
import { AppQuillInput } from '../common/inputs';
import { useSendEmail } from '@/apis';
import { toast } from 'react-toastify';

interface SendMailProps {
  email: string;
}

export const SendMail: React.FC<SendMailProps> = ({ email }) => {
  const [form] = Form.useForm();
  const [openModal, setOpenModal] = useState<boolean>(false);

  const sendEmail = useSendEmail();

  const onFinish = async (values: any) => {
    if (!email) {
      toast.error('Email not found');
      return;
    }
    try {
      await sendEmail.mutateAsync({ ...values, to: email });
      toast.success('Email sent successfully');
      setOpenModal(false);
    } catch (e) {
      toast.error('Something went wrong');
    }
  };

  return (
    <>
      <div className='m-2 flex justify-end rounded-xl'>
        <Button onClick={() => setOpenModal(true)} type='primary'>
          Send email
        </Button>
      </div>
      <Modal
        title={
          <div className='flex justify-center'>{`Send Mail to ${email}`}</div>
        }
        open={openModal}
        onCancel={() => {
          form.resetFields();
          setOpenModal(false);
        }}
        footer={false}
      >
        <Form form={form} layout='vertical' onFinish={onFinish}>
          <Form.Item
            label='Subject'
            name='subject'
            rules={[{ required: true, message: 'Please enter subject' }]}
          >
            <Input placeholder='Enter subject' />
          </Form.Item>
          <Form.Item
            label='Body'
            name='text'
            rules={[{ required: true, message: 'Please enter body' }]}
          >
            <AppQuillInput />
          </Form.Item>
          <Form.Item className='flex w-full justify-center'>
            <Button type='primary' htmlType='submit'>
              Send
            </Button>
          </Form.Item>
        </Form>
      </Modal>
    </>
  );
};
