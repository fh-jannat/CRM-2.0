'use client';
import { useGetMenu } from '@/apis';
import AppLoader from '@/components/Loader/AppLoader';

import { useAdminLayout } from '@/contexts';
import { E_STAGE, Role } from '@/enums';
import {
  AuditOutlined,
  FormOutlined,
  FundOutlined,
  IdcardOutlined,
  ScheduleOutlined,
  SolutionOutlined,
  UsergroupAddOutlined,
} from '@ant-design/icons';
import { Menu, MenuProps } from 'antd';
import Image from 'next/image';
import { usePathname, useRouter } from 'next/navigation';
import { useEffect, useState } from 'react';

const RoleBasedMenu = ({ role }: { role: Role }) => {
  const router = useRouter();
  const pathname = usePathname();
  const [selectedKeys, setSelectedKeys] = useState<string[]>([]);
  const { collapsed } = useAdminLayout();

  useEffect(() => {
    const pathParts = pathname.split('/').filter(Boolean);
    const key =
      pathParts.length > 1 ? `${pathParts[0]}/${pathParts[1]}` : pathParts[0];
    setSelectedKeys([key]);
  }, [pathname]);

  const handleMenuSelect = ({ key }: { key: React.Key }) => {
    router.push(`/${key}`);
  };

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
    <>
      <div className='border-b-offWhite3 flex h-[70px] w-full items-center justify-center border-b-2'>
        <Image
          src={collapsed ? '/navLogoRoundMain.png' : '/navLogoWide.png'}
          alt={''}
          width={500}
          height={500}
          style={{ width: collapsed ? 50 : '100%' }}
          className={`mx-2 flex h-[50px]`}
        />
      </div>
      <Menu
        theme='light'
        mode='inline'
        defaultSelectedKeys={selectedKeys}
        onClick={handleMenuSelect}
        selectedKeys={selectedKeys}
        style={{
          overflow: 'auto',
          height: '90vh',
          paddingTop: 10,
          border: 'none',
          transition: 'width 0.3s ease-in-out',
        }}
        items={generateMenuItems(role)}
      />
    </>
  );
};

export default RoleBasedMenu;
