import React from 'react';

export default function AuthLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <div className='font-proxima flex w-full flex-row'>
      <div className='my-5 flex w-full flex-col items-center justify-center overflow-y-auto lg:w-[50%]'>
        {children}
      </div>
      <div
        style={{
          backgroundImage: `linear-gradient(180deg, rgba(81, 133, 129, 0.3) 0%, rgba(255, 215, 148, 0.3) 100%), url("/banner.png")`,
          backgroundPosition: 'center',
          backgroundSize: 'contain',
          backgroundRepeat: 'no-repeat',
        }}
        className='hidden min-h-screen flex-1 lg:block'
      />
    </div>
  );
}
