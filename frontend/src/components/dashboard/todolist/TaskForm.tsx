import { Button, DatePicker, Form, Input, Modal, Select } from 'antd';
import React from 'react';

interface TaskFormProps {
  visible: boolean;
  users: Array<{ name: string; role: string }>;
  onCancel: () => void;
  onOk: (values: any) => void;
}

const TaskForm: React.FC<TaskFormProps> = ({
  visible,
  onCancel,
  onOk,
  users,
}) => {
  const [form] = Form.useForm();

  const handleSave = () => {
    form
      .validateFields()
      .then((values) => {
        onOk(values);
        form.resetFields();
      })
      .catch((error) => console.error('Validation failed:', error));
  };
  const { Option } = Select;

  return (
    <Modal
      title='New Task'
      style={{ textAlign: 'center' }}
      visible={visible}
      onCancel={onCancel}
      footer={[
        <Button key='cancel' onClick={onCancel}>
          Cancel
        </Button>,
        <Button key='save' type='primary' onClick={handleSave}>
          Save
        </Button>,
      ]}
    >
      <Form form={form} layout='vertical'>
        <Form.Item
          name='assigned'
          label='Assign Person'
          rules={[{ required: true, message: 'Please select assign person!' }]}
        >
          <Select defaultValue='All' style={{ textAlign: 'left' }}>
            <Option value='All'>All Task</Option>
            {users.map((option) => (
              <Option key={option.name} value={option.name}>
                {option.name} ({option.role})
              </Option>
            ))}
          </Select>
        </Form.Item>
        <Form.Item
          name='task'
          label='Task Name'
          rules={[{ required: true, message: 'Please input task name!' }]}
        >
          <Input />
        </Form.Item>
        <Form.Item name='taskDetails' label='Task Details'>
          <Input.TextArea />
        </Form.Item>
        <Form.Item>
          <Form.Item
            name='from'
            label='Start Time'
            style={{ display: 'inline-block', width: 'calc(50% - 8px)' }}
            rules={[{ required: true, message: 'Please select start time!' }]}
          >
            <DatePicker showTime format='YYYY-MM-DD HH:mm' />
          </Form.Item>

          <Form.Item
            name='to'
            label='End Time'
            style={{ display: 'inline-block', width: 'calc(50% - 8px)' }}
            rules={[{ required: true, message: 'Please select end time!' }]}
          >
            <DatePicker showTime format='YYYY-MM-DD HH:mm' />
          </Form.Item>
        </Form.Item>
      </Form>
    </Modal>
  );
};

export default TaskForm;
