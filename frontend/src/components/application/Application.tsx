'use client';
import { getAllApplications } from '@/apis';
import { handleErrorToast } from '@/utils/handleErrorToast';
import {
  CalendarTwoTone,
  CheckCircleTwoTone,
  DeleteOutlined,
  FilterTwoTone,
  ReconciliationOutlined,
  SearchOutlined,
  UserAddOutlined,
  UserOutlined,
} from '@ant-design/icons';
import {
  Checkbox,
  DatePicker,
  Modal,
  Select,
  Table,
  TableColumnsType,
  Tag,
} from 'antd';
import dayjs from 'dayjs';
import React, { useEffect, useState } from 'react';
import ActionButton from '../common/ActionButton';

import AppTableButton from '../common/AppTableButton';
import TableFilterSearch from '../common/TableFilterSearch';
// import TableTopButton from '../common/TableTopButton';
import UsernameWithIcon from '../common/UsernameWithIcon';
import SendMailForm from '../leads/SendMailForm';
import { optionGenerator } from '@/utils';
import { E_COUNSELLOR, E_FILTER_STATUS, E_UNIVERSITY } from '@/enums';
import { AppPagination } from '../common/AppPagination';

const AllApplicationTable = () => {
  const [pageNo, setPageNo] = useState<number>(1);
  const [pageSize, setPageSize] = useState<number>(10);
  const [tableData, setTableData] = useState<any>();
  // const [dateRange, setDateRange] = useState<any>();
  const [selectedRowKeys, setSelectedRowKeys] = useState<React.Key[]>([]);
  const [searchParams, setSearchParams] = useState<{ [key: string]: any }>({});
  const [loading, setLoading] = useState<boolean>(false);
  const [openModal, setOpenModal] = useState<boolean>(false);
  const [leadFormTitle, setLeadFormTitle] = useState<string>('New Lead');
  const [userToReceiveMail, setUserToReceiveMail] = useState<string>('');

  const getModalWidth = () => {
    if (typeof window !== 'undefined') {
      const screenWidth = window.innerWidth;
      if (screenWidth < 576) {
        return screenWidth - 32; // Adjust as needed
      } else {
        return 700; // Default width
      }
    }
  };

  useEffect(() => {
    console.log({ pageNo, pageSize, searchParams });
    const getAllApplicationsData = async () => {
      try {
        setLoading(true);
        const data = await getAllApplications({
          ...searchParams,
          pageNo,
          pageSize,
        });
        setTableData(data);
      } catch (error) {
        handleErrorToast(error, null);
      } finally {
        setLoading(false);
      }
    };
    getAllApplicationsData();
  }, [pageNo, pageSize, searchParams]);

  const handleSearch = (columnName: string, value: any) => {
    setSearchParams({ ...searchParams, [columnName]: value });
  };

  const columns: TableColumnsType<any> = [
    {
      title: 'Lead',
      render: (record: any) => (
        <UsernameWithIcon name={record?.lead} iconUrl={record.profileUrl} />
      ),
      width: '150px',
      fixed: 'left',
      filterIcon: searchParams?.lead ? (
        <CheckCircleTwoTone />
      ) : (
        <SearchOutlined />
      ),
      filterDropdown: (
        <TableFilterSearch
          onSearch={(value) => handleSearch('lead', value)}
          placeholder='Search by name'
        />
      ),
    },
    {
      title: 'Course',
      dataIndex: 'course',
      width: '205px',
      filterIcon: searchParams?.course ? (
        <CheckCircleTwoTone />
      ) : (
        <SearchOutlined />
      ),
      filterDropdown: (
        <TableFilterSearch
          onSearch={(value) => handleSearch('course', value)}
          placeholder='Search by email'
        />
      ),
    },
    {
      title: 'Intake_Month',
      dataIndex: 'intake_month',
      width: '120px',
      filterIcon: searchParams?.intake_month ? (
        <CheckCircleTwoTone />
      ) : (
        <SearchOutlined />
      ),
      filterDropdown: (
        <TableFilterSearch
          onSearch={(value) => handleSearch('intake_month', value)}
          placeholder='Search by intake_month'
        />
      ),
    },

    {
      title: 'Intake_Year',
      dataIndex: 'intake_year',
      width: '120px',
      filterIcon: searchParams?.intake_year ? (
        <CheckCircleTwoTone />
      ) : (
        <SearchOutlined />
      ),
      filterDropdown: (
        <TableFilterSearch
          onSearch={(value) => handleSearch('intake_year', value)}
          placeholder='Search by intake_year'
        />
      ),
    },

    {
      title: 'University',
      render: (_, { university }) => (
        <UsernameWithIcon name={university} iconUrl={''} />
      ),
      width: '120px',
      filterIcon: searchParams?.university ? (
        <CheckCircleTwoTone />
      ) : (
        <UserOutlined />
      ),
      filterDropdown: (
        <Select
          placeholder='Select University'
          defaultValue={''}
          style={{ width: '100%' }}
          options={optionGenerator(E_UNIVERSITY)}
          onChange={(value) => handleSearch('university', value)}
        />
      ),
    },

    {
      title: 'Counsellor',
      render: (_, { counsellor }) => (
        <UsernameWithIcon name={counsellor} iconUrl={''} />
      ),
      width: '120px',
      filterIcon: searchParams?.counsellor ? (
        <CheckCircleTwoTone />
      ) : (
        <UserOutlined />
      ),
      filterDropdown: (
        <Select
          placeholder='Select University'
          defaultValue={''}
          style={{ width: '100%' }}
          options={optionGenerator(E_COUNSELLOR)}
          onChange={(value) => handleSearch('counsellor', value)}
        />
      ),
    },

    {
      title: 'Status',
      render: (_, { status }) => (
        <Tag
          color={
            status === 'active'
              ? 'blue'
              : status === 'inactive'
                ? 'green'
                : 'gold'
          }
        >
          {status?.toUpperCase()}
        </Tag>
      ),
      width: '140px',
      filterIcon: searchParams?.status ? (
        <CheckCircleTwoTone />
      ) : (
        <FilterTwoTone />
      ),
      filterDropdown: (
        <Select
          placeholder='Select status'
          defaultValue={''}
          style={{ width: '100%' }}
          options={optionGenerator(E_FILTER_STATUS)}
          dropdownStyle={{ width: '200px' }}
          onChange={(value) => handleSearch('status', value)}
        />
      ),
    },
    {
      title: 'Applied On',
      render: (record) => (
        <>{dayjs(record.applied_on).format('MMM D, YYYY h:mm A')}</>
      ),
      width: '160px',
      filterIcon: searchParams?.applied_on ? (
        <CheckCircleTwoTone />
      ) : (
        <CalendarTwoTone />
      ),
      filterDropdown: (
        <DatePicker onChange={(value) => handleSearch('applied_on', value)} />
      ),
    },
    {
      title: 'Actions',
      width: '160px',
      fixed: 'right',
      render: (record) => (
        <div className='flex flex-row gap-1'>
          <ActionButton.AddRemark />
          <ActionButton.Edit
            onClick={() => {
              setLeadFormTitle('Edit Lead');
              setOpenModal(true);
            }}
          />
          <ActionButton.SendMail
            onClick={() => {
              setLeadFormTitle('Send Mail to Lead');
              setUserToReceiveMail(record?.email);
              setOpenModal(true);
            }}
          />
          <ActionButton.DeleteWithConfirmation />
          <ActionButton.Convert />
        </div>
      ),
    },
  ];

  const onSelectAll = () => {
    const allKeys = tableData?.items?.map((item: any) => item.key);
    setSelectedRowKeys(
      selectedRowKeys.length === allKeys.length ? [] : allKeys
    );
  };

  const onSelectChange = (selectedRowKeys: any) => {
    setSelectedRowKeys(selectedRowKeys);
  };

  const rowSelection = {
    selectedRowKeys,
    onChange: onSelectChange,
  };

  return (
    <div className='relative flex w-full flex-col'>
      {/* top section with search bar, filter and action button */}

      {/* table containing the lsit of data */}
      <div className='mt-[20px]'>
        {selectedRowKeys.length > 0 && (
          <div className='ml-[8px] flex h-[53px] w-full flex-wrap items-center'>
            <Checkbox
              onClick={onSelectAll}
              defaultChecked
              className='font-Inter text-[12px] font-semibold leading-[18px] !text-[#275FED]'
            >
              Select all
            </Checkbox>
            <AppTableButton
              text={`Unselect ${selectedRowKeys.length} items`}
              onClick={() => setSelectedRowKeys([])}
            />
            <AppTableButton
              color='red'
              text='Delete leads'
              icon={<DeleteOutlined />}
            />
            <AppTableButton
              text='Convert Leads'
              icon={<ReconciliationOutlined />}
            />
            <AppTableButton text='Assign Leads To' icon={<UserAddOutlined />} />
          </div>
        )}
        <div className='overflow-x-auto'>
          <Table
            rowSelection={{
              type: 'checkbox',
              ...rowSelection,
            }}
            scroll={{ x: 1300 }}
            columns={columns}
            pagination={false}
            dataSource={tableData?.items}
            tableLayout='fixed'
            showHeader={selectedRowKeys.length <= 0}
            loading={loading}
          />
        </div>
        <AppPagination
          pageNo={pageNo}
          pageSize={pageSize}
          total={tableData?.total}
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
        width={getModalWidth()}
      >
        <SendMailForm
          onCancel={() => setOpenModal(false)}
          receiverEmail={userToReceiveMail}
        />
      </Modal>
    </div>
  );
};

export default AllApplicationTable;
