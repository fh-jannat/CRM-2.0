import React from 'react';
import { Input, Tooltip } from 'antd';
import { CloseOutlined, SearchOutlined } from '@ant-design/icons';

interface TitleWithSearchFilterProps {
  title: string;
  filterVisible: boolean;
  onToggleFilterVisible: () => void;
}

const TitleWithSearchFilter: React.FC<TitleWithSearchFilterProps> = ({
  title,
  filterVisible,
  onToggleFilterVisible,
}) => {
  return (
    <>
      {filterVisible ? (
        <Input
          suffix={
            <Tooltip title='Hide Filter'>
              <CloseOutlined onClick={onToggleFilterVisible} />
            </Tooltip>
          }
          className='h-[30px] w-full'
          placeholder={title}
        />
      ) : (
        <div className='flex flex-row justify-between gap-1'>
          <span>{title}</span>
          <Tooltip title='Show Filter'>
            <SearchOutlined
              onClick={onToggleFilterVisible}
              className='cursor-pointer'
            />
          </Tooltip>
        </div>
      )}
    </>
  );
};

export default TitleWithSearchFilter;
