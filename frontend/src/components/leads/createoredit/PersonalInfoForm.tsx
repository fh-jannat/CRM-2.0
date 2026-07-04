import CountrySelector from '@/components/common/CountrySelector';
import { CustomPhoneInput } from '@/components/common/inputs';
import StateSelector from '@/components/common/StateSelector';
import { useLeadContext } from '@/contexts/AddNewLeadContext';
import { countryOption } from '@/enums';
import { Button, Form, Input, Select } from 'antd';
import React, { useEffect } from 'react';

const PersonalInfoForm = () => {
  const { form, onSubmit, countryId, setCountryId } = useLeadContext();

  useEffect(() => {
    form.resetFields(['state', 'details']);
  }, [countryId]);

  const handlePersonalInfoSubmit = async () => {
    try {
      // Validate only the specified fields
      const values = await form.validateFields([
        'fullName',
        'email',
        'phoneNo',
        'country',
        'state',
        'addressDetails',
        'interestedCountry',
      ]);
      console.log({ values });
      if (!values?.errorFields) onSubmit(values);
      // setActiveFormkey('last-educational')
    } catch (error) {
      console.log(error);
    }
  };

  return (
    <div className='flex flex-col'>
      <div className='flex w-full flex-wrap gap-3'>
        <Form.Item
          className='w-full md:max-w-[320px]'
          label='Id'
          name={'id'}
          hidden={true}
        />
        {/* Full Name */}
        <Form.Item
          className='w-full md:max-w-[320px]'
          label='Full Name'
          name={'fullName'}
          rules={[{ required: true, message: 'Full Name is required!' }]}
        >
          <Input size='large' placeholder='Enter full name' />
        </Form.Item>
        {/* Email field */}
        <Form.Item
          className='w-full md:max-w-[320px]'
          label='Email'
          name={'email'}
          rules={[
            { required: true, type: 'email', message: 'Email is required!' },
          ]}
        >
          <Input size='large' type='email' placeholder='Enter email' />
        </Form.Item>
        {/* Phone */}
        <Form.Item
          className='w-full md:max-w-[320px]'
          label='Phone'
          name={'phoneNo'}
          rules={[{ required: true, message: 'Phone number is required!' }]}
        >
          <CustomPhoneInput placeholder='Enter phone number' />
          {/* <Input size='large' type='' placeholder='Enter phone number' /> */}
        </Form.Item>
        {/* country */}
        <Form.Item
          className='w-full md:max-w-[320px]'
          label='Country'
          name={'country'}
          rules={[{ required: true, message: 'Country is required!' }]}
        >
          <CountrySelector
            setSelectCountryId={setCountryId}
            size='large'
            placeholder='Select country'
          />
        </Form.Item>
        {/* state */}
        <Form.Item
          className='w-full md:max-w-[320px]'
          label='State'
          name={'state'}
          // rules={[{ required: true, message: 'Phone number is required' }]}
        >
          <StateSelector
            size='large'
            countryId={countryId}
            placeholder='Select state'
          />
        </Form.Item>
        {/* address details */}
        <Form.Item
          className='w-full md:max-w-[320px]'
          label='Address details'
          name={'addressDetails'}
          rules={[{ required: true, message: 'Address details is required!' }]}
        >
          <Input size='large' placeholder='Enter address details' />
        </Form.Item>
        <Form.Item
          className='w-full md:max-w-[320px]'
          label='Interested Country'
          name={'interestedCountry'}
        >
          <Select
            size='large'
            placeholder='Select interested country'
            options={countryOption}
          />
        </Form.Item>
      </div>
      <Form.Item>
        <Button type='primary' onClick={handlePersonalInfoSubmit}>
          Save
        </Button>
      </Form.Item>
    </div>
  );
};

export default PersonalInfoForm;
