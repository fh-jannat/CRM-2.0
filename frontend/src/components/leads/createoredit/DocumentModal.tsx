import { useLeadContext } from '@/contexts/AddNewLeadContext';
import { UploadOutlined } from '@ant-design/icons';
import { Button, Input, Modal, ModalProps, Space, Upload } from 'antd';
import React from 'react';
import { toast } from 'react-toastify';

type DocumentModalProps = ModalProps & {
  onCancel?: () => void;
};

const DocumentModal: React.FC<DocumentModalProps> = (props) => {
  const [docName, setDocName] = React.useState<string>('');
  const [link, setLink] = React.useState<string | undefined>('');
  const { setDocuments, documents, onSubmit } = useLeadContext();

  const handleSubmit = async () => {
    const prev = [...documents];
    prev.push({ docName, link: link! });
    setDocuments(prev);
    onSubmit({ documents: prev });
    props.onCancel && props.onCancel();
    toast.success('Document added successfully');
  };

  const handleFileUpload = (info: any) => {
    const { status } = info.file;
    console.log(info);
    if (status === 'done') {
      setLink(`${info.file.response}`);
    }
  };

  return (
    <Modal footer={false} {...props} okText='Submit'>
      <div className='flex flex-col gap-3'>
        <div>Document type</div>
        <Input
          value={docName}
          onChange={(e) => setDocName(e.target.value)}
          size='large'
          placeholder='e.g. SSC/HSC'
        />
        <div>Upload file</div>
        <Upload
          action={`${process.env.NEXT_PUBLIC_API_URI}/api/image/upload`}
          onChange={handleFileUpload}
          maxCount={1}
          multiple={false}
          accept='.pdf'
        >
          <Button block size='large' icon={<UploadOutlined />}>
            Click to upload
          </Button>
        </Upload>
        {link && docName && (
          <Space>
            <Button onClick={props.onCancel}>Cancel</Button>
            <Button type='primary' onClick={handleSubmit}>
              Submit
            </Button>
          </Space>
        )}
      </div>

      {/* https://saascrm.factoryze.tech/api/image/upload/crm/223836d0-a542-4d70-ba7b-f9dfe09af37d-BS1558_Updated_CV.pdf */}
    </Modal>
  );
};

export default DocumentModal;
