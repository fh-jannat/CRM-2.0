'use client';
import {
  Button,
  DatePicker,
  Form,
  FormInstance,
  Input,
  Select,
  Spin,
} from 'antd';
import React from 'react';
import SelectAssignee from '../common/SelectAssignee';
import { Role, taskStatusOption } from '@/enums';
import { useGetRolesQuery } from '@/apis';

interface TaskAssignFormProps {
  form: FormInstance;
  onSubmit: (values: any) => void;
  loading: boolean;
  onCancel?: () => void;
}

const TaskAssignForm: React.FC<TaskAssignFormProps> = ({
  onCancel,
  form,
  onSubmit,
  loading,
}) => {
  const handleSubmit = async (values: any) => {
    values.startDate = values.start_date[0].toISOString();
    values.endDate = values.start_date[1].toISOString();
    onSubmit(values);
  };

  const { data: roles } = useGetRolesQuery();

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
          label='Assigned To'
          name='assigned'
          rules={[{ required: true, message: 'Please enter assigne' }]}
        >
          <SelectAssignee
            stage='all'
            branchSpecificApplication={[Role.MANAGER].some((role) =>
              roles?.includes(role)
            )}
          />
        </Form.Item>

        <Form.Item
          label='Task Name'
          name='task'
          rules={[{ required: true, message: 'Please enter task name' }]}
        >
          <Input placeholder='Enter task name' />
        </Form.Item>

        <Form.Item
          label='Task Details'
          name='description'
          rules={[{ required: true, message: 'Please enter task details' }]}
        >
          <Input.TextArea rows={4} placeholder='Enter task details' />
        </Form.Item>

        <Form.Item
          label='Task Status'
          name='status'
          rules={[{ required: true, message: 'Please enter task status' }]}
        >
          <Select options={taskStatusOption} />
        </Form.Item>

        <Form.Item
          label='Start Date'
          name='start_date'
          rules={[{ required: true, message: 'Please select start date' }]}
        >
          <DatePicker.RangePicker showTime className='w-full' />
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

export default TaskAssignForm;
