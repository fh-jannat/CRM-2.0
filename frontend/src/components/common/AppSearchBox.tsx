import { SearchOutlined } from '@ant-design/icons';
import { Input, InputProps } from 'antd';
import React from 'react';

const AppSearchBox: React.FC<InputProps> = (props: InputProps) => {
  return (
    <Input
      prefix={<SearchOutlined className='text-gray2' />}
      className='bg-offWhite2 h-[30px] min-w-[250px] max-w-[300px] !rounded-[4px]'
      {...props}
    />
  );
};

export default AppSearchBox;
