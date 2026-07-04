'use client';
import { handleErrorToast } from '@/utils/handleErrorToast';
import { DeleteOutlined, PlusOutlined } from '@ant-design/icons';
import {
  Button,
  Checkbox,
  Form,
  Modal,
  Popconfirm,
  Spin,
  Table,
  TableColumnsType,
} from 'antd';
import dayjs from 'dayjs';
import { useEffect, useState } from 'react';
import ActionButton from '../common/ActionButton';
import { AppPagination } from '../common/AppPagination';
import TableTopButton from '../common/TableTopButton';
import { toast } from 'react-toastify';
import AppTableButton from '../common/AppTableButton';
import {
  useCreateMetacridential,
  useDeleteMetacridential,
  useGetAllMetacridentials,
  useGetMetacridentialCount,
  useUpdateMetacridential,
} from '@/apis';
import { MetacridentialForm } from './MetacridentialForm';

export const MetacridentialTable = () => {
  const [form] = Form.useForm();
  const [loading, setLoading] = useState(false);
  const [pageNo, setPageNo] = useState<number>(1);
  const [pageSize, setPageSize] = useState<number>(10);
  const [searchParams, setSearchParams] = useState<{ [key: string]: any }>({});

  const [selectedRowKeys, setSelectedRowKeys] = useState<React.Key[]>([]);
  const hasSelected = selectedRowKeys.length > 0;

  const [openModal, setOpenModal] = useState<boolean>(false);
  const [modalTitle, setModalTitle] = useState<string>('Add New Cridential');

  const [query, setQuery] = useState<any>({
    query: {
      page: pageNo,
      limit: pageSize,
      where: searchParams,
    },
  });

  const { data, refetch, isLoading } = useGetAllMetacridentials(query);
  const { data: count, refetch: refetchCount } =
    useGetMetacridentialCount(query);
  const createMetacridential = useCreateMetacridential();
  const updateMetacridential = useUpdateMetacridential();
  const deleteMetacridential = useDeleteMetacridential();

  useEffect(() => {
    setQuery({
      query: {
        page: pageNo,
        limit: pageSize,
        where: searchParams,
      },
    });
  }, [count, pageNo, pageSize]);

  // eslint-disable-next-line
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

  const multipleDelete = async () => {
    await Promise.all(
      selectedRowKeys.map(async (id) => {
        await deleteMetacridential.mutateAsync(id as number);
      })
    );
    setSelectedRowKeys([]);
    await refetch();
    await refetchCount();
    toast.success('Metacridentials deleted successfully');
  };

  const handleMetacridentialForm = async (value: any) => {
    setLoading(true);
    try {
      if (value.id) {
        await updateMetacridential.mutateAsync(value);
        toast.success('Metacridential updated successfully');
      } else {
        await createMetacridential.mutateAsync(value);
        toast.success('Metacridential created successfully');
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
      title: 'Sl',
      render: (_, __, index) => (pageNo - 1) * pageSize + (index + 1),
    },
    {
      title: 'App Id',
      dataIndex: 'appId',
    },
    {
      title: 'App Secret',
      dataIndex: 'appSecret',
    },
    {
      title: 'Page Id',
      dataIndex: 'pageId',
    },
    {
      title: 'Page Access Token',
      dataIndex: 'pageAccessToken',
    },
    {
      title: 'Created On',
      dataIndex: 'createdAt',
      render: (value) => <>{dayjs(value).format('MMM D, YYYY h:mm A')}</>,
    },
    {
      title: 'Actions',
      width: '90px',
      fixed: 'right',
      render: (record) => (
        <div className='flex flex-row gap-1'>
          <>
            <ActionButton.Edit
              onClick={() => {
                form.setFieldsValue(record);
                setModalTitle('Edit Meta-cridential');
                setOpenModal(true);
              }}
            />
            <ActionButton.DeleteWithConfirmation
              onClick={async () => {
                await deleteMetacridential.mutateAsync(record.id);
                await refetch();
                await refetchCount();
                toast.success('Metacridential deleted successfully');
              }}
            />
          </>
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
            text='Add New Metacridential'
            onClick={() => {
              setModalTitle('Add New Metacridential');
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
            <Popconfirm
              title={`Are you sure to delete ${selectedRowKeys.length} meta cridential?`}
              onConfirm={() => multipleDelete()}
              okButtonProps={{ danger: true }}
            >
              <AppTableButton
                color='red'
                text='Delete meta cridentials'
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
        <MetacridentialForm
          form={form}
          onSubmit={handleMetacridentialForm}
          loading={loading}
          onCancel={() => setOpenModal(false)}
        />
      </Modal>
    </div>
  );
};
