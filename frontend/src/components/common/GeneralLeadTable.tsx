'use client';
import { getAllLeads } from '@/apis';
import { handleErrorToast } from '@/utils/handleErrorToast';
import {
  CalendarTwoTone,
  CheckCircleTwoTone,
  DownloadOutlined,
  FilterTwoTone,
  PlusCircleOutlined,
  ReconciliationOutlined,
  SearchOutlined,
  UploadOutlined,
  UserAddOutlined,
  UserOutlined,
} from '@ant-design/icons';
import {
  Button,
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
import { AppPagination } from '../common/AppPagination';
import AppTableButton from '../common/AppTableButton';
import TableFilterSearch from '../common/TableFilterSearch';
import TableTopButton from '../common/TableTopButton';
import UsernameWithIcon from '../common/UsernameWithIcon';
import SendMailForm from '../leads/SendMailForm';

type GeneralLeadTableProps = {
  leadStatus: string;
};

const GeneralLeadTable: React.FC<GeneralLeadTableProps> = ({ leadStatus }) => {
  const [pageNo, setPageNo] = useState<number>(1);
  const [pageSize, setPageSize] = useState<number>(10);
  const [tableData, setTableData] = useState<any>();
  const [dateRange, setDateRange] = useState<any>();
  const [selectedRowKeys, setSelectedRowKeys] = useState<React.Key[]>([]);
  const [searchParams, setSearchParams] = useState<{ [key: string]: any }>({});
  const [loading, setLoading] = useState<boolean>(false);
  const [openModal, setOpenModal] = useState<boolean>(false);
  const [leadFormTitle, setLeadFormTitle] = useState<string>('New Lead');
  const [userToReceiveMail, setUserToReceiveMail] = useState<string>('');

  // const getModalWidth = () => {
  //   const screenWidth = window.innerWidth;
  //   if (screenWidth < 576) {
  //     return screenWidth - 32; // Adjust as needed
  //   } else {
  //     return 700; // Default width
  //   }
  // };

  useEffect(() => {
    console.log({ pageNo, pageSize, dateRange, searchParams, leadStatus });
    const getAllLeadsData = async () => {
      try {
        setLoading(true);
        const data = await getAllLeads({
          ...searchParams,
          pageNo,
          pageSize,
          dateRange,
        });
        setTableData(data);
      } catch (error) {
        handleErrorToast(error, null);
      } finally {
        setLoading(false);
      }
    };
    getAllLeadsData();
    // eslint-disable-next-line
  }, [pageNo, pageSize, dateRange, searchParams]);

  const handleSearch = (columnName: string, value: any) => {
    setSearchParams({ ...searchParams, [columnName]: value });
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
      dataIndex: 'phone',
      width: '120px',
      filterIcon: searchParams?.phone ? (
        <CheckCircleTwoTone />
      ) : (
        <SearchOutlined />
      ),
      filterDropdown: (
        <TableFilterSearch
          onSearch={(value) => handleSearch('phone', value)}
          placeholder='Search by phone'
        />
      ),
    },
    {
      title: 'Created On',
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
      title: 'Purpose',
      render: (_, { purpose }) => (
        <Tag
          color={
            purpose === 'unknown'
              ? 'blue'
              : purpose === 'english-teaching'
                ? 'green'
                : 'geekblue'
          }
        >
          {purpose?.toUpperCase()}
        </Tag>
      ),
      width: '130px',
      filterIcon: searchParams?.purpose ? (
        <CheckCircleTwoTone />
      ) : (
        <FilterTwoTone />
      ),
      filterDropdown: (
        <Select
          placeholder='Select purpose'
          defaultValue={''}
          style={{ width: '100%' }}
          //   options={purposeOptions}
          onChange={(value) => handleSearch('purpose', value)}
        />
      ),
    },
    {
      title: 'Desired Course',
      render: (_, { desiredCourse }) => (
        <Tag
          color={
            desiredCourse === 'pte'
              ? 'blue'
              : desiredCourse === 'ielts-academic'
                ? 'green'
                : 'gold'
          }
        >
          {desiredCourse?.toUpperCase()}
        </Tag>
      ),
      width: '135px',
      filterIcon: searchParams?.desiredCourse ? (
        <CheckCircleTwoTone />
      ) : (
        <FilterTwoTone />
      ),
      filterDropdown: (
        <Select
          placeholder='Desired course'
          defaultValue={''}
          style={{ width: '100%' }}
          //   options={desiredCourseOptions}
          onChange={(value) => handleSearch('desiredCourse', value)}
        />
      ),
    },
    {
      title: 'Source',
      render: (_, { source }) => (
        <Tag
          color={
            source === 'meta' ? 'blue' : source === 'google' ? 'green' : 'gold'
          }
        >
          {source?.toUpperCase()}
        </Tag>
      ),
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
          //   options={sourceOptions}
          onChange={(value) => handleSearch('source', value)}
        />
      ),
    },
    {
      title: 'Passport',
      render: (_, { passport }) => (
        <Tag
          color={
            passport === 'yes' ? 'blue' : passport === 'no' ? 'green' : 'gold'
          }
        >
          {passport?.toUpperCase()}
        </Tag>
      ),
      width: '100px',
      filterIcon: searchParams?.passport ? (
        <CheckCircleTwoTone />
      ) : (
        <FilterTwoTone />
      ),
      filterDropdown: (
        <Select
          placeholder='Select passport'
          defaultValue={''}
          style={{ width: '100%' }}
          //   options={passportOptions}
          onChange={(value) => handleSearch('passport', value)}
        />
      ),
    },
    {
      title: 'Destination',
      render: (_, { destination }) => (
        <Tag
          color={
            destination === 'usa'
              ? 'blue'
              : destination === 'canada'
                ? 'green'
                : 'gold'
          }
        >
          {destination?.toUpperCase()}
        </Tag>
      ),
      width: '100px',
      filterIcon: searchParams?.destination ? (
        <CheckCircleTwoTone />
      ) : (
        <FilterTwoTone />
      ),
      filterDropdown: (
        <Select
          placeholder='Select destination'
          defaultValue={''}
          style={{ width: '100%' }}
          //   options={destinationOptions}
          onChange={(value) => handleSearch('destination', value)}
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
          placeholder='Select counsellor'
          defaultValue={''}
          style={{ width: '100%' }}
          //   options={CounsellorOptions}
          onChange={(value) => handleSearch('counsellor', value)}
        />
      ),
    },
    {
      title: 'Created By',
      render: (_, { createdBy }) => (
        <UsernameWithIcon
          name={createdBy?.name}
          iconUrl={createdBy?.profileUrl}
        />
      ),
      width: '140px',
      filterIcon: searchParams?.leadStatus ? (
        <CheckCircleTwoTone />
      ) : (
        <SearchOutlined />
      ),
      filterDropdown: (
        <TableFilterSearch
          onSearch={(value) => handleSearch('createdBy', value)}
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

  const clearAllFilters = () => {
    setSelectedRowKeys([]);
    setDateRange([]);
    setSearchParams({});
  };

  return (
    <div className='relative flex w-full flex-col'>
      {/* top section with search bar, filter and action button */}
      <div className='flex w-full flex-row justify-between gap-3'>
        <div className='flex w-[50%] flex-wrap gap-1'>
          <DatePicker.RangePicker
            onChange={(value) => setDateRange(value)}
            placeholder={['From date', 'To date']}
            className='h-[30px]'
          />
          <Button style={{ height: '30px' }} onClick={clearAllFilters}>
            Clear Filters
          </Button>
        </div>
        <div className='flex flex-1 flex-wrap justify-end gap-1'>
          <TableTopButton
            text='New Lead'
            onClick={() => {
              setLeadFormTitle('New Lead');
              setOpenModal(true);
            }}
            icon={<PlusCircleOutlined />}
          />
          {/* <TableTopButton text='New Lead From Meta' icon={<UploadOutlined />} /> */}
          <TableTopButton text='Import Leads' icon={<UploadOutlined />} />
          <TableTopButton text='Upload Leads' icon={<DownloadOutlined />} />
        </div>
      </div>
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
            {/* <AppTableButton
              color='red'
              text='Delete leads'
              icon={<DeleteOutlined />}
            /> */}
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
        // width={getModalWidth()}
      >
        <SendMailForm
          onCancel={() => setOpenModal(false)}
          receiverEmail={userToReceiveMail}
        />
      </Modal>
    </div>
  );
};

export default GeneralLeadTable;
