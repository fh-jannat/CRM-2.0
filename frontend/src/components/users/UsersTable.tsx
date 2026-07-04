'use client';
import { handleErrorToast } from '@/utils/handleErrorToast';
import {
  CalendarTwoTone,
  CheckCircleTwoTone,
  FilterTwoTone,
  PlusOutlined,
  SearchOutlined,
} from '@ant-design/icons';
import {
  Button,
  Checkbox,
  Form,
  Modal,
  Select,
  Spin,
  Table,
  TableColumnsType,
  Tag,
} from 'antd';
import dayjs from 'dayjs';
import { useEffect, useState } from 'react';
import ActionButton from '../common/ActionButton';
import { AppPagination } from '../common/AppPagination';
import TableFilterSearch from '../common/TableFilterSearch';
import TableTopButton from '../common/TableTopButton';
import UsernameWithIcon from '../common/UsernameWithIcon';
import UserForm from './UserForm';
import {
  useCreateTask,
  useCreateUser,
  useDeleteUser,
  useGetAllUsers,
  useGetUserCount,
  useUpdateUser,
} from '@/apis';
import { toast } from 'react-toastify';
import { Role, roleOption, userStatusOption } from '@/enums';
import TaskAssignForm from '../tasks/TaskAssignForm';
import { SelectBranch } from '../common/Selectors/SelectBranch';

const UsersTable = () => {
  const [form] = Form.useForm();
  const [loading, setLoading] = useState(false);
  const [pageNo, setPageNo] = useState<number>(1);
  const [pageSize, setPageSize] = useState<number>(10);
  const [searchParams, setSearchParams] = useState<{ [key: string]: any }>({});

  const [selectedRowKeys, setSelectedRowKeys] = useState<React.Key[]>([]);
  const hasSelected = selectedRowKeys.length > 0;

  const [openModal, setOpenModal] = useState<boolean>(false);
  const [modalTitle, setModalTitle] = useState<string>('Add New User');
  // eslint-disable-next-line
  const [userToBeUpdated, setUserBeUpdated] = useState<any>({});

  const [query, setQuery] = useState<any>({
    query: {
      page: pageNo,
      limit: pageSize,
      where: searchParams,
    },
  });

  const { data, refetch, isLoading } = useGetAllUsers(query);
  // eslint-disable-next-line
  const { data: count, refetch: refetchCount } = useGetUserCount(query);
  const createUser = useCreateUser();
  const updateUser = useUpdateUser();
  // eslint-disable-next-line
  const deleteUser = useDeleteUser();

  const createTask = useCreateTask();

  useEffect(() => {
    setQuery({
      query: {
        page: pageNo,
        limit: pageSize,
        where: searchParams,
      },
    });
  }, [count, pageNo, pageSize]);

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

  const handleUserForm = async (value: any) => {
    setLoading(true);
    try {
      if (value.id) {
        await updateUser.mutateAsync(value);
        toast.success('User updated successfully');
      } else {
        await createUser.mutateAsync(value);
        toast.success('User created successfully');
      }
    } catch (error) {
      handleErrorToast(error);
    } finally {
      await refetch();
      setLoading(false);
      setOpenModal(false);
      form.resetFields();
    }
  };

  const handleTaskForm = async (value: any) => {
    setLoading(true);
    try {
      await createTask.mutateAsync(value);
      toast.success('Task created successfully');
    } catch (error) {
      handleErrorToast(error);
    } finally {
      await refetch();
      setLoading(false);
      setOpenModal(false);
      form.resetFields();
    }
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
      dataIndex: 'phoneNumber',
      width: '120px',
      filterIcon: searchParams?.phoneNumber ? (
        <CheckCircleTwoTone />
      ) : (
        <SearchOutlined />
      ),
      filterDropdown: (
        <TableFilterSearch
          onSearch={(value) => handleSearch('phoneNumber', value)}
          placeholder='Search by phone'
        />
      ),
    },
    {
      title: 'Branch',
      dataIndex: 'branchName',
      width: '150px',
      filterIcon: searchParams?.branchName ? (
        <CheckCircleTwoTone />
      ) : (
        <SearchOutlined />
      ),
      filterDropdown: (
        <SelectBranch
          style={{ width: '100%' }}
          dropdownStyle={{ width: '200px' }}
          onChange={(value) => handleSearch('branchName', value)}
        />
      ),
    },
    {
      title: 'Role',
      render: (_, { role }) => (
        <Tag color={'gold'}>{role?.[0]?.toUpperCase()}</Tag>
      ),
      width: '140px',
      filterIcon: searchParams?.role ? (
        <CheckCircleTwoTone />
      ) : (
        <FilterTwoTone />
      ),
      filterDropdown: (
        <Select
          placeholder='Select role'
          mode='multiple'
          style={{ width: '100%' }}
          options={roleOption}
          dropdownStyle={{ width: '200px' }}
          onChange={(value) => handleSearch('role', value)}
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
          options={userStatusOption}
          dropdownStyle={{ width: '200px' }}
          onChange={(value) => handleSearch('status', value)}
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
      // filterDropdown: (
      //   <DatePicker onChange={(value) => handleSearch('createdAt', value)} />
      // ),
    },

    {
      title: 'Actions',
      width: '90px',
      fixed: 'right',
      render: (record) => (
        <div className='flex flex-row gap-1'>
          {!record?.role?.includes(Role.ADMIN) && (
            <>
              <ActionButton.AssignTask
                onClick={() => {
                  setUserBeUpdated(record);
                  setModalTitle('Assign New Task');
                  form.setFieldValue('assigned', record.id);
                  setOpenModal(true);
                }}
              />
              <ActionButton.Edit
                onClick={() => {
                  form.setFieldsValue(record);
                  setModalTitle('Edit User');
                  setOpenModal(true);
                }}
              />
            </>
          )}
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
        <div className='flex w-full flex-row justify-end'>
          <TableTopButton
            text='Add New User'
            onClick={() => {
              setModalTitle('Add New User');
              setOpenModal(true);
            }}
            icon={<PlusOutlined />}
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
          setPageSize={setPageSize}
          setPageNo={(value: number) => setPageNo(value)}
        />
      </div>
      <Modal
        title={modalTitle}
        open={openModal}
        onCancel={() => {
          form.resetFields();
          setOpenModal(false);
        }}
        footer={false}
      >
        {modalTitle === 'Add New User' || modalTitle === 'Edit User' ? (
          <UserForm
            form={form}
            loading={loading}
            handleSubmit={handleUserForm}
            onCancel={() => {
              setOpenModal(false);
              form.resetFields();
            }}
          />
        ) : (
          <TaskAssignForm
            form={form}
            onCancel={() => {
              setOpenModal(false);
              form.resetFields();
            }}
            onSubmit={handleTaskForm}
            loading={loading}
          />
        )}
      </Modal>
    </div>
  );
};

export default UsersTable;
