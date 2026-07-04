'use client';
import { Role } from '@/enums';
import { withRole } from '@/libs';
import React from 'react';

const ComplianceRoleLayout = ({ children }: { children: React.ReactNode }) => {
  return <>{children}</>;
};

export default withRole(ComplianceRoleLayout, [
  Role.ADMIN,
  Role.MANAGER,
  Role.COMPLIANCE,
]);
