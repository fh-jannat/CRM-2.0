import {
  ArrowDownOutlined,
  CheckSquareOutlined,
  MinusCircleOutlined,
  PlusOutlined,
  UploadOutlined,
} from '@ant-design/icons';
import { Button, Form, Input, Upload } from 'antd';
import { toast } from 'react-toastify';

const DocumentsForm = () => {
  const form = Form.useFormInstance();
  return (
    <div className='flex w-full flex-col gap-3 rounded-[10px] bg-gray-200 p-4'>
      <div className='w-full text-[1.1rem] font-semibold text-primaryColor'>
        Documents <ArrowDownOutlined />
      </div>
      <div className='flex w-full flex-col gap-4'>
        <Form.List
          name='documents'
          initialValue={[
            { docName: 'Passport' },
            { docName: 'CV' },
            { docName: 'SOP' },
            { docName: 'SSC/O-Level' },
            { docName: 'HSC/A-Level' },
            { docName: 'Bachelor' },
            { docName: 'Masters' },
          ]}
        >
          {(fields, { add, remove }) => (
            <div className='flex w-full flex-col gap-3'>
              {fields.map(({ key, name, ...restField }, index) => (
                <div
                  key={key}
                  className='flex w-full flex-row items-center justify-center gap-3'
                >
                  <Form.Item
                    {...restField}
                    name={[name, 'docName']}
                    rules={[
                      { required: true, message: 'Please input the name' },
                    ]}
                    noStyle
                  >
                    <Input
                      size='large'
                      placeholder='Document name'
                      disabled={index < 1}
                    />
                  </Form.Item>
                  <Form.Item
                    {...restField}
                    name={[name, 'file']}
                    noStyle
                    rules={[
                      { required: true, message: 'Please upload the file' },
                    ]}
                  >
                    <Upload
                      action={`${process.env.NEXT_PUBLIC_API_URI}/api/image/upload`}
                      onChange={(info) => {
                        if (info.file.status === 'done') {
                          form.setFieldValue(
                            ['documents', index, 'link'],
                            info.file.response
                          );
                          toast.success('File uploaded successfully');
                        }
                      }}
                      accept='.pdf'
                      maxCount={1}
                      showUploadList={true}
                    >
                      <Button
                        icon={
                          !form.getFieldValue(['documents', index, 'file']) ? (
                            <UploadOutlined />
                          ) : (
                            <CheckSquareOutlined size={30} />
                          )
                        }
                      >
                        {form.getFieldValue(['documents', index, 'file'])
                          ? 'File Uploaded'
                          : 'Upload File'}
                      </Button>
                    </Upload>
                  </Form.Item>

                  <Button
                    disabled={index < 1}
                    type='text'
                    onClick={() => remove(name)}
                    icon={
                      <MinusCircleOutlined
                        style={{
                          color: index < 1 ? '' : 'red',
                          fontSize: '16px',
                        }}
                      />
                    }
                  />
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
                  Add Another
                </Button>
              </Form.Item>
            </div>
          )}
        </Form.List>
      </div>
    </div>
  );
};

export default DocumentsForm;
