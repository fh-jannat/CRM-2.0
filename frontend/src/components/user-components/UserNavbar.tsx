'use client';
import { logout, useGetUser } from '@/apis';
import { LOGIN_PATH } from '@/constants';
import { useLoadingContext } from '@/contexts';
import { DownOutlined, LogoutOutlined } from '@ant-design/icons';
import { Avatar, Button, Dropdown, MenuProps } from 'antd';
import Image from 'next/image';
import { usePathname, useRouter, useSearchParams } from 'next/navigation';
import React, { useState } from 'react';
import { toast } from 'react-toastify';

const UserNavbar: React.FC = () => {
  const { setIsLoadingGlobal } = useLoadingContext();
  const [showUserDropdown, setShowUserDropdown] = useState(false);
  const router = useRouter();
  const pathname = usePathname();
  const searchParams = useSearchParams();
  const currentPath = pathname + searchParams.toString();
  const redirectPath = `${LOGIN_PATH}?redirect=${encodeURIComponent(currentPath)}`;

  const { data } = useGetUser();

  const singOutHandler = async () => {
    setIsLoadingGlobal(true);
    await logout();
    toast.success('Logout successfully');
    router.push(redirectPath);
  };

  const items: MenuProps['items'] = [
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

  const toggleUserDropdown = (open: boolean) => {
    setShowUserDropdown(open);
  };

  return (
    <div
      style={{
        boxShadow:
          'rgba(50, 50, 93, 0.25) 0px 2px 5px -1px, rgba(0, 0, 0, 0.3) 0px 1px 3px -1px',
      }}
      className='sticky top-0 z-10 h-[60px] w-full bg-white'
    >
      <div className='flex h-full items-center justify-between px-4'>
        <div className='my-[6px] flex h-[50px] flex-row items-center justify-center gap-2'>
          <Image
            src={'/navLogoRoundMain.png'}
            alt={''}
            width={500}
            height={500}
            className='flex h-[50px] w-[50px]'
          />
          <Image
            src={'/navLogoWide.png'}
            alt={''}
            width={500}
            height={500}
            className='hidden h-[30px] w-[150px] md:flex'
          />
          <div className='w-full border-b-[2px] border-b-gray-100 shadow-lg' />
        </div>
        <div className='flex items-center'>
          <div className='flex h-[40px] flex-row items-center justify-center gap-2 px-[10px]'>
            <Avatar className='bg-[#2A9467]' size={32}>
              {data?.user?.fullName?.charAt(0)?.toUpperCase()}
            </Avatar>
            <div className='text-gray4 font-Inter text-[13px] font-semibold leading-[20px]'>
              {data?.user?.fullName}
            </div>
            <Dropdown
              trigger={['click']}
              menu={{ items }}
              open={showUserDropdown}
              onOpenChange={toggleUserDropdown}
              overlayStyle={{ minWidth: '150px' }}
            >
              <DownOutlined className='text-gray4 font-Inter text-[13px] font-semibold leading-[20px]' />
            </Dropdown>
          </div>
        </div>
      </div>
    </div>
  );
};

export default UserNavbar;
