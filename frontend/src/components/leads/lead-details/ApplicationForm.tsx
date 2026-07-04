'use client';
import { Button, Form, FormInstance, Input, Select } from 'antd';
import React from 'react';
import SelectYear from '@/components/common/Selectors/SelectYear';
import SelectMonth from '@/components/common/Selectors/SelectMonth';
import { useGetUnivesityOption } from '@/apis/univesity';
import { applicationStatusOption } from '@/enums';

interface TaskAssignFormProps {
  form: FormInstance;
  onSubmit: (values: any) => void;
  onCancel?: () => void;
}

export const ApplicationForm: React.FC<TaskAssignFormProps> = ({
  onCancel,
  form,
  onSubmit,
}) => {
  const { data: universityOption } = useGetUnivesityOption();

  const handleSubmit = async (values: any) => {
    onSubmit(values);
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
        label='Course Label'
        name='courseLabel'
        rules={[{ required: true, message: 'Please enter course label name' }]}
      >
        <Input placeholder='Enter course label' />
      </Form.Item>

      <Form.Item
        name={'universityId'}
        rules={[
          {
            required: true,
            message: 'Please select a university',
          },
        ]}
        style={{ flex: 1 }}
      >
        <Select
          placeholder='Select university'
          options={universityOption}
          style={{ width: '100%' }}
        />
      </Form.Item>

      <Form.Item
        name={'applicationStatus'}
        rules={[
          {
            required: true,
            message: 'Please select a status',
          },
        ]}
        style={{ flex: 1 }}
      >
        <Select
          placeholder='Select status'
          options={applicationStatusOption}
          style={{ width: '100%' }}
        />
      </Form.Item>

      <Form.Item label='Intake Year' name={'intakeYear'} required>
        <SelectYear placeholder='Select year' />
      </Form.Item>
      <Form.Item label='Intake Month' name={'intakeMonth'} required>
        <SelectMonth placeholder='Select month' />
      </Form.Item>

      <Form.Item
        label='Course Details'
        name='courseDetails'
        rules={[
          { required: true, message: 'Please enter task course details' },
        ]}
      >
        <Input.TextArea rows={4} placeholder='Enter task details' />
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
  );
};
