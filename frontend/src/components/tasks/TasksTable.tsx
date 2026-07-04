'use client';
import React, { useEffect, useState, useCallback } from 'react';
import {
  Button,
  Checkbox,
  Form,
  Modal,
  Popconfirm,
  Select,
  Spin,
  Table,
  Tag,
  TableColumnsType,
  Tooltip,
} from 'antd';
import {
  CheckCircleTwoTone,
  DeleteOutlined,
  FilterTwoTone,
  PlusOutlined,
  SearchOutlined,
} from '@ant-design/icons';
import dayjs from 'dayjs';
import { toast } from 'react-toastify';

import ActionButton from '../common/ActionButton';
import { AppPagination } from '../common/AppPagination';
import TableFilterSearch from '../common/TableFilterSearch';
import TableTopButton from '../common/TableTopButton';
import TaskAssignForm from './TaskAssignForm';
import AppTableButton from '../common/AppTableButton';
import { handleErrorToast } from '@/utils/handleErrorToast';
import { taskStatusOption } from '@/enums';
import {
  useCreateTask,
  useDeleteTask,
  useGetAllTasks,
  useGetTaskCount,
  useUpdateTask,
} from '@/apis';

interface Task {
  id: number;
  assigned: { id: number; fullName: string };
  task: string;
  description: string;
  startDate: string;
  endDate: string;
  status: string;
  createdAt: string;
}

interface QueryParams {
  page: number;
  limit: number;
  where: Record<string, any>;
}

