'use client';
import {
  useGetAllNotifications,
  useGetNotificationCountUnread,
  useUpdateNotification,
} from '@/apis';
import { useSocket } from '@/contexts';
import { Button, Dropdown, Tabs, Typography } from 'antd';
import dayjs from 'dayjs';
import Link from 'next/link';
import { usePathname } from 'next/navigation';
import { useEffect, useRef, useState } from 'react';
import { FaBell, FaCheckCircle, FaInfoCircle } from 'react-icons/fa';
import { NotificationButton } from './NotificationButton';

const { Text } = Typography;

interface Notification {
  id: number;
  message: string;
  isRead: boolean;
  url: string;
  createdAt: string;
}

export function NotificationBar() {
  const [menuOpen, setMenuOpen] = useState<boolean>(false);
  const { data, refetch } = useGetAllNotifications();
  const { data: count, refetch: refetchCount } =
    useGetNotificationCountUnread();
  const updateNotification = useUpdateNotification();

  const updateNotificationById = async (id: number) => {
    await updateNotification.mutateAsync({ id });
    await refetch();
    await refetchCount();
  };

  const { socket } = useSocket();
  const pathname = usePathname();
  const audioRef = useRef<HTMLAudioElement>(null);

  useEffect(() => {
    const asyncRefetch = async () => {
      await refetch();
      await refetchCount();
    };
    asyncRefetch();
  }, [pathname]);

  useEffect(() => {
    if (socket) {
      socket.on('message', async (message: string) => {
        console.log('Received message:', message);
        await refetch();
        await refetchCount();
        if (audioRef.current) {
          audioRef.current.play();
        }
      });

      return () => {
        socket.off('message');
      };
    }
  }, [socket, refetch, refetchCount]);

  const renderNotifications = (filter: string) => {
    if (!data || data.length === 0) {
      return (
        <div className='flex min-h-[200px] flex-col items-center justify-center'>
          <FaBell className='mb-2 text-4xl text-gray-300' />
          <Text type='secondary'>No notifications</Text>
        </div>
      );
    }

    const getNotificationIcon = (isRead?: boolean) => {
      if (isRead) {
        return <FaCheckCircle className='text-green-500' />;
      } else {
        return <FaInfoCircle className='text-blue-500' />;
      }
    };

    return data
      .filter(
        (notification: Notification) =>
          filter === 'all' ||
          (filter === 'unread' && !notification.isRead) ||
          (filter === 'read' && notification.isRead)
      )
      .map((notification: Notification) => (
        <div
          key={notification.id}
          className={`
            ${!notification.isRead ? 'bg-blue-50' : 'bg-white'}
            mb-2 flex cursor-pointer items-start rounded-lg p-3 transition-colors duration-200 hover:bg-gray-100
          `}
          onClick={() => updateNotificationById(notification.id)}
        >
          <Link
            href={`/${notification.url}`}
            className='flex w-full items-start'
            onClick={() => setMenuOpen(false)}
          >
            <div className='mr-3 text-xl'>
              {getNotificationIcon(notification.isRead)}
            </div>
            <div className='min-w-0 flex-grow'>
              <div>
                <Text strong className='mb-1 block truncate'>
                  {notification.message}
                </Text>
                <Text type='secondary' className='block text-xs'>
                  {dayjs(notification.createdAt).format('MMM D, YYYY h:mm A')}
                </Text>
              </div>
            </div>
            {!notification.isRead && (
              <div className='mt-2 h-2 w-2 flex-shrink-0 rounded-full bg-blue-500'></div>
            )}
          </Link>
        </div>
      ));
  };

  const tabItems = [
    {
      key: 'all',
      label: 'All',
      children: renderNotifications('all'),
    },
    {
      key: 'unread',
      label: 'Unread',
      children: renderNotifications('unread'),
    },
    {
      key: 'read',
      label: 'Read',
      children: renderNotifications('read'),
    },
  ];

  const menu = (
    <div className='max-h-[50vh] w-80 divide-y divide-gray-100 overflow-y-scroll rounded-md bg-white px-4 py-3 shadow-lg ring-1 ring-green-50'>
      <Tabs defaultActiveKey='all' items={tabItems} rootClassName='pb-32' />
      <div className='absolute bottom-1 mt-4 w-72'>
        <Link href='/notifications'>
          <Button
            className='w-full'
            onClick={() => setMenuOpen(!menuOpen)}
            block
            type='primary'
          >
            See all...
          </Button>
        </Link>
      </div>
    </div>
  );

  return (
    <div className='text-right'>
      <audio ref={audioRef} src='/notification.mp3' />
      <Dropdown
        open={menuOpen}
        dropdownRender={() => menu}
        trigger={['click']}
        onOpenChange={(visible) => setMenuOpen(visible)}
      >
        <NotificationButton
          size='large'
          count={count}
          onClick={() => setMenuOpen(!menuOpen)}
        />
      </Dropdown>
    </div>
  );
}

