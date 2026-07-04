import React from 'react';
import { Modal, Form, Input, Button } from 'antd';

interface CreateAdminFormProps {
  visible: boolean;
  onCancel: () => void;
  onOk: (values: any) => void; // Add onOk function prop
}

const CreateAdminForm: React.FC<CreateAdminFormProps> = ({
  visible,
  onCancel,
  onOk, // Destructure onOk function from props
}) => {
  const [form] = Form.useForm();

  const handleOk = () => {
    form
      .validateFields()
      .then((values) => {
        onOk(values); // Call onOk function with form values
        form.resetFields();
      })
      .catch((error) => console.error('Validation failed:', error));
  };

  return (
    <Modal
      title='Add Admin'
      visible={visible}
      onCancel={onCancel}
      footer={[
        <Button key='cancel' onClick={onCancel}>
          Cancel
        </Button>,
        <Button key='save' type='primary' onClick={handleOk}>
          {' '}
          {/* Use handleOk function */}
          Save
        </Button>,
      ]}
    >
      <Form form={form} layout='vertical'>
        <Form.Item
          name='name'
          label='Name'
          rules={[{ required: true, message: 'Please input admin name!' }]}
        >
          <Input />
        </Form.Item>
        <Form.Item
          name='email'
          label='Email'
          rules={[{ required: true, message: 'Please input admin email!' }]}
        >
          <Input />
        </Form.Item>
        <Form.Item
          name='phoneNumber'
          label='Phone Number'
          rules={[
            { required: true, message: 'Please input admin phone number!' },
          ]}
        >
          <Input />
        </Form.Item>
      </Form>
    </Modal>
  );
};

export default CreateAdminForm;
