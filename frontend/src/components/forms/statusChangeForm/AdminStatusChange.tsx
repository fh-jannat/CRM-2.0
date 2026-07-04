'use client';
import { useUpdateLeadStage } from '@/apis';
import SelectStage from '@/components/common/SelectStage';
import SelectSubStage from '@/components/common/SelectSubStage';
import { ArrowDownOutlined } from '@ant-design/icons';
import { Button, Form, Input } from 'antd';
import React, { useState } from 'react';

interface AdminStatusChangeProps {
  id?: string;
  currentStage: string;
  currentSubStage: string;
  onSubmit?: (data?: any) => void;
}

export const AdminStatusChange: React.FC<AdminStatusChangeProps> = ({
  id,
  currentStage,
  currentSubStage,
  onSubmit,
}) => {
  const [form] = Form.useForm();
  const [stage, setStage] = useState<string>();
  const adminUpdateLeadStage = useUpdateLeadStage();
  const handleSubmit = async (data: any) => {
    console.log(data);
    console.log(id);
    try {
      if (id) {
        await adminUpdateLeadStage.mutateAsync({
          id,
          stage: data.stage,
          subStage: data.subStage,
        });
      }
    } catch (err) {
      console.log(err);
    }
    if (onSubmit) {
      onSubmit();
    }
  };
  return (
    <Form form={form} onFinish={handleSubmit} layout='vertical'>
      <div className='flex w-full flex-col items-center justify-center gap-4'>
        <div className='mb-3 w-full border-[1px] border-gray-200' />
        <div className='flex w-full flex-col gap-4'>
          <div className='w-full text-[1.2rem] font-semibold text-blue-400'>
            Current Status <ArrowDownOutlined />
          </div>
          <div className='flex w-full flex-row gap-3'>
            <Input
              size='large'
              value={`Stage: ${currentStage}`}
              disabled
              className='capitalize'
            />
            <Input
              size='large'
              value={`Sub-stage: ${currentSubStage}`}
              disabled
              className='capitalize'
            />
          </div>
        </div>
        <div className='flex w-full flex-col gap-4'>
          <div className='w-full text-[1.2rem] font-semibold text-blue-400'>
            <div className='mt-4'>
              Change Status To <ArrowDownOutlined />
            </div>
          </div>
        </div>

        <div className='flex w-full flex-row gap-3'>
          <Form.Item
            className='w-full'
            label='Change stage to'
            name={'stage'}
            rules={[{ required: true, message: 'Please select a stage' }]}
          >
            <SelectStage
              size='large'
              onChange={(value) => {
                setStage(value);
              }}
            />
          </Form.Item>
          <Form.Item
            className='w-full'
            label='Change sub stage to'
            name={'subStage'}
            rules={[{ required: true, message: 'Please select a sub stage' }]}
          >
            <SelectSubStage size='large' stage={stage} />
          </Form.Item>
        </div>

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
