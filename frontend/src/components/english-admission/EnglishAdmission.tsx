'use client';
import {
  useDeleteLead,
  useGetAllLeads,
  useGetLeadsCount,
  useUpdateLead,
} from '@/apis';
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
  Modal,
  Popconfirm,
  Select,
  Spin,
  Table,
  TableColumnsType,
} from 'antd';
import dayjs from 'dayjs';
import React, { useState } from 'react';
import ActionButton from '../common/ActionButton';
import { AppPagination } from '../common/AppPagination';
import AppTableButton from '../common/AppTableButton';
import TableFilterSearch from '../common/TableFilterSearch';

import UsernameWithIcon from '../common/UsernameWithIcon';
import { optionGenerator } from '@/utils';
import {
  E_COURSE_STAGE,
  E_COURSE_SUBSTAGE,
  E_PURPOSE,
  E_SOURCE,
  E_STAGE,
  E_SUBSTAGE,
} from '@/enums';
import TableTopButton from '../common/TableTopButton';
import { useRouter } from 'next/navigation';
import ColoredTag from '../common/ColoredTag';
import { toast } from 'react-toastify';
import { StatusChangeForm } from '../forms';

export const EnglishAdmission = () => {
  const [pageNo, setPageNo] = useState<number>(1);
  const [pageSize, setPageSize] = useState<number>(10);

  const [selectedRowKeys, setSelectedRowKeys] = useState<React.Key[]>([]);
  const hasSelected = selectedRowKeys.length > 0;

  const [searchParams, setSearchParams] = useState<{ [key: string]: any }>({});

  const [openModal, setOpenModal] = useState<boolean>(false);
  const [leadFormTitle, setLeadFormTitle] = useState<string>('New Lead');
  const [selectedLeadId, setSelectedLeadId] = useState<string>('');
  const [selectedLead, setSelectedLead] = useState<any>({});

  const router = useRouter();

  const [query, setQuery] = useState<any>({
    query: {
      page: pageNo,
      limit: pageSize,
      where: {
        purpose: E_PURPOSE.COURSES,
      },
    },
  });

  const { data, isLoading, refetch } = useGetAllLeads(query);
  const { data: count } = useGetLeadsCount(query);
  const deleteLead = useDeleteLead();
  const updateLead = useUpdateLead();

  const handleDeleteLead = async (id: string) => {
    await deleteLead.mutateAsync(id);
    await refetch();
    toast.success('Student deleted successfully');
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
          purpose: E_PURPOSE.COURSES,
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
        where: {
          purpose: E_PURPOSE.COURSES,
        },
      },
    });
  };

  const onSelectAll = (selected: any) => {
    const keys = data.map((row: any) => row.id);
    setSelectedRowKeys(selected ? keys : []);
  };

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
      title: 'Stage',
      dataIndex: 'stage',
      filterIcon: searchParams?.stage ? (
        <CheckCircleTwoTone />
      ) : (
        <SearchOutlined />
      ),
      filterDropdown: (
        <Select
          onChange={(value) => handleSearch('stage', value)}
          placeholder='Search by stage'
          style={{ width: '100%' }}
          options={optionGenerator(E_COURSE_STAGE)}
        />
      ),
    },
    {
      title: 'Sub-stage',
      dataIndex: 'subStage',
      filterIcon: searchParams?.subStage ? (
        <CheckCircleTwoTone />
      ) : (
        <SearchOutlined />
      ),
      filterDropdown: (
        <Select
          onChange={(value) => handleSearch('subStage', value)}
          placeholder='Search by sub-stage'
          style={{ width: '100%' }}
          options={optionGenerator(E_COURSE_SUBSTAGE)}
        />
      ),
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
      // filterDropdown: (
      //   <DatePicker onChange={(value) => handleSearch('createdAt', value)} />
      // ),
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
          style={{ width: '100%' }}
          options={optionGenerator(E_SOURCE)}
          onChange={(value) => handleSearch('source', value)}
        />
      ),
    },
    {
      title: 'Teacher',
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
      title: 'Actions',
      width: '160px',
      fixed: 'right',
      render: (record) => (
        <div className='flex flex-row gap-1'>
          <ActionButton.ChangeStatus
            onClick={() => {
              setLeadFormTitle('Change status');
              setSelectedLeadId(record.id);
              setSelectedLead(record);
              setOpenModal(true);
            }}
          />
          <ActionButton.Edit
            onClick={() => router.push('/lead-create/' + record.id)}
          />
          <ActionButton.DeleteWithConfirmation
            onClick={() => handleDeleteLead(record?.id)}
          />
          <ActionButton.Convert
            onClick={async () => {
              await updateLead.mutateAsync({
                id: record?.id,
                purpose: E_PURPOSE.STUDY_ABROAD,
                stage: E_STAGE.POTENTIAL,
                subStage: E_SUBSTAGE.WAITING_FOR_DOCUMENT,
              });
              await refetch();
              toast.success('Student converted successfully');
            }}
          />
        </div>
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
        <div className='flex flex-1 flex-wrap justify-end gap-1'>
          <TableTopButton
            text='New Student'
            onClick={() => router.push('/lead-create')}
            icon={<PlusCircleOutlined />}
          />
        </div>
      </div>
      {/* table containing the lsit of data */}
      <div className='mt-[20px]'>
        {selectedRowKeys.length > 0 && (
          <div className='ml-[8px] flex h-[53px] w-full flex-wrap items-center'>
            <Checkbox
              className='font-Inter text-[12px] font-semibold leading-[18px] text-[#275FED]'
              checked={selectedRowKeys.length === data.length}
              onChange={(e) => onSelectAll(e.target.checked)}
            >
              Select all
            </Checkbox>
            <span style={{ margin: 8 }}>
              {hasSelected ? `Selected ${selectedRowKeys.length} items` : ''}
            </span>
            <Popconfirm
              title={`Are you sure to delete ${selectedRowKeys.length} students?`}
              // onConfirm={() => multipleDelete()}
              okButtonProps={{ danger: true }}
            >
              <AppTableButton
                color='red'
                text='Delete users'
                icon={<DeleteOutlined />}
              />
            </Popconfirm>
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
            dataSource={data}
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
          total={count}
          setPageSize={(value: number) => setPageSize(value)}
          setPageNo={(value: number) => setPageNo(value)}
        />
      </div>

      <Modal
        title={leadFormTitle}
        style={{ height: '100vh', overflowY: 'auto', top: 0 }}
        open={openModal}
        onCancel={() => {
          setOpenModal(false);
        }}
        footer={false}
      >
        <StatusChangeForm
          currentStage={selectedLead.stage}
          currentSubStage={selectedLead.subStage}
          id={selectedLeadId}
          onSubmit={() => {
            setOpenModal(false);
          }}
        />
      </Modal>
    </div>
  );
};
