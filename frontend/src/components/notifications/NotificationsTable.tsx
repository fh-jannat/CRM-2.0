'use client';
import { Select, Spin, Table, TableColumnsType, Tag } from 'antd';
import dayjs from 'dayjs';
import { useEffect, useState } from 'react';
import ActionButton from '../common/ActionButton';
import { AppPagination } from '../common/AppPagination';
import Link from 'next/link';
import {
  useGetAllNotifications,
  useGetNotificationCount,
  useUpdateNotification,
} from '@/apis';
import { CheckCircleTwoTone, SearchOutlined } from '@ant-design/icons';

const NotificationsTable = () => {
  const [pageNo, setPageNo] = useState<number>(1);
  const [pageSize, setPageSize] = useState<number>(10);

  const [searchParams, setSearchParams] = useState<{ [key: string]: any }>({});

  const [query, setQuery] = useState<any>({
    query: {
      page: pageNo,
      limit: pageSize,
      where: { ...searchParams },
    },
  });
  const { data, refetch, isLoading } = useGetAllNotifications(query);
  const { data: count, refetch: refetchCount } = useGetNotificationCount(query);
  const updateNotification = useUpdateNotification();

  useEffect(() => {
    setQuery({
      query: {
        page: pageNo,
        limit: pageSize,
        where: { ...searchParams },
      },
    });
  }, [count, pageNo, pageSize, searchParams]);

  const handleSearch = (columnName: string, value: any) => {
    setSearchParams({ ...searchParams, [columnName]: value });
    setQuery({
      query: {
        page: pageNo,
        limit: pageSize,
        where: {
          ...searchParams,
          [columnName]: value,
        },
      },
    });
  };

  const columns: TableColumnsType<any> = [
    {
      title: 'Sl',
      render: (_, __, index) => (pageNo - 1) * pageSize + (index + 1),
    },
    {
      title: 'Title',
      dataIndex: 'message',
    },
    {
      title: 'Link',
      dataIndex: 'url',
      render: (_, { url }) => <Link href={`/${url}`}>{`${url}`}</Link>,
    },
    {
      title: 'Read',
      dataIndex: 'isRead',
      render: (_, { isRead }) =>
        isRead ? (
          <Tag color='green'>{'Read'}</Tag>
        ) : (
          <Tag color='volcano'>{'Unread'}</Tag>
        ),
      filterIcon: searchParams?.isRead ? (
        <CheckCircleTwoTone />
      ) : (
        <SearchOutlined />
      ),
      filterDropdown: (
        <Select
          options={[
            { value: true, label: 'Read' },
            { value: false, label: 'Unread' },
          ]}
          style={{ width: '100%' }}
          onChange={(value) => handleSearch('isRead', value)}
          placeholder='Search by type'
        />
      ),
    },
    {
      title: 'Created On',
      render: (record) => (
        <>{dayjs(record.createdAt).format('MMM D, YYYY h:mm A')}</>
      ),
    },

    {
      title: 'Actions',
      width: '100px',
      render: (_, record) => (
        <div className='flex flex-row gap-1'>
          <ActionButton.MarkAsRead
            disabled={record.isRead}
            onClick={async () => {
              if (record.isRead) {
                return;
              }
              await updateNotification.mutateAsync({
                id: record.id,
              });
              await refetch();
              await refetchCount();
            }}
          />
        </div>
      ),
    },
  ];

  return (
    <div className='relative flex w-full flex-col'>
      <div className='mt-[20px]'>
        <div className='mx-auto mt-4 flex flex-col overflow-y-scroll'>
          <Table
            scroll={{ x: 1300 }}
            columns={columns}
            pagination={false}
            dataSource={data}
            loading={{
              indicator: (
                <div>
                  <Spin />
                </div>
              ),
              spinning: isLoading,
            }}
            className='border border-slate-200'
          />
        </div>
        <AppPagination
          pageNo={pageNo}
          pageSize={pageSize}
          total={count}
          setPageSize={setPageSize}
          setPageNo={(value: number) => setPageNo(value)}
        />
      </div>
    </div>
  );
};

export default NotificationsTable;
