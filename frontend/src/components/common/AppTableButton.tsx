import { Button } from 'antd';
import React, { ReactNode } from 'react';

interface AppTableButtonProps {
  icon?: ReactNode;
  text: string;
  color?: string;
  onClick?: () => void;
}

const AppTableButton: React.FC<AppTableButtonProps> = ({
  icon,
  text,
  color,
  onClick,
}) => {
  return (
    <Button
      onClick={onClick}
      icon={icon}
      type='link'
      style={{ color: color ?? 'blue' }}
      className='font-Inter text-[12px] font-semibold leading-[18px]'
    >
      {text}
    </Button>
  );
};

export default AppTableButton;
