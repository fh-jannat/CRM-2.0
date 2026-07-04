import { PlusOutlined } from '@ant-design/icons';
import { Button } from 'antd';
import Image from 'next/image';
import React from 'react';

type Props = {
  buttonText?: string;
  buttonOnClick?: () => void;
  title?: string;
  buttonIcon?: React.ReactNode;
};

const NoData: React.FC<Props> = ({
  buttonText,
  buttonOnClick,
  title,
  buttonIcon,
}) => {
  return (
    <div className='flex w-full flex-col items-center justify-center gap-[32px] py-[100px]'>
      <Image
        width={500}
        height={500}
        className='h-[120px] w-[120px]'
        src={`/no_data.png`}
        alt='Empty Data'
      />
      <div className='flex flex-col items-center justify-center gap-[24px] text-center'>
        <div className='flex flex-col gap-[6px]'>
          <div className='text-gray4 font-Inter text-[16px] font-bold'>
            {title}
          </div>
        </div>
        {buttonText && buttonOnClick && (
          <Button icon={buttonIcon ?? <PlusOutlined />} onClick={buttonOnClick}>
            {buttonText}
          </Button>
        )}
      </div>
    </div>
  );
};

export default NoData;
