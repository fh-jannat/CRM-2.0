import React from 'react';
import { Select, SelectProps } from 'antd';
import { E_STAGE } from '@/enums';
import { optionGenerator } from '@/utils';

type SelectStageProps = SelectProps & {
  onChange?: (value: any) => void;
  stage?: string;
};
const SelectStage: React.FC<SelectStageProps> = ({ onChange, ...props }) => {
  return (
    <Select
      {...props}
      options={optionGenerator(E_STAGE)}
      onChange={(value) => {
        onChange?.(value);
      }}
    />
  );
};

export default SelectStage;