export const TasksTable: React.FC = () => {
  const [form] = Form.useForm();
  const [loading, setLoading] = useState<boolean>(false);
  const [pageNo, setPageNo] = useState<number>(1);
  const [pageSize, setPageSize] = useState(10);
  const [searchParams, setSearchParams] = useState<Record<string, any>>({});
  const [selectedRowKeys, setSelectedRowKeys] = useState<React.Key[]>([]);
  const [openModal, setOpenModal] = useState<boolean>(false);
  const [modalTitle, setModalTitle] = useState<string>('Add New Task');
  const [query, setQuery] = useState<{ query: QueryParams }>({
    query: { page: pageNo, limit: pageSize, where: searchParams },
  });

  const { data, refetch, isLoading } = useGetAllTasks(query);
  const { data: count, refetch: refetchCount } = useGetTaskCount(query);
  const createTask = useCreateTask();
  const updateTask = useUpdateTask();
  const deleteTask = useDeleteTask();

  useEffect(() => {
    setQuery({ query: { page: pageNo, limit: pageSize, where: searchParams } });
  }, [count, pageNo, pageSize, searchParams]);

  const handleSearch = useCallback((columnName: string, value: any) => {
    setSearchParams((prev) => ({ ...prev, [columnName]: value }));
  }, []);

  const multipleDelete = useCallback(async () => {
    await Promise.all(
      selectedRowKeys.map((id) => deleteTask.mutateAsync(id as number))
    );
    setSelectedRowKeys([]);
    await refetch();
    await refetchCount();
    toast.success('Tasks deleted successfully');
  }, [selectedRowKeys, deleteTask, refetch, refetchCount]);

  const handleTaskForm = useCallback(
    async (value: any) => {
      setLoading(true);
      try {
        if (value.id) {
          await updateTask.mutateAsync(value);
          toast.success('Task updated successfully');
        } else {
          await createTask.mutateAsync(value);
          toast.success('Task created successfully');
        }
      } catch (error) {
        handleErrorToast(error);
      } finally {
        await refetch();
        setLoading(false);
        setOpenModal(false);
        form.resetFields();
      }
    },
    [updateTask, createTask, refetch, form]
  );

  const clearAllFilters = useCallback(() => {
    setSelectedRowKeys([]);
    setSearchParams({});
  }, []);

  const columns: TableColumnsType<Task> = [
    {
      title: 'Assigne',
      dataIndex: ['assigned', 'fullName'],
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
      render: (text: string) => (
        <Tooltip title={text}>
          <div className='line-clamp-3 max-w-[150px] flex-wrap overflow-hidden'>
            {text}
          </div>
        </Tooltip>
      ),
    },
    {
      title: 'Task',
      dataIndex: 'task',
      render: (text: string) => (
        <Tooltip title={text}>
          <div className='line-clamp-3 max-w-[200px] flex-wrap overflow-hidden'>
            {text}
          </div>
        </Tooltip>
      ),
    },
    {
      title: 'Details',
      dataIndex: 'description',
      render: (text: string) => (
        <Tooltip title={text}>
          <div className='line-clamp-3 max-w-[250px] flex-wrap overflow-hidden'>
            {text}
          </div>
        </Tooltip>
      ),
    },
    {
      title: 'Start Date',
      dataIndex: 'startDate',
      render: (value: string) => (
        <div className='whitespace-nowrap'>
          {dayjs(value).format('MMM D, YYYY h:mm A')}
        </div>
      ),
    },
    {
      title: 'End Date',
      dataIndex: 'endDate',
      render: (value: string) => (
        <div className='whitespace-nowrap'>
          {dayjs(value).format('MMM D, YYYY h:mm A')}
        </div>
      ),
    },
    {
      title: 'Status',
      dataIndex: 'status',
      render: (status: string) => (
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
      filterIcon: searchParams?.status ? (
        <CheckCircleTwoTone />
      ) : (
        <FilterTwoTone />
      ),
      filterDropdown: (
        <Select
          placeholder='Select status'
          style={{ width: '100%' }}
          options={taskStatusOption}
          onChange={(value) => handleSearch('status', value)}
        />
      ),
    },
    {
      title: 'Created On',
      dataIndex: 'createdAt',
      render: (value: string) => (
        <div className='whitespace-nowrap'>
          {dayjs(value).format('MMM D, YYYY h:mm A')}
        </div>
      ),
    },
    {
      title: 'Actions',
      render: (_, record: Task) => (
        <div className='flex flex-row gap-1'>
          <ActionButton.Edit
            onClick={() => {
              form.setFieldsValue({
                ...record,
                assigned: record.assigned.id,
                start_date: [dayjs(record.startDate), dayjs(record.endDate)],
              });
              setModalTitle('Edit Task');
              setOpenModal(true);
            }}
          />
          <ActionButton.DeleteWithConfirmation
            onClick={async () => {
              await deleteTask.mutateAsync(record.id);
              await refetch();
              await refetchCount();
              toast.success('Task deleted successfully');
            }}
          />
        </div>
      ),
    },
  ];

  const renderTopButtons = () => (
    <div className='mb-4 flex w-full flex-col justify-between gap-3 sm:flex-row'>
      <Button
        className='w-full sm:w-auto'
        type='primary'
        onClick={clearAllFilters}
      >
        Clear Filters
      </Button>
      <TableTopButton
        text='Add New Task'
        onClick={() => {
          setModalTitle('Add New Task');
          setOpenModal(true);
        }}
        icon={<PlusOutlined />}
      />
    </div>
  );

  const renderBulkActions = () =>
    selectedRowKeys.length > 0 && (
      <div className='mb-4 flex flex-wrap items-center justify-between'>
        <div>
          <Checkbox
            checked={selectedRowKeys.length === data.length}
            onChange={(e) =>
              setSelectedRowKeys(
                e.target.checked ? data.map((row: Task) => row.id) : []
              )
            }
          >
            Select all
          </Checkbox>
          <span className='ml-2'>
            Selected {selectedRowKeys.length} item
            {selectedRowKeys.length !== 1 ? 's' : ''}
          </span>
        </div>
        <Popconfirm
          title={`Are you sure to delete ${selectedRowKeys.length} task${selectedRowKeys.length !== 1 ? 's' : ''}?`}
          onConfirm={multipleDelete}
          okButtonProps={{ danger: true }}
        >
          <AppTableButton
            color='red'
            text='Delete tasks'
            icon={<DeleteOutlined />}
          />
        </Popconfirm>
      </div>
    );

  return (
    <div className='flex w-full flex-col'>
      {renderTopButtons()}
      <div className='overflow-x-auto'>
        {renderBulkActions()}
        <Table<Task>
          rowSelection={{
            type: 'checkbox',
            selectedRowKeys,
            onChange: setSelectedRowKeys,
          }}
          pagination={false}
          columns={columns}
          dataSource={data}
          rowKey='id'
          loading={{
            indicator: <Spin />,
            spinning: isLoading,
          }}
          scroll={{ x: 'max-content' }}
          size='middle'
        />
      </div>
      <AppPagination
        pageNo={pageNo}
        pageSize={pageSize}
        total={count}
        setPageNo={setPageNo}
        setPageSize={setPageSize}
      />
      <Modal
        title={modalTitle}
        open={openModal}
        onCancel={() => {
          form.resetFields();
          setOpenModal(false);
        }}
        footer={null}
      >
        <TaskAssignForm
          form={form}
          onSubmit={handleTaskForm}
          loading={loading}
          onCancel={() => setOpenModal(false)}
        />
      </Modal>
    </div>
  );
};

export default TasksTable;
