import React, { Suspense } from 'react';

const SetPasswordLayout = ({ children }: { children: React.ReactNode }) => {
  return (
    <>
      <Suspense>{children}</Suspense>
    </>
  );
};

export default SetPasswordLayout;
