'use client';
import { useLeadContext } from '@/contexts/AddNewLeadContext';
import React, { useState } from 'react';
import DocumentModal from './DocumentModal';
import { Button, message } from 'antd';
import { PlusOutlined } from '@ant-design/icons';
import DocumentCard from './DocumentCard';

const DocumentList = () => {
  const { documents, onSubmit } = useLeadContext();
  const [openNewDocumentModal, setOpenNewDocumentModal] =
    useState<boolean>(false);

  const handleDocumentsSubmit = () => {
    if (documents.length > 0) onSubmit({ documents });
    else message.error('Please add atleast one document');
  };

  return (
    <div>
      {documents?.length <= 0 ? (
        <div className='flex h-[100px] w-full items-center justify-center'>
          No documets yet......
        </div>
      ) : (
        <div className='flex flex-col gap-2'>
          {documents?.map((doc, index) => (
            <DocumentCard
              key={index}
              name={doc.docName}
              id={doc.id}
              link={doc.link}
            />
          ))}
        </div>
      )}
      {openNewDocumentModal && (
        <DocumentModal
          open={openNewDocumentModal}
          onCancel={() => setOpenNewDocumentModal(false)}
        />
      )}

      <Button
        style={{ width: 'fit-content', marginTop: '20px' }}
        type='dashed'
        size='large'
        onClick={() => setOpenNewDocumentModal(true)}
        icon={<PlusOutlined />}
      >
        Add Document
      </Button>
      <Button type='primary' onClick={handleDocumentsSubmit}>
        Save
      </Button>
    </div>
  );
};

export default DocumentList;
