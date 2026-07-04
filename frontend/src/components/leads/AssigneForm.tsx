'use client';
import SelectAssignee from '@/components/common/SelectAssignee';
import { Button, Form, FormInstance } from 'antd';
import React from 'react';

interface AssigneFormFormProps {
  form: FormInstance;
  onSubmit: (data?: any) => void;
}
export const AssigneFormForm: React.FC<AssigneFormFormProps> = ({
  form,
  onSubmit,
}) => {
  const onFinish = async (data: any) => {
    onSubmit(data);
  };

  return (
    <Form form={form} onFinish={onFinish} layout='vertical'>
      <div className='flex w-full flex-col items-center justify-center gap-4'>
        <Form.Item
          className='w-full'
          label='Assignees'
          name={'assignedTo'}
          rules={[{ required: true, message: 'Please select assignee' }]}
          style={{
            textTransform: 'capitalize',
          }}
        >
          <SelectAssignee
            stage={'lead'}
            size='large'
            placeholder='Select assignee'
          />
        </Form.Item>

        <Form.Item>
          <Button
            type='primary'
            onClick={() => {
              form.submit();
            }}
          >
            Submit
          </Button>
        </Form.Item>
      </div>
    </Form>
  );
};
