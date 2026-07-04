import Image from 'next/image';
import { ReactNode } from 'react';

export const SignInFormServer = ({ children }: { children: ReactNode }) => {
  return (
    <div className='flex h-[90vh] w-full flex-col items-center justify-center'>
      <div className='w-full max-w-md rounded-l-lg bg-white p-8'>
        <div className='justify-left mb-8 flex items-center'>
          <Image
            src='/navLogoWide.png'
            alt='logo image'
            height={500}
            width={500}
            className='h-12 w-auto'
          />
        </div>
        <h2 className='mb-4 text-lg font-bold text-[#2A0D45]'>
          Log in to your Account
        </h2>
        <p className='mb-6 text-[14px] text-[#645F7C]'>
          Use your email to log in to your account
        </p>
        {children}
      </div>
    </div>
  );
};
