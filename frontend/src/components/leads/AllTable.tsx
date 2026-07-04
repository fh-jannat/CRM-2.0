'use client';
import {
  useDeleteLead,
  useGetAllLeads,
  useGetLeadsCount,
  useGetRolesQuery,
} from '@/apis';
import { ACCESS_TOKEN_STORAGE } from '@/constants';
import { useLoadingContext } from '@/contexts';
import { E_SOURCE, E_STAGE, E_SUBSTAGE, Role } from '@/enums';
import { optionGenerator } from '@/utils';
import {
  CalendarTwoTone,
  CheckCircleTwoTone,
  DeleteOutlined,
  FilterTwoTone,
  PlusCircleOutlined,
  SearchOutlined,
  UserOutlined,
} from '@ant-design/icons';
import {
  Button,
  Checkbox,
  DatePicker,
  Popconfirm,
  Select,
  Spin,
  Table,
  TableColumnsType,
  Upload,
} from 'antd';
import dayjs from 'dayjs';
import { useRouter } from 'next/navigation';
import React, { useEffect, useState } from 'react';
import { toast } from 'react-toastify';
import ActionButton from '../common/ActionButton';
import { AppPagination } from '../common/AppPagination';
import AppTableButton from '../common/AppTableButton';
import ColoredTag from '../common/ColoredTag';
import TableFilterSearch from '../common/TableFilterSearch';
import TableTopButton from '../common/TableTopButton';
import UsernameWithIcon from '../common/UsernameWithIcon';

