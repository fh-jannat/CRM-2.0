import React from 'react';
import { Form, Input, Button } from 'antd';

interface SendMailFormProps {
  receiverEmail: string;
  onCancel: () => void;
}

const SendMailForm: React.FC<SendMailFormProps> = ({
  receiverEmail,
  onCancel,
}) => {
  const onFinish = async (values: any) => {
    console.log({ values });
  };
  return (
    <Form onFinish={onFinish} layout='vertical'>
      <Form.Item
        label='To'
        name='to'
        initialValue={receiverEmail}
        rules={[
          {
            required: true,
            message: 'Please enter the recipient email address',
          },
        ]}
      >
        <Input value={receiverEmail} />
      </Form.Item>

      <Form.Item
        label='Subject'
        name='subject'
        rules={[{ required: true, message: 'Please enter the email subject' }]}
      >
        <Input placeholder='Email subject goes here' />
      </Form.Item>

      <Form.Item
        label='Body'
        name='body'
        rules={[{ required: true, message: 'Please enter the email body' }]}
      >
        <Input.TextArea placeholder='Email body goes here' rows={5} />
      </Form.Item>
      <div className='flex flex-row justify-center gap-3'>
        <Form.Item>
          <Button type='primary' htmlType='submit'>
            Send
          </Button>
        </Form.Item>
        <Form.Item>
          <Button onClick={onCancel}>Cancel</Button>
        </Form.Item>
      </div>
    </Form>
  );
};

export default SendMailForm;
