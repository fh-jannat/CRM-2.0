import { useUpdateStagelabel } from '@/apis';
import { handleErrorToast } from '@/utils/handleErrorToast';
import { CheckIcon } from '@radix-ui/react-icons';
import { Form, Input } from 'antd';
import React, { useState } from 'react';
import { toast } from 'react-toastify';

interface IStageLabelProps {
  stage: string;
  substage: string;
  substageLabel: string;
}

export const ManageLabelForm: React.FC<IStageLabelProps> = ({
  stage,
  substage,
  substageLabel,
}) => {
  const [form] = Form.useForm();
  const [okButtonDisabled, setOkButtonDisabled] = useState(true);

  const updateSubStageLabel = useUpdateStagelabel();

  const onFinish = async (values: any) => {
    console.log('Finish:', values);
    try {
      await updateSubStageLabel.mutateAsync({
        stage: stage,
        substage: substage,
        substagelabel: values.substageLabel,
      });
      setOkButtonDisabled(true);
      toast.success('Label updated successfully');
    } catch (error) {
      handleErrorToast(error);
    }
  };

  return (
    <Form
      form={form}
      name='horizontal_login'
      layout='inline'
      onFinish={onFinish}
    >
      <Form.Item
        name='stage'
        label={'Stage'}
        rules={[{ required: true, message: 'Please input your username!' }]}
        initialValue={stage}
      >
        <Input placeholder='Stage' disabled />
      </Form.Item>
      <Form.Item
        name='substage'
        initialValue={substage}
        rules={[{ required: true, message: 'Please input substage!' }]}
        hidden={true}
      />

      <Form.Item
        name='substageLabel'
        label={'Sub Stage'}
        initialValue={substageLabel}
        rules={[{ required: true, message: 'Please input substageLabel!' }]}
      >
        <Input
          placeholder='Sub Stage'
          onChange={(event) => {
            if (event.target.value === '') {
              setOkButtonDisabled(true);
            } else if (event.target.value === substageLabel) {
              setOkButtonDisabled(true);
            } else {
              setOkButtonDisabled(false);
            }
          }}
        />
      </Form.Item>
      <Form.Item>
        <button type='submit' disabled={okButtonDisabled}>
          <CheckIcon
            color='green'
            className={`h-8 w-8 ${okButtonDisabled ? 'opacity-20' : ''}`}
          />
        </button>
      </Form.Item>
    </Form>
  );
};
