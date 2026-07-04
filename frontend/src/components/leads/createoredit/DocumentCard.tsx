import UsernameWithIcon from '@/components/common/UsernameWithIcon';
import { useLeadContext } from '@/contexts/AddNewLeadContext';
import { DeleteOutlined } from '@ant-design/icons';
import { Button } from 'antd';
import React from 'react';

type DocumentCardProps = {
  id?: number;
  name: string;
  icon?: string;
  link?: string;
};

const DocumentCard: React.FC<DocumentCardProps> = (props) => {
  const { setDocuments, documents } = useLeadContext();

  const removeDocument = () => {
    if (props?.id) {
      // call document delete api
      const prev = documents.filter((doc) => doc.id !== props.id);
      setDocuments(prev);
    } else {
      const prev = documents.filter((doc) => doc.docName !== props.name);
      setDocuments(prev);
    }
  };

  return (
    <div className='border-offWhite3 flex max-w-[300px] flex-row justify-between rounded-[6px] border-[1px] bg-white px-[14px] py-[10px]'>
      <a href={`${process.env.NEXT_PUBLIC_OBJECT_STORAGE}${props.link}`}>
        <UsernameWithIcon
          shape='square'
          iconUrl={props?.icon ?? '/PDF.svg'}
          name={props.name}
          fontColor='#545F71'
        />
      </a>
      <Button
        onClick={() => removeDocument()}
        type='text'
        size='small'
        icon={<DeleteOutlined className='text-red' />}
      />
    </div>
  );
};

export default DocumentCard;
