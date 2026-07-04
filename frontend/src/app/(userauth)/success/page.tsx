import { SuccessSetPasswordMessage } from '@/components/authcomponent/success';
import React from 'react';

const SuccessNewPassword = () => {
  return (
    <div className='relative flex min-h-screen flex-col items-center justify-center overflow-hidden'>
      <div className='m-6 rounded-md'>
        <div className='mx-auto'>
          <SuccessSetPasswordMessage />
        </div>
      </div>
    </div>
  );
};

export default SuccessNewPassword;
