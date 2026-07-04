'use client';
import { Role } from '@/enums';
import { withRole } from '@/libs';
import React from 'react';

const PotentialRoleLayout = ({ children }: { children: React.ReactNode }) => {
  return <>{children}</>;
};

export default withRole(PotentialRoleLayout, [
  Role.ADMIN,
  Role.MANAGER,
  Role.COUNSELLOR,
]);
