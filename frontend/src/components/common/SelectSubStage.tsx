import React from 'react';
import { Select, SelectProps } from 'antd';
import { useGetStageOption } from '@/apis';

type SelectSubStageProps = SelectProps & {
  onChange?: (value: any) => void;
  stage?: string;
};
const SelectSubStage: React.FC<SelectSubStageProps> = ({
  onChange,
  stage,
  ...props
}) => {
  const { data: options } = useGetStageOption(stage);
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

export default SelectSubStage;