// 'use client';
// import {
//   useGetAllNotifications,
//   useGetNotificationCountUnread,
//   useUpdateNotification,
// } from '@/apis';
// import { useSocket } from '@/contexts';
// import { Menu, Transition } from '@headlessui/react';
// import { BellIcon } from '@radix-ui/react-icons';
// import { Badge, Button } from 'antd';
// import Image from 'next/image';
// import Link from 'next/link';
// import { usePathname } from 'next/navigation';
// import { Fragment, useEffect, useRef, useState } from 'react';
// import { motion } from 'framer-motion';

// export function NotificationBar() {
//   const [selectedTab, setSelectedTab] = useState('all');
//   const [menuOpen, setMenuOpen] = useState(false);

//   const { data, refetch } = useGetAllNotifications();
//   const { data: count, refetch: refetchCount } = useGetNotificationCountUnread();
//   const updateNotification = useUpdateNotification();

//   const updateNotificationById = async (id: number) => {
//     await updateNotification.mutateAsync({ id });
//   };

//   const { socket } = useSocket();
//   const audioRef = useRef<HTMLAudioElement>(null);

//   const pathname = usePathname();

//   useEffect(() => {
//     const asyncRefetch = async () => {
//       await refetch();
//       await refetchCount();
//     };
//     asyncRefetch();
//   }, [pathname]);

//   useEffect(() => {
//     if (socket) {
//       socket.on('message', async (message: string) => {
//         await refetch();
//         await refetchCount();
//         if (audioRef.current) {
//           audioRef.current.play();
//         }
//       });

//       return () => {
//         socket.off('message');
//       };
//     }
//   }, [socket]);

//   return (
//     <div className='text-right'>
//       <audio ref={audioRef} src='/notification.mp3' />
//       <Menu as='div' className='relative inline-block text-left'>
//         <div>
//           <Menu.Button className='inline-flex w-full justify-center rounded-full border-2 border-[#036c3c] p-2 text-sm font-medium text-[#036c3c] hover:bg-[#ecfeee] focus:outline-none focus-visible:ring-2 focus-visible:ring-white/75 transition-colors duration-200'>
//             <Badge count={count} size='small'>
//               <BellIcon className='h-5 w-5 text-[#036c3c]' aria-hidden='true' />
//             </Badge>
//           </Menu.Button>
//         </div>
//         <Transition
//           as={Fragment}
//           enter='transition ease-out duration-200'
//           enterFrom='transform opacity-0 scale-95'
//           enterTo='transform opacity-100 scale-100'
//           leave='transition ease-in duration-150'
//           leaveFrom='transform opacity-100 scale-100'
//           leaveTo='transform opacity-0 scale-95'
//         >
//           <Menu.Items className='absolute right-0 mt-2 w-96 origin-top-right divide-y divide-gray-100 rounded-md bg-white shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none'>
//             <div className='px-4 py-3'>
//               <div className='flex space-x-4 mb-4'>
//                 {['all', 'unread', 'read'].map((tab) => (
//                   <button
//                     key={tab}
//                     onClick={() => setSelectedTab(tab)}
//                     className={`${
//                       selectedTab === tab
//                         ? 'text-[#17a34a] border-b-2 border-[#17a34a]'
//                         : 'text-gray-600'
//                     } capitalize font-medium focus:outline-none transition-colors duration-200`}
//                   >
//                     {tab}
//                   </button>
//                 ))}
//               </div>
//               <div className='max-h-80 overflow-y-auto space-y-2'>
//                 {data?.slice(0, 4).map((notification: any) => (
//                   <Fragment key={notification.id}>
//                     {(selectedTab === 'all' ||
//                       (selectedTab === 'unread' && !notification.isRead) ||
//                       (selectedTab === 'read' && notification.isRead)) && (
//                       <motion.div
//                         initial={{ opacity: 0, y: -10 }}
//                         animate={{ opacity: 1, y: 0 }}
//                         transition={{ duration: 0.3 }}
//                         className={`${
//                           !notification.isRead ? 'bg-[#ecfeee]' : 'bg-white'
//                         } flex items-center p-3 rounded-lg cursor-pointer hover:bg-gray-50 transition-colors duration-200`}
//                         onClick={() => updateNotificationById(notification.id)}
//                       >
//                         <Link href={`/${notification.url}`} className='flex items-center w-full'>
//                           <Image
//                             src='/navLogoRoundMain.png'
//                             alt='logo'
//                             height={40}
//                             width={40}
//                             className='rounded-full object-cover mr-4'
//                           />
//                           <div className='flex-1'>
//                             <p className='font-medium text-gray-800'>{notification.message}</p>
//                             <p className='text-sm text-gray-500'>{notification.createdAt}</p>
//                           </div>
//                         </Link>
//                       </motion.div>
//                     )}
//                   </Fragment>
//                 ))}
//               </div>
//             </div>
//             <div className='px-4 py-3'>
//               <Link href='/notifications' className='w-full'>
//                 <Button type='primary' className='w-full bg-[#17a34a] hover:bg-[#15803d] border-none'>
//                   See all notifications
//                 </Button>
//               </Link>
//             </div>
//           </Menu.Items>
//         </Transition>
//       </Menu>
//     </div>
//   );
// }
