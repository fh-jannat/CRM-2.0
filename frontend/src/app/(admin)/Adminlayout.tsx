'use client';
import { useGetRolesQuery } from '@/apis';
import AppNavbar from '@/components/common/AppNavbar/AppNavbar';
import RoleBasedMenu from '@/components/common/role-based-menu/RoleBasedMenu';
import { useAdminLayout } from '@/contexts/AdminLayoutContext';
import { Role } from '@/enums';
import { withRole } from '@/libs';
import { CloseOutlined } from '@ant-design/icons';
import { Drawer } from 'antd';
import Sider from 'antd/es/layout/Sider';
import React from 'react';

const AdminLayout = ({ children }: { children: React.ReactNode }) => {
  const { collapsed, drawer, setDrawer } = useAdminLayout();
  const { data } = useGetRolesQuery();

  return (
    <div className='relative flex h-screen w-full'>
      <Sider
        theme='light'
        trigger={null}
        collapsible
        collapsed={collapsed}
        className='!sticky !top-0 !hidden !h-screen overflow-y-auto md:!block'
        style={{
          overflowY: 'auto',
          overflowX: 'hidden',
          transition: 'ease-in-out 0.2s',
          height: '100vh',
          border: '1px solid #DFE3E8',
          zIndex: 10,
          boxShadow: '0px 1px 3px 0px #2C304014',
          background: 'white',
        }}
      >
        <RoleBasedMenu role={data[0]} />
      </Sider>
      <Drawer
        placement='left'
        closeIcon={<CloseOutlined />}
        closable={true}
        onClose={() => setDrawer(false)}
        open={drawer}
        width={280}
      >
        <RoleBasedMenu role={data[0]} />
      </Drawer>
      <div className='w-full overflow-y-auto'>
        <AppNavbar role={data[0]} />
        {/* contents */}
        <div className=' bg-[#FAFAFA] px-2 pt-2 md:px-3 md:pt-3'>
          {children}
        </div>
      </div>
    </div>
  );
};

export default withRole(AdminLayout, [
  Role.ADMIN,
  Role.MANAGER,
  Role.COUNSELLOR,
  Role.APPLICATION,
  Role.COMPLIANCE,
  Role.TEACHER,
  Role.STUDENT,
]);
// export default withAuth(AdminLayout);
