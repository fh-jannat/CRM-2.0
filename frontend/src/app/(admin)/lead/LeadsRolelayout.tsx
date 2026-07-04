'use client';
import { Role } from '@/enums';
import { withRole } from '@/libs';
import React from 'react';

const LeadsRolelayout = ({ children }: { children: React.ReactNode }) => {
  return <>{children}</>;
};

export default withRole(LeadsRolelayout, [
  Role.ADMIN,
  Role.MANAGER,
  Role.COUNSELLOR,
]);
