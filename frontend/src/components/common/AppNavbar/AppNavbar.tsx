'use client';
import { logout, useGetUser } from '@/apis';
import { LOGIN_PATH } from '@/constants';
import { useLoadingContext } from '@/contexts';
import { useAdminLayout } from '@/contexts/AdminLayoutContext';
import { Role } from '@/enums';
import {
  DesktopOutlined,
  LogoutOutlined,
  MailOutlined,
  MenuFoldOutlined,
  MenuOutlined,
  MenuUnfoldOutlined,
  ScheduleOutlined,
  UsergroupAddOutlined,
} from '@ant-design/icons';
import { ChevronDownIcon } from '@radix-ui/react-icons';
import { Avatar, Button, Dropdown, MenuProps } from 'antd';
import Link from 'next/link';
import { usePathname, useRouter, useSearchParams } from 'next/navigation';
import { useState } from 'react';
import { toast } from 'react-toastify';
import AppPageTitle from './AppPageTitle';
import { NotificationBar } from './NotificationBar';

const AppNavbar = ({ role }: { role: Role }) => {
  const [showUserDropdown, setShowUserDropdown] = useState(false);
  const { collapsed, setCollapsed, setDrawer, drawer } = useAdminLayout();
  const { setIsLoadingGlobal } = useLoadingContext();
  const pathname = usePathname();
  const searchParams = useSearchParams();
  const currentPath = pathname + searchParams.toString();
  const redirectPath = `${LOGIN_PATH}?redirect=${encodeURIComponent(currentPath)}`;

  const { data } = useGetUser();
  const router = useRouter();

  // const toggleUserDropdown = (open: boolean) => {
  //   setShowUserDropdown(open);
  // };

  const singOutHandler = async () => {
    setIsLoadingGlobal(true);
    await logout();
    toast.success('Logout successfully');
    router.push(redirectPath);
  };

  const ICONS = {
    USERS: <UsergroupAddOutlined />,
    BRANCH: <DesktopOutlined />,
    UNIVERSITIES: <DesktopOutlined />,
    NOTIFICATIONS: <ScheduleOutlined />,
    ACTIVITIES: <ScheduleOutlined />,
    META: <ScheduleOutlined />,
    EMAIL: <MailOutlined />,
  };

  const BASE_MENU_ITEMS: any = {
    USERS: {
      label: <Link href='/users'>User Management</Link>,
      key: 'users',
      icon: ICONS.USERS,
    },
    BRANCH: {
      label: <Link href='/branch'>Branch Management</Link>,
      key: 'branch',
      icon: ICONS.BRANCH,
    },
    UNIVERSITIES: {
      label: <Link href='/universities'>Universities</Link>,
      key: 'universities',
      icon: ICONS.UNIVERSITIES,
    },
    NOTIFICATIONS: {
      label: <Link href='/notifications'>Notifications</Link>,
      key: 'notifications',
      icon: ICONS.NOTIFICATIONS,
    },
    ACTIVITIES: {
      label: <Link href='/activities'>Activities</Link>,
      key: 'activities',
      icon: ICONS.ACTIVITIES,
    },
    META: {
      label: <Link href='/metacredential'>Meta Credential</Link>,
      key: 'metacredential',
      icon: ICONS.META,
    },
    EMAIL: {
      label: <Link href='/emailcredential'>Email Credential</Link>,
      key: 'emailcredential',
      icon: ICONS.EMAIL,
    },
  };

  function generateMenuItems(role: string): MenuProps['items'] {
    const menuMap: any = {
      admin: [
        'USERS',
        'BRANCH',
        'UNIVERSITIES',
        'NOTIFICATIONS',
        'ACTIVITIES',
        'META',
        'EMAIL',
      ],
      application: ['NOTIFICATIONS', 'ACTIVITIES'],
      compliance: ['NOTIFICATIONS', 'ACTIVITIES'],
      counsellor: ['NOTIFICATIONS', 'ACTIVITIES'],
      manager: ['USERS', 'UNIVERSITIES', 'NOTIFICATIONS', 'ACTIVITIES'],
      teacher: ['NOTIFICATIONS', 'ACTIVITIES'],
    };

    const menuKeys = menuMap[role] || [];
    return menuKeys.map((key: any) => BASE_MENU_ITEMS[key]);
  }

  const items: MenuProps['items'] = [
    ...(generateMenuItems(role) || []),
    {
      key: 'divider',
      type: 'divider',
    },
    {
      key: 'logout',
      label: (
        <Button
          icon={<LogoutOutlined />}
          danger
          onClick={async () => {
            await singOutHandler();
          }}
          type='link'
        >
          Log Out
        </Button>
      ),
    },
  ];

  const menuButton = (
    <>
      <Button
        type='text'
        className='!hidden md:!block'
        icon={
          collapsed ? (
            <MenuUnfoldOutlined className='!text-gray1' />
          ) : (
            <MenuFoldOutlined className='!text-gray1' />
          )
        }
        onClick={() => setCollapsed(!collapsed)}
      />
      <Button
        type='text'
        className='md:!hidden'
        icon={<MenuOutlined className='!text-gray1' />}
        // icon={!drawer ? <MenuUnfoldOutlined className='!text-gray1'/> : <MenuFoldOutlined className='!text-gray1'/>}
        onClick={() => {
          setDrawer(!drawer);
        }}
      />
    </>
  );

  return (
    <div className='border-b-offWhite3 sticky top-0 z-50 flex h-[70px] min-h-[70px] w-full flex-row items-center justify-between gap-2 border-b-[1px] bg-white px-2 md:gap-5 md:px-5'>
      <div className='flex flex-row items-center gap-[2px] md:gap-2'>
        {menuButton}
        <AppPageTitle />
      </div>
      <div className='flex flex-row items-center gap-[16px]'>
        <NotificationBar />
        <Dropdown
          menu={{ items }}
          trigger={['click']}
          onOpenChange={(open) => setShowUserDropdown(open)}
          open={showUserDropdown}
        >
          <div className='flex cursor-pointer items-center space-x-2 rounded-full bg-gray-100 px-2 py-1 transition-colors duration-200 hover:bg-gray-200'>
            <Avatar className='bg-blue-500 text-white' size={36}>
              {data?.user?.fullName?.charAt(0)?.toUpperCase()}
            </Avatar>
            <div className='hidden md:block'>
              <div className='text-xs font-semibold text-gray-800'>
                {data?.user?.fullName}
              </div>
              <div className='text-xs text-gray-500'>{role}</div>
            </div>
            <ChevronDownIcon className='h-4 w-4 text-gray-400' />
          </div>
        </Dropdown>
      </div>
    </div>
  );
};

export default AppNavbar;
