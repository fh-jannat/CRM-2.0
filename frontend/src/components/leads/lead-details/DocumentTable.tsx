import UsernameWithIcon from '@/components/common/UsernameWithIcon';
import { Table, TableColumnsType } from 'antd';
import { AddDocumentModal } from './DocumentAddModal';

interface DocumentTableProps {
  leadId: string;
  data: any;
  refetch: () => Promise<any>;
}

export const DocumentTable: React.FC<DocumentTableProps> = ({
  leadId,
  data,
  refetch,
}) => {
  const columns: TableColumnsType<any> = [
    {
      title: 'Sl',
      render: (_, __, index) => index + 1,
    },
    {
      title: 'Doc',
      dataIndex: 'docName',
    },
    {
      title: 'Link',
      dataIndex: 'link',
      render: (link, record) => (
        <a
          href={`${process.env.NEXT_PUBLIC_OBJECT_STORAGE}${link}`}
          target='_blank'
        >
          <UsernameWithIcon
            shape='square'
            iconUrl={'/PDF.svg'}
            name={record?.docName}
            fontColor='#545F71'
          />
        </a>
      ),
    },
  ];
  return (
    <>
      <Table
        columns={columns}
        pagination={false}
        dataSource={data}
        className='border border-slate-200'
      />
      <AddDocumentModal leadId={leadId} data={data} refetch={refetch} />
    </>
  );
};
