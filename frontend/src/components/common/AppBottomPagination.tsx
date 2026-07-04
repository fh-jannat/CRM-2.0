'use client';
import { useAdminLayout } from '@/contexts/AdminLayoutContext';
import { Pagination, Select, theme } from 'antd';
import React from 'react';
interface AppPaginationProps {
  pageSize: number;
  pageNo: number;
  total: number;
  onPageSizeChange: (value: number) => void;
  setPageNo: (page: number) => void;
}

export const AppPagination: React.FC<AppPaginationProps> = ({
  pageSize,
  pageNo,
  total,
  setPageNo,
  onPageSizeChange,
}) => {
  const { collapsed } = useAdminLayout();
  const {
    token: { borderRadiusLG },
  } = theme.useToken();
  return (
    <div
      style={{
        left: collapsed ? '80px' : '200px',
        background: '#fff',
        borderRadius: borderRadiusLG,
        zIndex: 10,
        transition: 'left 0.3s ease-in-out',
      }}
      className='fixed bottom-0 left-[220px] right-0 flex h-[55px] flex-row items-center justify-between px-[24px]'
    >
      <div className='font-Inter flex gap-2 text-[13px] font-semibold'>
        Showing items
        <Select
          defaultValue={pageSize}
          size='small'
          onChange={(value: number) => {
            onPageSizeChange(value);
            setPageNo(1);
          }}
          options={[
            { label: 1, value: 1 },
            { label: 2, value: 2 },
            { label: 5, value: 5 },
            { label: 10, value: 10 },
            { label: 20, value: 20 },
            { label: 50, value: 50 },
            { label: 100, value: 100 },
          ]}
        />
        per page
      </div>
      <Pagination
        className='max-h-[55px]'
        pageSize={pageSize}
        current={pageNo}
        total={total}
        showSizeChanger={false}
        onChange={setPageNo}
      />
    </div>
  );
};

export default AppPagination;
