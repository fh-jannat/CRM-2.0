'use client';
import {
  useDeleteLead,
  useGetAllLeads,
  useGetLeadsCount,
  useGetRolesQuery,
} from '@/apis';
import {
  CalendarTwoTone,
  CheckCircleTwoTone,
  DeleteOutlined,
  FilterTwoTone,
  SearchOutlined,
  UserOutlined,
} from '@ant-design/icons';
import {
  Button,
  Checkbox,
  DatePicker,
  Modal,
  Popconfirm,
  Select,
  Spin,
  Table,
  TableColumnsType,
} from 'antd';
import dayjs from 'dayjs';
import { useRouter } from 'next/navigation';
import React, { useEffect, useState } from 'react';
import ActionButton from '../common/ActionButton';
import { AppPagination } from '../common/AppPagination';
import AppTableButton from '../common/AppTableButton';
import ColoredTag from '../common/ColoredTag';
import TableFilterSearch from '../common/TableFilterSearch';
import UsernameWithIcon from '../common/UsernameWithIcon';
import { StatusChangeForm } from '../forms/statusChangeForm/StatusChangeForm';
import { optionGenerator } from '@/utils';
import { countryOption, E_SOURCE, E_SUBSTAGE, Role } from '@/enums';
import { toast } from 'react-toastify';
import { AdminStatusChange } from '../forms';

interface AllLeadsTableProps {
  leadType: string;
}

const AllStudentsTable: React.FC<AllLeadsTableProps> = ({ leadType }) => {
  const [pageNo, setPageNo] = useState<number>(1);
  const [pageSize, setPageSize] = useState<number>(10);
  const [selectedRowKeys, setSelectedRowKeys] = useState<React.Key[]>([]);
  const [searchParams, setSearchParams] = useState<{ [key: string]: any }>({});
  const [openModal, setOpenModal] = useState<boolean>(false);
  const [leadFormTitle, setLeadFormTitle] = useState<string>('New Lead');
  const [selectedLeadId, setSelectedLeadId] = useState<string>('');

  const router = useRouter();
  const [query, setQuery] = useState<any>({
    query: {
      page: pageNo,
      limit: pageSize,
      where: {
        stage: 'potential',
      },
    },
  });

  const { data: tableData, isLoading, refetch } = useGetAllLeads(query);
  const { data: count } = useGetLeadsCount(query);
  const deleteLead = useDeleteLead();

  const { data: roles } = useGetRolesQuery();

  useEffect(() => {
    if (leadType === 'all') {
      setQuery({
        query: {
          page: pageNo,
          limit: pageSize,
          where: {
            stage: 'potential',
          },
        },
      });
    } else {
      setQuery({
        query: {
          page: pageNo,
          limit: pageSize,
          where: {
            subStage: leadType,
            stage: 'potential',
          },
        },
      });
    }
  }, [leadType]);

  useEffect(() => {
    setQuery({
      query: {
        page: pageNo,
        limit: pageSize,
        where: {
          ...(leadType !== 'all' && { subStage: leadType }),
          stage: 'potential',
          ...searchParams,
        },
      },
    });
  }, [count, pageNo, pageSize]);

  const getModalWidth = () => {
    if (typeof window !== 'undefined') {
      const screenWidth = window.innerWidth;
      if (screenWidth < 576) {
        return screenWidth - 32;
      } else {
        return 700;
      }
    }
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
      title: 'Last Remark',
      dataIndex: 'lastRemark',
      width: '120px',
    },
    {
      title: 'Interested Country',
      dataIndex: 'interestedCountry',
      width: '120px',
      filterIcon: searchParams?.interestedCountry ? (
        <CheckCircleTwoTone />
      ) : (
        <SearchOutlined />
      ),
      filterDropdown: (
        <Select
          onChange={(value) => handleSearch('interestedCountry', value)}
          placeholder='Select country'
          options={countryOption}
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
          placeholder='Select counsellor'
        />
      ),
    },
    {
      title: 'Actions',
      width: '120px',
      fixed: 'right',
      render: (record) => (
        <div className='flex flex-row gap-1'>
          {leadType !== 'all' && (
            <ActionButton.ChangeStatus
              onClick={() => {
                setLeadFormTitle('Change status');
                setSelectedLeadId(record.id);
                setOpenModal(true);
              }}
            />
          )}
          <ActionButton.Edit
            onClick={() => router.push('/lead-create/' + record.id)}
          />
          {[Role.ADMIN, Role.MANAGER].some((role) => roles?.includes(role)) && (
            <>
              <ActionButton.DeleteWithConfirmation
                onClick={() => handleDeleteLead(record?.id)}
              />
              <ActionButton.AdminChangeStatus
                onClick={() => {
                  setLeadFormTitle('Admin Change status');
                  setSelectedLeadId(record.id);
                  setOpenModal(true);
                }}
              />
            </>
          )}
        </div>
      ),
    },
  ];

  if (leadType === 'all') {
    columns.splice(columns.length - 1, 0, {
      title: 'Student Status',
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
    });
  }

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
    if (leadType === 'all') {
      setQuery({
        query: {
          page: pageNo,
          limit: pageSize,
          where: { ...searchParams, [columnName]: value, stage: 'potential' },
        },
      });
    } else {
      setQuery({
        query: {
          page: pageNo,
          limit: pageSize,
          where: { ...searchParams, stage: 'potential', subStage: leadType },
        },
      });
    }
  };

  const clearAllFilters = () => {
    setSelectedRowKeys([]);
    setSearchParams({});
    if (leadType === 'all') {
      setQuery({
        query: {
          page: pageNo,
          limit: pageSize,
          where: {
            stage: 'potential',
          },
        },
      });
    } else {
      setQuery({
        query: {
          page: pageNo,
          limit: pageSize,
          where: {
            subStage: leadType,
            stage: 'potential',
          },
        },
      });
    }
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
        </div>
        <AppPagination
          pageNo={pageNo}
          pageSize={pageSize}
          total={count}
          setPageSize={setPageSize}
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
        width={getModalWidth()}
      >
        {leadFormTitle === 'Change status' ? (
          <StatusChangeForm
            currentStage={'potential'}
            currentSubStage={leadType}
            id={selectedLeadId}
            onSubmit={() => {
              setOpenModal(false);
            }}
          />
        ) : (
          <AdminStatusChange
            currentStage={'potential'}
            currentSubStage={leadType}
            id={selectedLeadId}
            onSubmit={() => {
              setOpenModal(false);
            }}
          />
        )}
      </Modal>
    </div>
  );
};

export default AllStudentsTable;
