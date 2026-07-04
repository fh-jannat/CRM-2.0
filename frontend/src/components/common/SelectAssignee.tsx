import { useGetRoleOption } from '@/apis';
import { Select, SelectProps } from 'antd';
import React from 'react';

type SelectAssigneeProps = SelectProps & {
  onChange?: (value: any) => void;
  stage?: string;
  branchSpecificApplication?: boolean;
};
const SelectAssignee: React.FC<SelectAssigneeProps> = ({
  onChange,
  stage = 'all',
  branchSpecificApplication = false,
  ...props
}) => {
  const { data: options } = useGetRoleOption(
    stage ?? 'all',
    branchSpecificApplication
  );

  return (
    <Select
      {...props}
      options={options}
      onChange={(value) => {
        onChange?.(value);
      }}
    />
  );
};

export default SelectAssignee;