export const AllTable: React.FC = () => {
  const [pageNo, setPageNo] = useState<number>(1);
  const [pageSize, setPageSize] = useState<number>(10);
  const [selectedRowKeys, setSelectedRowKeys] = useState<React.Key[]>([]);
  const [searchParams, setSearchParams] = useState<{ [key: string]: any }>({});

  const { setIsLoadingGlobal } = useLoadingContext();

  const router = useRouter();
  const [query, setQuery] = useState<any>({
    query: {
      page: pageNo,
      limit: pageSize,
      where: {
        ...searchParams,
      },
    },
  });

  const { data: tableData, isLoading, refetch } = useGetAllLeads(query);
  const { data: count, refetch: refetchCount } = useGetLeadsCount(query);
  const deleteLead = useDeleteLead();

  const { data: roles } = useGetRolesQuery();

  useEffect(() => {
    setQuery({
      query: {
        page: pageNo,
        limit: pageSize,
        where: searchParams,
      },
    });
  }, [count, pageNo, pageSize]);

  const columns: TableColumnsType<any> = [
    {
      title: 'Full Name',
      render: (record: any) => (
        <UsernameWithIcon name={record?.fullName} iconUrl={record.profileUrl} />
      ),
      width: '150px',
      fixed: 'left',
      filterIcon: searchParams?.fullName ? (
        <CheckCircleTwoTone />
      ) : (
        <SearchOutlined />
      ),
      filterDropdown: (
        <TableFilterSearch
          onSearch={(value) => handleSearch('fullName', value)}
          placeholder='Search by name'
        />
      ),
    },
    {
      title: 'Email',
      dataIndex: 'email',
      width: '205px',
      filterIcon: searchParams?.email ? (
        <CheckCircleTwoTone />
      ) : (
        <SearchOutlined />
      ),
      filterDropdown: (
        <TableFilterSearch
          onSearch={(value) => handleSearch('email', value)}
          placeholder='Search by email'
        />
      ),
    },
    {
      title: 'Phone',
      dataIndex: 'phoneNo',
      width: '120px',
      filterIcon: searchParams?.phoneNo ? (
        <CheckCircleTwoTone />
      ) : (
        <SearchOutlined />
      ),
      filterDropdown: (
        <TableFilterSearch
          onSearch={(value) => handleSearch('phoneNo', value)}
          placeholder='Search by phone'
        />
      ),
    },
    {
      title: 'Last Remark',
      dataIndex: 'lastRemark',
      width: '120px',
    },
    {
      title: 'Created At',
      render: (record) => (
        <>{dayjs(record.createdAt).format('MMM D, YYYY h:mm A')}</>
      ),
      width: '160px',
      filterIcon: searchParams?.createdAt ? (
        <CheckCircleTwoTone />
      ) : (
        <CalendarTwoTone />
      ),
      filterDropdown: (
        <DatePicker onChange={(value) => handleSearch('createdAt', value)} />
      ),
    },

    {
      title: 'Source',
      render: (_, { source }) => <ColoredTag text={source} />,
      width: '120px',
      filterIcon: searchParams?.source ? (
        <CheckCircleTwoTone />
      ) : (
        <FilterTwoTone />
      ),
      filterDropdown: (
        <Select
          placeholder='Select source'
          defaultValue={''}
          style={{ width: '100%' }}
          options={optionGenerator(E_SOURCE)}
          onChange={(value) => handleSearch('source', value)}
        />
      ),
    },
    {
      title: 'Assignee',
      render: (_, record) => (
        <UsernameWithIcon name={record?.assigned?.fullName} iconUrl={''} />
      ),
      width: '120px',
      filterIcon: searchParams?.counsellor ? (
        <CheckCircleTwoTone />
      ) : (
        <UserOutlined />
      ),
      filterDropdown: (
        <TableFilterSearch
          onSearch={(value) => handleSearch('counsellor', value)}
          placeholder='Search by name'
        />
      ),
    },
    {
      title: 'Stage',
      render: (_, { stage }) => <ColoredTag text={stage} />,
      width: '140px',
      filterIcon: searchParams?.stage ? (
        <CheckCircleTwoTone />
      ) : (
        <FilterTwoTone />
      ),
      filterDropdown: (
        <Select
          placeholder='Select stage'
          defaultValue={''}
          style={{ width: '100%' }}
          options={optionGenerator(E_STAGE)}
          dropdownStyle={{ width: '200px' }}
          onChange={(value) => handleSearch('stage', value)}
        />
      ),
    },
    {
      title: 'Sub Stage',
      render: (_, { subStage }) => <ColoredTag text={subStage} />,
      width: '140px',
      filterIcon: searchParams?.subStage ? (
        <CheckCircleTwoTone />
      ) : (
        <FilterTwoTone />
      ),
      filterDropdown: (
        <Select
          placeholder='Select status'
          defaultValue={''}
          style={{ width: '100%' }}
          options={optionGenerator(E_SUBSTAGE)}
          dropdownStyle={{ width: '200px' }}
          onChange={(value) => handleSearch('subStage', value)}
        />
      ),
    },
    {
      title: 'Actions',
      width: '160px',
      fixed: 'right',
      render: (record) => (
        <div className='flex flex-row gap-1'>
          <ActionButton.Edit
            onClick={() => router.push('/lead-create/' + record.id)}
          />
          {[Role.ADMIN, Role.MANAGER].some((role) => roles?.includes(role)) && (
            <ActionButton.DeleteWithConfirmation
              onClick={() => handleDeleteLead(record?.id)}
            />
          )}
        </div>
      ),
    },
  ];

  const handleDeleteLead = async (id: string) => {
    await deleteLead.mutateAsync(id);
    await refetch();
  };

  const multipleDelete = async () => {
    await Promise.all(
      selectedRowKeys.map(async (id) => {
        await deleteLead.mutateAsync(id as number);
      })
    );
    setSelectedRowKeys([]);
    await refetch();
    toast.success('Leads deleted successfully');
  };

  const onSelectAll = (selected: any) => {
    const keys = tableData.map((row: any) => row.id);
    setSelectedRowKeys(selected ? keys : []);
  };

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

  return (
    <div className='relative flex w-full flex-col'>
      {/* top section with search bar, filter and action button */}
      <div className='flex w-full flex-row justify-between gap-3'>
        <div className='flex w-[50%] flex-wrap gap-1'>
          <Button style={{ height: '30px' }} onClick={clearAllFilters}>
            Clear Filters
          </Button>
        </div>
        <div className='flex flex-1 flex-wrap justify-end gap-1'>
          <TableTopButton
            text='New Lead'
            onClick={() => router.push('/lead-create')}
            icon={<PlusCircleOutlined />}
          />
          <Upload
            showUploadList={false}
            accept={'.csv'}
            action={`${process.env.NEXT_PUBLIC_API_URI}/api/lead/upload`}
            headers={{
              Authorization: `Bearer ${localStorage.getItem(ACCESS_TOKEN_STORAGE)}`,
            }}
            name='files'
            onChange={async (info) => {
              setIsLoadingGlobal(true);
              if (info.file.status === 'done') {
                console.log(info.file.response);
                toast.success(
                  `${info.file.response.message ?? 'File uploaded successfully'}`
                );
                await refetch();
                await refetchCount();
                setIsLoadingGlobal(false);
              } else if (info.file.status === 'error') {
                toast.error('Failed to upload file');
                setIsLoadingGlobal(false);
              } else {
                setIsLoadingGlobal(false);
              }
            }}
          >
            <TableTopButton text='Upload csv' icon={<PlusCircleOutlined />} />
          </Upload>
        </div>
      </div>
      {/* table containing the lsit of data */}
      <div className='mt-[20px]'>
        {selectedRowKeys.length > 0 && (
          <div className='ml-[8px] flex h-[53px] w-full flex-wrap items-center'>
            <Checkbox
              onChange={(e) => {
                onSelectAll(e.target.checked);
              }}
              checked={selectedRowKeys?.length === tableData?.length}
              className='font-Inter text-[12px] font-semibold leading-[18px] !text-[#275FED]'
            >
              Select all
            </Checkbox>
            <AppTableButton
              text={`Unselect ${selectedRowKeys.length} items`}
              onClick={() => setSelectedRowKeys([])}
            />
            {[Role.ADMIN, Role.MANAGER].some((role) =>
              roles?.includes(role)
            ) && (
              <Popconfirm
                title={`Are you sure to delete ${selectedRowKeys.length} leads?`}
                onConfirm={() => multipleDelete()}
                okButtonProps={{ danger: true }}
              >
                <AppTableButton
                  color='red'
                  text={`Delete ${selectedRowKeys.length} leads`}
                  icon={<DeleteOutlined />}
                />
              </Popconfirm>
            )}
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
            loading={{
              indicator: (
                <div>
                  <Spin />
                </div>
              ),
              spinning: isLoading,
            }}
            onRow={(record) => {
              return {
                onClick: () => {
                  router.push('/lead-details/' + record.id);
                },
              };
            }}
            rowClassName={'cursor-pointer'}
            scroll={{ x: 1300 }}
            columns={columns}
            pagination={false}
            dataSource={tableData}
            rowKey={(record) => record?.id}
            tableLayout='fixed'
            showHeader={selectedRowKeys.length <= 0}
          />
          <AppPagination
            pageNo={pageNo}
            pageSize={pageSize}
            total={count}
            setPageSize={setPageSize}
            setPageNo={(value: number) => setPageNo(value)}
          />
        </div>
      </div>
    </div>
  );
};

export default AllTable;
