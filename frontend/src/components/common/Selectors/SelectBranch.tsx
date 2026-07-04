import { useGetBranchOption } from '@/apis';
import { Select, SelectProps } from 'antd';
import React from 'react';

type SelectBranchProps = SelectProps;
export const SelectBranch: React.FC<SelectBranchProps> = (props) => {
  const { data } = useGetBranchOption();
  return <Select placeholder='Select branch' {...props} options={data} />;
};
