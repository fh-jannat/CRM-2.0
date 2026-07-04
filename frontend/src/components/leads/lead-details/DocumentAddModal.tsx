import { useUpdateLead } from '@/apis';
import { handleErrorToast } from '@/utils';
import { UploadOutlined } from '@ant-design/icons';
import { Button, Input, Modal, Space, Upload } from 'antd';
import React, { useState } from 'react';
import { toast } from 'react-toastify';

type DocumentModalProps = {
  leadId: string;
  data: any;
  refetch: () => Promise<any>;
};

export const AddDocumentModal: React.FC<DocumentModalProps> = ({
  leadId,
  refetch,
  data,
}) => {
  const [docName, setDocName] = useState<string>('');
  const [link, setLink] = useState<string | undefined>('');
  const [open, setOpen] = useState<boolean>(false);

  const updateLead = useUpdateLead();

  const handleSubmit = async () => {
    try {
      await updateLead.mutateAsync({
        id: leadId,
        documents: [
          ...data,
          {
            docName,
            link,
          },
        ],
      });
      await refetch();
      toast.success('Document added successfully');
      setDocName('');
      setLink(undefined);
      setOpen(false);
    } catch (error) {
      handleErrorToast(error);
    }
  };

  const handleFileUpload = (info: any) => {
    const { status } = info.file;
    console.log(info);
    if (status === 'done') {
      setLink(`${info.file.response}`);
    }
  };

  return (
    <>
      <div className='flex justify-center pt-2'>
        <Button type='primary' onClick={() => setOpen(true)}>
          Add Document
        </Button>
      </div>
      <Modal
        footer={false}
        open={open}
        onCancel={() => {
          setOpen(false);
          setLink(undefined);
          setDocName('');
        }}
        okText='Submit'
      >
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
              <Button>Cancel</Button>
              <Button type='primary' onClick={handleSubmit}>
                Submit
              </Button>
            </Space>
          )}
        </div>
      </Modal>
    </>
  );
};
