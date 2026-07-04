import React, { Suspense } from 'react';

const OTPLayout = ({ children }: { children: React.ReactNode }) => {
  return (
    <>
      <Suspense>{children}</Suspense>
    </>
  );
};

export default OTPLayout;
