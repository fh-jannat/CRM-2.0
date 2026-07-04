'use client';
import { useAdminLayout } from '@/contexts/AdminLayoutContext';
import {
  AuditOutlined,
  DesktopOutlined,
  FormOutlined,
  FundOutlined,
  IdcardOutlined,
  ReadOutlined,
  ScheduleOutlined,
  SolutionOutlined,
  UsergroupAddOutlined,
} from '@ant-design/icons';
import { Menu, MenuProps } from 'antd';
import Sider from 'antd/es/layout/Sider';
import Image from 'next/image';
import { usePathname, useRouter } from 'next/navigation';
import React, { useEffect, useState } from 'react';

const AdminSider = () => {
  const router = useRouter();
  const pathname = usePathname();
  const [selectedKeys, setSelectedKeys] = useState<string[]>([]);
  const { collapsed } = useAdminLayout();

  useEffect(() => {
    const path = pathname.split('/')[1];
    setSelectedKeys([path]);
  }, [pathname]);

  const handleMenuSelect = ({ key }: { key: React.Key }) => {
    console.log({ key });
    router.push(`/${key}`);
  };

  const adminMenuItems: MenuProps['items'] = [
    { label: 'Dashboard', key: 'dashboard', icon: <FundOutlined /> },
    { label: 'All Leads', key: 'all-leads', icon: <ReadOutlined /> },
    {
      label: 'Leads',
      key: 'leads',
      onTitleClick: () => {
        router.push('/new-leads');
      },
      icon: <SolutionOutlined />,
      children: [
        { label: 'New Leads', key: 'new-leads' },
        { label: '1st Contact', key: '1st-contact' },
        { label: '2nd Contact', key: '2nd-contact' },
        { label: '3rd Contact', key: '3rd-contact' },
        { label: 'Final Call', key: 'final-call' },
        { label: 'Not Interested', key: 'not-interested' },
        { label: 'Unreachable', key: 'unreachable' },
      ],
    },
    {
      label: 'Student',
      key: 'student',
      onTitleClick: () => router.push('/appointment-book'),
      icon: <IdcardOutlined />,
      children: [
        { label: 'Appointment Book', key: 'appointment-book' },
        { label: 'Waiting for Documents', key: 'waiting-for-documents' },
      ],
    },
    {
      label: 'Admission',
      key: 'admission',
      onTitleClick: () => router.push('/applied'),
      icon: <FormOutlined />,
      children: [
        { label: 'Applied', key: 'applied' },
        { label: 'Waiting for offer', key: 'waiting-for-offer' },
        { label: 'Offer Received', key: 'offer-received' },
        { label: 'Paid', key: 'paid' },
      ],
    },
    {
      label: 'Visa Compliances',
      key: 'visa-compliances',
      onTitleClick: () => router.push('/visa-issued'),
      icon: <IdcardOutlined />,
      children: [
        { label: 'Waiting for cas', key: 'waiting-for-cas' },
        { label: 'Interview in process', key: 'interview-in-process' },
        {
          label: 'Cas or final confirmation offered issued',
          key: 'cas-or-final-confirmation',
        },
        { label: 'Applied for visa', key: 'applied-for-visa' },
        { label: 'Visa Issued', key: 'visa-issued' },
        { label: 'Enrolled', key: 'enrolled' },
        { label: 'Refund', key: 'refund' },
        { label: 'Withdrawn', key: 'withdrawn' },
      ],
    },
    {
      label: 'Admitted for english',
      key: 'admitted-for-english',
      icon: <UsergroupAddOutlined />,
    },
    { label: 'Application', key: 'application', icon: <ScheduleOutlined /> },
    {
      label: 'Pending Docs',
      key: 'pendingtask',
      icon: <UsergroupAddOutlined />,
    },
    { label: 'Tasks', key: 'tasks', icon: <ScheduleOutlined /> },
    { label: 'Reports', key: 'reports', icon: <AuditOutlined /> },
    { label: 'User Management', key: 'users', icon: <UsergroupAddOutlined /> },
    { label: 'Universities', key: 'universities', icon: <DesktopOutlined /> },
    {
      label: 'Notificaitons',
      key: 'notifications',
      icon: <ScheduleOutlined />,
    },
    { label: 'Activities', key: 'activities', icon: <ScheduleOutlined /> },
    {
      label: 'Meta Credential',
      key: 'metacredential',
      icon: <ScheduleOutlined />,
    },
  ];

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
        className='my-[6px] flex h-[50px] w-[50px] flex-col items-center justify-center gap-[5px]'
        style={{
          width: collapsed ? 80 : 220,
          transition: 'width 0.3s ease-in-out',
        }}
      >
        <Image
          src={
            '/saascrm.frontend.factoryze.tech/src/components/common/AppMenu.tsx.png'
          }
          alt={''}
          width={500}
          height={500}
          className='flex h-[50px] w-[50px]'
        />
        <div className='w-full border-b-[2px] border-b-gray-100 shadow-lg' />
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
          height: 'calc(100vh - 70px)',
          paddingTop: 10,
          position: 'fixed',
          width: collapsed ? 80 : 220,
          transition: 'width 0.3s ease-in-out',
        }}
        items={adminMenuItems}
      />
    </Sider>
  );
};

export default AdminSider;
