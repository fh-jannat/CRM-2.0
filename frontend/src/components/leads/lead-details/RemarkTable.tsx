import { Table, TableColumnsType } from 'antd';
import dayjs from 'dayjs';

interface RemarkTableProps {
  data: any;
}

export const RemarkTable: React.FC<RemarkTableProps> = ({ data }) => {
  const columns: TableColumnsType<any> = [
    {
      title: 'Sl',
      render: (_, __, index) => index + 1,
    },
    {
      title: 'Remark',
      dataIndex: 'remark',
    },
    {
      title: 'Created On',
      render: (record) => (
        <>{dayjs(record.createdAt).format('MMM D, YYYY h:mm A')}</>
      ),
    },
  ];

  if (!data) {
    return <></>;
  }

  return (
    <>
      <Table
        columns={columns}
        pagination={false}
        dataSource={[...data].reverse()}
        className='border border-slate-200'
      />
    </>
  );
};
