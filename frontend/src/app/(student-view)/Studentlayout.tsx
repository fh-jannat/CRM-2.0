'use client';
import UserNavbar from '@/components/user-components/UserNavbar';
import { Role } from '@/enums';
import { withRole } from '@/libs';
import React from 'react';

const StudentLayout = ({ children }: { children: React.ReactNode }) => {
  return (
    <div className='relative flex w-full flex-col'>
      <UserNavbar />
      <div className='px-2 py-2 md:px-4 md:py-4'>{children}</div>
    </div>
  );
};

export default withRole(StudentLayout, [Role.ADMIN, Role.STUDENT]);
