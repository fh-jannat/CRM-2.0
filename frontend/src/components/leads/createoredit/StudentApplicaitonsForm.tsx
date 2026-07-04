import { DatePicker, Form, Input, Select } from 'antd';
import React from 'react';

const StudentApplicaitonsForm = () => {
  return (
    <div className='flex flex-wrap gap-3'>
      <Form.Item
        className='w-full md:max-w-[320px]'
        label='University'
        name={'university'}
        rules={[{ required: false, message: 'University is required' }]}
      >
        <Select size='large' placeholder='Select University' />
      </Form.Item>

      <Form.Item
        className='w-full md:max-w-[320px]'
        label='Course'
        name={'course'}
        rules={[{ required: true, message: 'Course is required' }]}
      >
        <Input size='large' />
      </Form.Item>

      <Form.Item
        className='w-full md:max-w-[320px]'
        label='Courses'
        name={'passigYear'}
        rules={[{ required: true, message: 'Passing year is required' }]}
      >
        <DatePicker
          picker='year'
          className='w-full md:max-w-[320px]'
          size='large'
        />
      </Form.Item>
      <Form.Item
        className='w-full md:max-w-[320px]'
        label='Passing Month'
        name={'passingMonth'}
        rules={[{ required: true, message: 'Passing month is required' }]}
      >
        <DatePicker
          picker='month'
          className='w-full md:max-w-[320px]'
          size='large'
        />
      </Form.Item>

      {/* 1. University dropdown
      2. courses (text)
      3. Intake(Year)
      4. Intake(Month) */}
    </div>
  );
};

export default StudentApplicaitonsForm;
