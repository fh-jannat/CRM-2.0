import React from 'react';
import { FiPackage } from 'react-icons/fi';

type Props = {
  message: string;
  description?: string;
  className?: string;
};

export const EmptyState: React.FC<Props> = ({
  message,
  description,
  className,
}) => {
  return (
    <div
      className={`${className} flex h-64 flex-col items-center justify-center`}
    >
      <FiPackage className='mb-4 text-6xl text-gray-400' />
      <h3 className='mb-2 text-xl font-semibold text-gray-600'>{message}</h3>
      {description && <p className='text-gray-500'>{description}</p>}
    </div>
  );
};
