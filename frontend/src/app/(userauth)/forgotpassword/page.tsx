import { ForgotPasswordForm } from '@/components/authcomponent/forgotpassword';
import React from 'react';

const SendOTP = () => {
  return (
    <div className='relative flex  h-screen min-h-screen flex-col items-center justify-center overflow-hidden'>
      <div className='m-6 rounded-md'>
        <div className='mx-auto'>
          <ForgotPasswordForm />
        </div>
      </div>
    </div>
  );
};

export default SendOTP;
