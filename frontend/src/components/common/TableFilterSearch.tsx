import React, { useState } from 'react';
import { debounce } from '@/utils/debounce';
import { CloseOutlined, SearchOutlined } from '@ant-design/icons';
import { Input } from 'antd';

type TableFilterSearchProps = {
  onSearch: (value: string) => void;
  placeholder: string;
};

const TableFilterSearch: React.FC<TableFilterSearchProps> = ({
  onSearch,
  placeholder,
}) => {
  const [searchValue, setSearchValue] = useState<string>('');
  const debouncedOnSearch = debounce(onSearch, 300);

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { value } = e.target;
    setSearchValue(value);
    debouncedOnSearch(value);
  };

  const clearInput = () => {
    if (searchValue !== '') {
      setSearchValue('');
      onSearch('');
    }
  };

  return (
    <Input
      prefix={<SearchOutlined />}
      style={{ border: '1px solid #d9d9d9' }}
      value={searchValue}
      onChange={handleInputChange}
      placeholder={placeholder}
      suffix={
        <CloseOutlined
          size={1}
          className='cursor-pointer'
          onClick={clearInput}
        />
      }
    />
  );
};

export default TableFilterSearch;
