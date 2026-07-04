import CountrySelector from '@/components/common/CountrySelector';
import SelectMonth from '@/components/common/Selectors/SelectMonth';
import { SelectPreviousYear } from '@/components/common/Selectors/SelectPreviousYear';
import { useLeadContext } from '@/contexts/AddNewLeadContext';
import { Button, Form, Input } from 'antd';
import { toast } from 'react-toastify';

const LastEducationalInfoForm = () => {
  const { form, onSubmit } = useLeadContext();
  const handleLastEducationSave = async () => {
    try {
      const values = await form.validateFields([
        'fullName',
        ['lastEducation', 'degree'],
        ['lastEducation', 'institute'],
        ['lastEducation', 'country'],
        ['lastEducation', 'year'],
        ['lastEducation', 'result'],
        ['lastEducation', 'month'],
      ]);
      console.log({ values });
      if (!values?.errorFields) onSubmit(values);
    } catch (error) {
      toast.error('Error saving last educational info');
      console.log(error);
    }
  };

  return (
    <div>
      <div className='flex flex-wrap gap-3'>
        {/* last educational degree */}
        <Form.Item
          className='w-full md:max-w-[320px]'
          label='Last Educational Qualification'
          name={['lastEducation', 'degree']}
          rules={[
            {
              required: true,
              message: 'Educational Qualificaiton is required',
            },
          ]}
        >
          <Input size='large' placeholder='Type Degree name' />
        </Form.Item>
        {/* Institute */}
        <Form.Item
          className='w-full md:max-w-[320px]'
          label='Institute'
          name={['lastEducation', 'institute']}
          rules={[{ required: true, message: 'Institute is required' }]}
        >
          <Input placeholder='Enter Institute name' size='large' />
        </Form.Item>
        {/* country */}
        <Form.Item
          className='w-full md:max-w-[320px]'
          label='Country of Study'
          name={['lastEducation', 'country']}
          rules={[
            { required: true, message: 'Country of Education is required' },
          ]}
        >
          <CountrySelector placeholder='Select country' size='large' />
        </Form.Item>
        {/* Passing year */}
        <Form.Item
          className='w-full md:max-w-[320px]'
          label='Passing Year'
          name={['lastEducation', 'year']}
          rules={[{ required: true, message: 'Passing year is required' }]}
        >
          <SelectPreviousYear placeholder='Select year' size='large' />
        </Form.Item>
        {/* Passing month */}
        <Form.Item
          className='w-full md:max-w-[320px]'
          label='Passing Month'
          name={['lastEducation', 'month']}
          rules={[{ required: true, message: 'Passing month is required' }]}
        >
          <SelectMonth placeholder='Select month' size='large' />
        </Form.Item>
        {/*  */}
        <Form.Item
          className='w-full md:max-w-[320px]'
          label='Result'
          name={['lastEducation', 'result']}
          rules={[{ required: true, message: 'Passing month is required' }]}
        >
          <Input size='large' />
        </Form.Item>
      </div>
      <Button type='primary' onClick={handleLastEducationSave}>
        Save
      </Button>
    </div>
  );
};

export default LastEducationalInfoForm;
