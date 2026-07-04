'use client';
import { useGetRoleOption } from '@/apis';
import {
  CalendarTwoTone,
  CheckCircleTwoTone,
  ReconciliationOutlined,
  SearchOutlined,
  UserOutlined,
} from '@ant-design/icons';
import { Button, Checkbox, Select, Spin, Table, TableColumnsType } from 'antd';
import dayjs from 'dayjs';
import React, { useEffect, useState } from 'react';
import AppTableButton from '../common/AppTableButton';
import TableFilterSearch from '../common/TableFilterSearch';

import UsernameWithIcon from '../common/UsernameWithIcon';
import { roleOption } from '@/enums';
import { useGetAllActivitys } from '@/apis/activity';
import { AppPagination } from '../common/AppPagination';

const AllActivities = () => {
  const [pageNo, setPageNo] = useState<number>(1);
  const [pageSize, setPageSize] = useState<number>(10);

  const [selectedRowKeys, setSelectedRowKeys] = useState<React.Key[]>([]);
  const [searchParams, setSearchParams] = useState<{ [key: string]: any }>({});

  const [query, setQuery] = useState<any>({
    query: {
      page: pageNo,
      limit: pageSize,
      where: searchParams,
    },
  });

  const { data, isLoading } = useGetAllActivitys(query);

  const { data: userRoleOption } = useGetRoleOption('all');

  useEffect(() => {
    setQuery({
      query: {
        page: pageNo,
        limit: pageSize,
        where: searchParams,
      },
    });
  }, [pageNo, pageSize]);

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

  const clearAllFilters = () => {
    setSelectedRowKeys([]);
    setSearchParams({});
    setQuery({
      query: {
        page: pageNo,
        limit: pageSize,
      },
    });
  };

  const onSelectAll = (selected: any) => {
    console.log(selected);
    const keys = data?.data?.map((row: any) => row.id);
    setSelectedRowKeys(selected ? keys : []);
  };

  const columns: TableColumnsType<any> = [
    {
      title: 'Name',
      render: (_, { user }) => (
        <UsernameWithIcon name={user?.fullName} iconUrl={''} />
      ),
      width: '120px',
      filterIcon: searchParams?.id ? <CheckCircleTwoTone /> : <UserOutlined />,
      filterDropdown: (
        <Select
          placeholder='Select user'
          style={{ width: '100%' }}
          options={userRoleOption}
          onChange={(value) => handleSearch('id', value)}
        />
      ),
    },
    {
      title: 'Branch',
      dataIndex: 'branch',
      width: '205px',
      filterIcon: searchParams?.branch ? (
        <CheckCircleTwoTone />
      ) : (
        <SearchOutlined />
      ),
      filterDropdown: (
        <TableFilterSearch
          onSearch={(value) => handleSearch('branch', value)}
          placeholder='Search by branch'
        />
      ),
    },
    {
      title: 'Role',
      dataIndex: 'role',
      width: '205px',
      filterIcon: searchParams?.role ? (
        <CheckCircleTwoTone />
      ) : (
        <SearchOutlined />
      ),
      filterDropdown: (
        <Select
          options={roleOption}
          style={{ width: '100%' }}
          onChange={(value) => handleSearch('role', value)}
          placeholder='Search by role'
        />
      ),
    },
    {
      title: 'Activity',
      dataIndex: 'details',
      width: '160px',
      filterIcon: searchParams?.details ? (
        <CheckCircleTwoTone />
      ) : (
        <ReconciliationOutlined />
      ),
      filterDropdown: (
        <TableFilterSearch
          onSearch={(value) => handleSearch('details', value)}
          placeholder='Search by Activity'
        />
      ),
    },
    {
      title: 'Date',
      render: (record) => (
        <>{dayjs(record.createdAt).format('MMM D, YYYY h:mm A')}</>
      ),
      width: '160px',
      filterIcon: searchParams?.createdAt ? (
        <CheckCircleTwoTone />
      ) : (
        <CalendarTwoTone />
      ),
    },
  ];

  return (
    <div className='relative flex w-full flex-col'>
      {/* top section with search bar, filter and action button */}
      <div className='flex w-full flex-row justify-between gap-3'>
        <div className='flex w-[50%] flex-wrap gap-1'>
          <Button
            style={{ height: '30px' }}
            type='primary'
            onClick={clearAllFilters}
          >
            Clear Filters
          </Button>
        </div>
      </div>
      {/* table containing the lsit of data */}
      <div className='mt-[20px]'>
        {selectedRowKeys.length > 0 && (
          <div className='ml-[16px] flex h-[53px] w-full flex-wrap items-center'>
            <Checkbox
              onChange={(event: any) => onSelectAll(event.target.value)}
              defaultChecked
              className='font-Inter text-[12px] font-semibold leading-[18px] !text-[#275FED]'
            >
              Select all
            </Checkbox>
            <AppTableButton
              text={`Unselect ${selectedRowKeys.length} items`}
              onClick={() => setSelectedRowKeys([])}
            />
          </div>
        )}
        <div className='overflow-x-auto'>
          <Table
            rowSelection={{
              type: 'checkbox',
              selectedRowKeys,
              onChange(selectedRowKeys) {
                setSelectedRowKeys(selectedRowKeys);
              },
            }}
            scroll={{ x: 1300 }}
            rowKey={(record) => record.id}
            columns={columns}
            pagination={false}
            dataSource={data?.data}
            tableLayout='fixed'
            showHeader={selectedRowKeys.length <= 0}
            loading={{
              indicator: (
                <div>
                  <Spin />
                </div>
              ),
              spinning: isLoading,
            }}
            className='rounded-md border'
          />
        </div>
        <AppPagination
          pageNo={pageNo}
          pageSize={pageSize}
          total={data?.count}
          setPageSize={setPageSize}
          setPageNo={(value: number) => setPageNo(value)}
        />
      </div>
    </div>
  );
};

export default AllActivities;
