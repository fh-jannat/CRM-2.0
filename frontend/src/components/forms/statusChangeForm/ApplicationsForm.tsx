import { useGetUnivesityOption } from '@/apis/univesity';
import SelectMonth from '@/components/common/Selectors/SelectMonth';
import SelectYear from '@/components/common/Selectors/SelectYear';
import {
  ArrowDownOutlined,
  MinusCircleOutlined,
  PlusOutlined,
} from '@ant-design/icons';
import { Button, Form, Input, Select } from 'antd';

const ApplicationsForm = () => {
  const { data: universityOption } = useGetUnivesityOption();

  return (
    <div className='flex w-full flex-col gap-3 rounded-[10px] bg-gray-200 p-4'>
      <div className='w-full text-[1.1rem] font-semibold text-primaryColor'>
        Applications <ArrowDownOutlined />
      </div>
      <div className='flex w-full flex-col gap-4'>
        <Form.List name='applications' initialValue={[{}]}>
          {(fields, { add, remove }) => (
            <div className='w-full flex-col gap-2'>
              {fields.map(({ key, name, ...restField }) => (
                <div key={key} className='flex w-full flex-row gap-2'>
                  <div className='flex flex-col'>
                    <div className='flex flex-wrap gap-3 md:flex-row'>
                      <Form.Item
                        {...restField}
                        name={[name, 'status']}
                        hidden
                        initialValue={'pending'}
                      />
                      <Form.Item
                        {...restField}
                        name={[name, 'courseLabel']}
                        rules={[
                          {
                            required: true,
                            message: 'Please enter course label',
                          },
                        ]}
                        style={{ flex: 1 }}
                      >
                        <Input size='large' placeholder='Enter Course label' />
                      </Form.Item>
                      <Form.Item
                        {...restField}
                        name={[name, 'universityId']}
                        rules={[
                          {
                            required: true,
                            message: 'Please select a university',
                          },
                        ]}
                        style={{ flex: 1 }}
                      >
                        <Select
                          placeholder='Select university'
                          showSearch={true}
                          options={universityOption}
                          style={{ width: '100%' }}
                          size='large'
                          filterOption={(input, option) =>
                            (option?.label ?? '')
                              .toString()
                              .toLowerCase()
                              .includes(input.toLowerCase())
                          }
                        />
                      </Form.Item>
                      <Form.Item
                        {...restField}
                        name={[name, 'intakeMonth']}
                        rules={[
                          { required: true, message: 'Please select a month' },
                        ]}
                      >
                        <SelectMonth size='large' placeholder='Select month' />
                      </Form.Item>
                      <Form.Item
                        {...restField}
                        name={[name, 'intakeYear']}
                        rules={[
                          { required: true, message: 'Please select a year' },
                        ]}
                      >
                        <SelectYear size='large' placeholder='Select year' />
                      </Form.Item>
                    </div>
                    <Form.Item
                      {...restField}
                      name={[name, 'courseDetails']}
                      rules={[
                        {
                          required: true,
                          message: 'Please enter course details',
                        },
                      ]}
                    >
                      <Input.TextArea
                        placeholder='Enter course details'
                        rows={3}
                        size='large'
                      />
                    </Form.Item>
                  </div>
                  {fields.length > 1 && (
                    <MinusCircleOutlined
                      disabled={fields.length < 1}
                      onClick={() => remove(name)}
                      style={{
                        color: 'red',
                        fontSize: '16px',
                        marginLeft: '8px',
                      }}
                    />
                  )}
                </div>
              ))}
              <Form.Item>
                <Button
                  type='primary'
                  size='small'
                  block
                  onClick={() => add()}
                  icon={<PlusOutlined />}
                >
                  Add Application
                </Button>
              </Form.Item>
            </div>
          )}
        </Form.List>
      </div>
    </div>
  );
};

export default ApplicationsForm;
