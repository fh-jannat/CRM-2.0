import { useLeadContext } from '@/contexts/AddNewLeadContext';
import React from 'react';
import { Button, Form, Input } from 'antd';
import { PlusOutlined } from '@ant-design/icons';
import { SelectPreviousYear } from '@/components/common/Selectors/SelectPreviousYear';

const PreviousEducationHistoryForm = () => {
  const { form, onSubmit } = useLeadContext();

  const handlePrevEducationSave = async () => {
    try {
      const totalFieldsGroup = form.getFieldValue('previousEducations').length;
      for (let i = 0; i < totalFieldsGroup; i++) {
        form.validateFields([
          ['previousEducations', i, 'name'],
          ['previousEducations', i, 'year'],
          ['previousEducations', i, 'result'],
        ]);
      }
      const values = await form.validateFields([
        'fullName',
        'email',
        'previousEducations',
      ]);
      console.log('values', values);
      if (!values.errorFields) onSubmit(values);
    } catch (error) {
      console.log(error);
    }
  };

  return (
    <div>
      <Form.List name='previousEducations'>
        {(fields, { add, remove }) => (
          <>
            {fields.map(({ key, name, fieldKey, ...restField }) => (
              <div
                key={key}
                style={{ marginBottom: 8 }}
                className='flex flex-wrap items-center gap-3'
              >
                <Form.Item
                  {...restField}
                  name={[name, 'name']}
                  fieldKey={fieldKey}
                  rules={[{ required: true, message: 'Name is required' }]}
                  label='Qualification'
                >
                  <Input placeholder='Enter name' />
                </Form.Item>
                <Form.Item
                  {...restField}
                  name={[name, 'year']}
                  fieldKey={fieldKey}
                  rules={[{ required: true, message: 'Year is required' }]}
                  label='Year'
                >
                  <SelectPreviousYear placeholder='Select Year' />
                </Form.Item>
                <Form.Item
                  {...restField}
                  name={[name, 'result']}
                  fieldKey={fieldKey}
                  rules={[{ required: true, message: 'Result is required' }]}
                  label='Result'
                >
                  <Input placeholder='Enter result' />
                </Form.Item>
                <Button type='link' onClick={() => remove(name)}>
                  Remove
                </Button>
              </div>
            ))}
            <Form.Item>
              <Button
                type='dashed'
                onClick={() => add()}
                icon={<PlusOutlined />}
              >
                Add Education
              </Button>
            </Form.Item>
          </>
        )}
      </Form.List>
      <Button type='primary' onClick={handlePrevEducationSave}>
        Save
      </Button>
    </div>
  );
};

export default PreviousEducationHistoryForm;
