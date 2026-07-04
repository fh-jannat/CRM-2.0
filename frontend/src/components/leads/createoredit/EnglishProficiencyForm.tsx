import { useLeadContext } from '@/contexts/AddNewLeadContext';
import { Button, Form, InputNumber, Select } from 'antd';
import React, { useState } from 'react';

const EnglishProficiencyForm = () => {
  const { form, onSubmit } = useLeadContext();
  const [selectedProficiencyTest, setSelectedProficiencyTest] = useState(
    form.getFieldValue('englishProficiency')
  );
  const handleProficiencySave = async () => {
    try {
      const values = await form.validateFields([
        'fullName',
        'email',
        'englishProficiency',
        ['englishProficiencyResult', 'speaking'],
        ['englishProficiencyResult', 'listening'],
        ['englishProficiencyResult', 'writing'],
        ['englishProficiencyResult', 'reading'],
        ['englishProficiencyResult', 'overall'],
        ['englishProficiencyResult', 'singleScore'],
        ['englishProficiencyResult', 'literacy'],
        ['englishProficiencyResult', 'comprehension'],
        ['englishProficiencyResult', 'conversation'],
        ['englishProficiencyResult', 'production'],
        ['englishProficiencyResult', 'overall'],
        'Literacy',
      ]);
      console.log({ values });
      if (!values?.errorFields) onSubmit(values);
    } catch (error) {
      console.log(error);
    }
  };

  const proficiencyTestOptions = [
    { label: 'IELTS', value: 'IELTS' },
    { label: 'TOEFL', value: 'TOEFL' },
    { label: 'PTE', value: 'PTE' },
    { label: 'OET', value: 'OET' },
    { label: 'CAE', value: 'CAE' },
    { label: 'CPE', value: 'CPE' },
    { label: 'BULATS', value: 'BULATS' },
    { label: 'TOEIC', value: 'TOEIC' },
    { label: 'Linguaskill', value: 'Linguaskill' },
    { label: 'Duolingo', value: 'Duolingo' },
    { label: 'GCSE', value: 'GCSE' },
    { label: 'OIETC', value: 'OIETC' },
    { label: 'Other', value: 'Other' },
  ];

  return (
    <div>
      <div className='flex w-full flex-wrap gap-3'>
        <Form.Item
          className='w-full md:max-w-[320px]'
          label='English Proficiency test'
          name={'englishProficiency'}
          rules={[{ required: true, message: 'Prificiency test is required' }]}
        >
          <Select
            onChange={(value) => setSelectedProficiencyTest(value)}
            options={proficiencyTestOptions}
            size='large'
            placeholder='Select proficiency test'
          />
        </Form.Item>
        {selectedProficiencyTest === 'IELTS' ||
        selectedProficiencyTest === 'PTE' ||
        selectedProficiencyTest === 'OIETC' ||
        selectedProficiencyTest === 'TOEFL' ? (
          <div className='flex flex-1 flex-row gap-2'>
            <Form.Item
              className='w-full'
              label='Speaking'
              name={['englishProficiencyResult', 'speaking']}
              rules={[{ required: true, message: 'score is required' }]}
            >
              <InputNumber
                min={0}
                className='min-w-[200px]'
                size='large'
                placeholder='Speaking score'
                style={{
                  width: '100%',
                }}
              />
            </Form.Item>
            <Form.Item
              className='w-full'
              label='Listening'
              name={['englishProficiencyResult', 'listening']}
              rules={[{ required: true, message: 'score is required' }]}
            >
              <InputNumber
                min={0}
                className='min-w-[200px]'
                size='large'
                placeholder='Listeing score'
                style={{
                  width: '100%',
                }}
              />
            </Form.Item>
            <Form.Item
              className='w-full'
              label='Writting'
              name={['englishProficiencyResult', 'writing']}
              rules={[{ required: true, message: 'score is required' }]}
            >
              <InputNumber
                min={0}
                className='min-w-[200px]'
                size='large'
                placeholder='Writting score'
                style={{
                  width: '100%',
                }}
              />
            </Form.Item>
            <Form.Item
              className='w-full'
              label='Reading'
              name={['englishProficiencyResult', 'reading']}
              rules={[{ required: true, message: 'score is required' }]}
            >
              <InputNumber
                min={0}
                className='min-w-[200px]'
                size='large'
                placeholder='Writting score'
                style={{
                  width: '100%',
                }}
              />
            </Form.Item>
            <Form.Item
              className='w-full'
              label='Overall'
              name={['englishProficiencyResult', 'overall']}
              rules={[{ required: true, message: 'score is required' }]}
            >
              <InputNumber
                min={0}
                className='min-w-[200px]'
                size='large'
                placeholder='Overall score'
                style={{
                  width: '100%',
                }}
              />
            </Form.Item>
          </div>
        ) : selectedProficiencyTest === 'Duolingo' ? (
          <div className='flex flex-1 flex-row gap-2'>
            <Form.Item
              className='w-full'
              label='Literacy'
              name={['englishProficiencyResult', 'literacy']}
              rules={[{ required: true, message: 'score is required' }]}
            >
              <InputNumber
                min={0}
                className='min-w-[200px]'
                size='large'
                placeholder='Literacy score'
                style={{
                  width: '100%',
                }}
              />
            </Form.Item>
            <Form.Item
              className='w-full'
              label='Comprehension'
              name={['englishProficiencyResult', 'comprehension']}
              rules={[{ required: true, message: 'score is required' }]}
            >
              <InputNumber
                min={0}
                className='min-w-[200px]'
                size='large'
                placeholder='Comprehension score'
                style={{
                  width: '100%',
                }}
              />
            </Form.Item>
            <Form.Item
              className='w-full'
              label='Conversation'
              name={['englishProficiencyResult', 'conversation']}
              rules={[{ required: true, message: 'score is required' }]}
            >
              <InputNumber
                min={0}
                className='min-w-[200px]'
                size='large'
                placeholder='Conversation score'
                style={{
                  width: '100%',
                }}
              />
            </Form.Item>
            <Form.Item
              className='w-full'
              label='Production'
              name={['englishProficiencyResult', 'production']}
              rules={[{ required: true, message: 'score is required' }]}
            >
              <InputNumber
                min={0}
                className='min-w-[200px]'
                size='large'
                placeholder='Production score'
                style={{
                  width: '100%',
                }}
              />
            </Form.Item>
            <Form.Item
              className='w-full'
              label='Overall'
              name={['englishProficiencyResult', 'overall']}
              rules={[{ required: true, message: 'score is required' }]}
            >
              <InputNumber
                min={0}
                className='min-w-[200px]'
                size='large'
                placeholder='Overall score'
                style={{
                  width: '100%',
                }}
              />
            </Form.Item>
          </div>
        ) : (
          <>
            {selectedProficiencyTest !== 'Other' && (
              <Form.Item
                className='w-full md:max-w-[320px]'
                label='Result/Score'
                name={['englishProficiencyResult', 'singleScore']}
                rules={[{ required: true, message: 'IELTS score is required' }]}
              >
                <InputNumber
                  min={0}
                  className='min-w-[200px]'
                  size='large'
                  placeholder='Enter IELTS score'
                  style={{
                    width: '100%',
                  }}
                />
              </Form.Item>
            )}
          </>
        )}
      </div>
      <Button type='primary' onClick={handleProficiencySave}>
        Save
      </Button>
    </div>
  );
};

export default EnglishProficiencyForm;
