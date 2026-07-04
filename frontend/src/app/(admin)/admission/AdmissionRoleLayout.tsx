'use client';
import { Role } from '@/enums';
import { withRole } from '@/libs';
import React from 'react';

const AdmissionRoleLayout = ({ children }: { children: React.ReactNode }) => {
  return <>{children}</>;
};

export default withRole(AdmissionRoleLayout, [
  Role.ADMIN,
  Role.MANAGER,
  Role.APPLICATION,
]);
