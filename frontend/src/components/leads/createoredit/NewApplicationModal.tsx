import SelectMonth from '@/components/common/Selectors/SelectMonth';
import SelectYear from '@/components/common/Selectors/SelectYear';
import { useLeadContext } from '@/contexts/AddNewLeadContext';
import { ApplicationType } from '@/types';
import { Button, Form, Input, Modal, ModalProps, Select, Space } from 'antd';
import React, { useEffect } from 'react';
import { toast } from 'react-toastify';

type NewApplicationModalProps = ModalProps & {
  onCancel?: () => void;
  application?: ApplicationType;
};
const NewApplicationModal: React.FC<NewApplicationModalProps> = (props) => {
  const [form] = Form.useForm();
  const { setApplications, applications } = useLeadContext();
  useEffect(() => {
    if (props.application) {
      form.setFieldsValue(props.application);
    }
  }, [props.application]);
  const handleSubmit = (values: any) => {
    console.log(values);
    const prev = [...applications];
    prev.push(values);
    setApplications(prev);
    props.onCancel && props.onCancel();
    toast.success('Application added successfully');
  };
  return (
    <Modal {...props} footer={false}>
      <Form onFinish={handleSubmit} form={form} layout='vertical'>
        <Form.Item name={'courseLabel'} label='Course Label' required>
          <Input />
        </Form.Item>
        <Form.Item label='University' name={'universityId'} required>
          <Select
            placeholder='Select University'
            options={[
              { label: 'Dhaka University', value: 1 },
              { label: 'CU', value: 2 },
              { label: 'BUET', value: 3 },
            ]}
          />
        </Form.Item>
        <Form.Item label='Intake Year' name={'intakeYear'} required>
          <SelectYear placeholder='Select year' />
        </Form.Item>
        <Form.Item label='Intake Month' name={'intakeMonth'} required>
          <SelectMonth placeholder='Select month' />
        </Form.Item>
        <Form.Item label='Course Details' name={'courseDetails'}>
          <Input.TextArea placeholder='Course Details' />
        </Form.Item>
        <Space>
          <Button onClick={props.onCancel}>Cancel</Button>
          <Button htmlType='submit' type='primary'>
            Submit
          </Button>
        </Space>
      </Form>
    </Modal>
  );
};

export default NewApplicationModal;
