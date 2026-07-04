'use client';
import React, { FC, ReactNode } from 'react';

interface PrimaryButtonProps {
  text: ReactNode;
  className?: string;
  type?: 'button' | 'submit' | 'reset';
  onClick?: () => void;
}

const PrimaryButton: FC<PrimaryButtonProps> = ({
  text,
  className,
  type,
  onClick,
}) => {
  return (
    <button
      onClick={onClick}
      type={type}
      className={`md:text-md flex w-[130px] items-center justify-center bg-primaryColor p-2 text-sm text-white md:h-[52px] md:w-[170px] md:p-4 ${className} `}
    >
      {text}
    </button>
  );
};

export default PrimaryButton;
