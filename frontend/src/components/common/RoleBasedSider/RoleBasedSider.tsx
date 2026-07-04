'use client';
import { useAdminLayout } from '@/contexts/AdminLayoutContext';
import { Role } from '@/enums/role.enum';
import { withRole } from '@/libs';
import { Menu, MenuProps } from 'antd';
import Sider from 'antd/es/layout/Sider';
import Image from 'next/image';
import { usePathname, useRouter } from 'next/navigation';
import React, { useEffect, useState } from 'react';
import Link from 'next/link';
import { useGetMenu } from '@/apis';
import { E_STAGE } from '@/enums';
import {
  FundOutlined,
  SolutionOutlined,
  IdcardOutlined,
  FormOutlined,
  UsergroupAddOutlined,
  ScheduleOutlined,
  AuditOutlined,
} from '@ant-design/icons';
import AppLoader from '@/components/Loader/AppLoader';

const DynamicSidebar = ({ role }: { role: Role }) => {
  const router = useRouter();
  const pathname = usePathname();
  const { collapsed } = useAdminLayout();
  const [selectedKeys, setSelectedKeys] = useState<string[]>([]);

  const { data: leadMenu, isLoading: leadIsLoading } = useGetMenu(E_STAGE.LEAD);
  const { data: potentialMenu, isLoading: potentialIsLoading } = useGetMenu(
    E_STAGE.POTENTIAL
  );
  const { data: admissionMenu, isLoading: admissionIsLoading } = useGetMenu(
    E_STAGE.ADMISSION
  );
  const { data: complianceMenu, isLoading: complianceIsLoading } = useGetMenu(
    E_STAGE.COMPLIANCE
  );

  useEffect(() => {
    const pathParts = pathname.split('/').filter(Boolean);
    const key =
      pathParts.length > 1 ? `${pathParts[0]}/${pathParts[1]}` : pathParts[0];
    setSelectedKeys([key]);
  }, [pathname]);

  const handleMenuSelect = ({ key }: { key: React.Key }) => {
    router.push(`/${key}`);
  };

  if (
    leadIsLoading ||
    potentialIsLoading ||
    admissionIsLoading ||
    complianceIsLoading
  ) {
    return <AppLoader />;
  }

  const ICONS = {
    DASHBOARD: <FundOutlined />,
    LEADS: <SolutionOutlined />,
    STUDENT: <IdcardOutlined />,
    ADMISSION: <FormOutlined />,
    VISA: <IdcardOutlined />,
    ENGLISH: <UsergroupAddOutlined />,
    TASKS: <ScheduleOutlined />,
    REPORTS: <AuditOutlined />,
  };

  const BASE_MENU_ITEMS: any = {
    DASHBOARD: { label: 'Dashboard', key: 'dashboard', icon: ICONS.DASHBOARD },
    ALL: { label: 'All', key: 'all', icon: ICONS.DASHBOARD },
    LEADS: {
      label: 'Leads',
      key: 'leads',
      icon: ICONS.LEADS,
      children: [...leadMenu],
    },
    STUDENT: {
      label: 'Student',
      key: 'student',
      icon: ICONS.STUDENT,
      children: [...potentialMenu],
    },
    ADMISSION: {
      label: 'Admission',
      key: 'admission',
      icon: ICONS.ADMISSION,
      children: [...admissionMenu],
    },
    VISA: {
      label: 'Visa Compliances',
      key: 'visa-compliances',
      icon: ICONS.VISA,
      children: [...complianceMenu],
    },
    ENGLISH: {
      label: 'Admitted for english',
      key: 'english-admission',
      icon: ICONS.ENGLISH,
    },
    TASKS: { label: 'Tasks', key: 'tasks', icon: ICONS.TASKS },
    REPORTS: { label: 'Reports', key: 'reports', icon: ICONS.REPORTS },
  };

  function generateMenuItems(role: string): MenuProps['items'] {
    const menuMap: any = {
      admin: [
        'DASHBOARD',
        'ALL',
        'LEADS',
        'STUDENT',
        'ADMISSION',
        'VISA',
        'ENGLISH',
        'TASKS',
        'REPORTS',
      ],
      application: ['DASHBOARD', 'ADMISSION', 'TASKS'],
      compliance: ['DASHBOARD', 'VISA', 'TASKS'],
      counsellor: ['DASHBOARD', 'LEADS', 'STUDENT', 'TASKS'],
      manager: [
        'DASHBOARD',
        'ALL',
        'LEADS',
        'STUDENT',
        'ADMISSION',
        'VISA',
        'ENGLISH',
        'TASKS',
        'REPORTS',
      ],
      teacher: ['DASHBOARD', 'ENGLISH', 'TASKS'],
    };

    const menuKeys = menuMap[role] || [];
    return menuKeys.map((key: any) => BASE_MENU_ITEMS[key]);
  }

  return (
    <Sider
      theme='light'
      trigger={null}
      collapsible
      collapsed={collapsed}
      style={{
        left: 0,
        position: 'fixed',
        transition: 'width 0.3s ease-in-out',
        width: collapsed ? 80 : 220,
      }}
    >
      <div
        className='mt-[6px] flex h-[50px] w-[50px] flex-col items-center justify-center border-b border-b-slate-300'
        style={{
          width: collapsed ? 80 : 220,
          transition: 'width 0.3s ease-in-out',
        }}
      >
        <Link href={'/'}>
          <Image
            src={collapsed ? '/navLogoRoundMain.png' : '/navLogoWide.png'}
            alt=''
            width={500}
            height={500}
            style={{ width: collapsed ? 50 : '100%' }}
            className={`flex h-[50px]`}
          />
        </Link>
      </div>
      <Menu
        theme='light'
        mode='inline'
        defaultSelectedKeys={selectedKeys}
        onClick={handleMenuSelect}
        selectedKeys={selectedKeys}
        style={{
          overflow: 'auto',
          left: 0,
          height: 'calc(100vh - 60px)',
          paddingTop: 2,
          position: 'fixed',
          width: collapsed ? 80 : 220,
          transition: 'width 0.3s ease-in-out',
        }}
        items={generateMenuItems(role)}
      />
    </Sider>
  );
};

export default withRole(DynamicSidebar, [
  Role.ADMIN,
  Role.MANAGER,
  Role.APPLICATION,
  Role.COUNSELLOR,
  Role.COMPLIANCE,
  Role.TEACHER,
  Role.STUDENT,
]);
