import { Menu, Transition } from '@headlessui/react';
import { BellIcon } from '@radix-ui/react-icons';
import Image from 'next/image';
import { Fragment, useState } from 'react';

const notifications = [
  { id: 1, title: 'Notification 1', date: '2024-03-14', unread: true },
  { id: 2, title: 'Notification 2', date: '2024-03-13', unread: false },
  { id: 2, title: 'Notification 2', date: '2024-03-13', unread: false },
  { id: 1, title: 'Notification 1', date: '2024-03-14', unread: true },
  { id: 1, title: 'Notification 1', date: '2024-03-14', unread: true },
  { id: 2, title: 'Notification 7', date: '2024-03-13', unread: false },
];

export default function NotificationBar() {
  const [selectedTab, setSelectedTab] = useState('all');
  const [menuOpen, setMenuOpen] = useState(false);

  return (
    <div className='  text-right'>
      <Menu
        as='div'
        className='relative inline-block text-left'
        onMouseEnter={() => setMenuOpen(true)}
        onMouseLeave={() => setMenuOpen(false)}
      >
        <div>
          <Menu.Button className='inline-flex w-full justify-center rounded-md border-2 px-4 py-2 text-sm font-medium text-[#036c3c] hover:bg-gray-200 focus:outline-none focus-visible:ring-2 focus-visible:ring-white/75'>
            <BellIcon className=' h-5 w-5 text-[#036c3c]' aria-hidden='true' />
          </Menu.Button>
        </div>
        <Transition
          show={menuOpen}
          as={Fragment}
          enter='transition ease-out duration-100'
          enterFrom='transform opacity-0 scale-95'
          enterTo='transform opacity-100 scale-100'
          leave='transition ease-in duration-75'
          leaveFrom='transform opacity-100 scale-100'
          leaveTo='transform opacity-0 scale-95'
        >
          <Menu.Items className='max-h-100 absolute right-0 mt-2 w-80 origin-top-right divide-y divide-gray-100 overflow-y-auto rounded-md bg-white px-5 py-3 shadow-lg ring-1 ring-green-50 focus:outline-none'>
            <div className='flex'>
              <Menu.Item>
                {() => (
                  <button
                    onClick={() => setSelectedTab('all')}
                    className={`${
                      selectedTab === 'all' ? 'border-b-2 border-[#17a34a]' : ''
                    } group flex w-full items-center px-2 py-2 text-sm`}
                  >
                    All
                  </button>
                )}
              </Menu.Item>
              <Menu.Item>
                {() => (
                  <button
                    onClick={() => setSelectedTab('unread')}
                    className={`${
                      selectedTab === 'unread'
                        ? 'border-b-2 border-[#17a34a]'
                        : ''
                    } group flex w-full items-center px-2 py-2 text-sm`}
                  >
                    Unread
                  </button>
                )}
              </Menu.Item>
              <Menu.Item>
                {() => (
                  <button
                    onClick={() => setSelectedTab('read')}
                    className={`${
                      selectedTab === 'read'
                        ? 'border-b-2 border-[#17a34a]'
                        : ''
                    } group flex w-full items-center px-2 py-2 text-sm`}
                  >
                    Read
                  </button>
                )}
              </Menu.Item>
            </div>
            {notifications.slice(0, 4).map((notification) => (
              <Fragment key={notification.id}>
                {(selectedTab === 'all' ||
                  (selectedTab === 'unread' && notification.unread) ||
                  (selectedTab === 'read' && !notification.unread)) && (
                  <div
                    className={`${
                      notification.unread ? 'bg-ecfeee' : 'bg-white'
                    } flex items-center justify-between rounded-md bg-green-50  py-2`}
                  >
                    <div className='flex items-center '>
                      {/* Add avatar if available */}
                      <div className='flex items-center '>
                        <Image
                          src='/navLogoRoundMain.png'
                          alt='logo image'
                          height={35}
                          width={130}
                          className='mr-6 h-10 w-10 rounded-full bg-gray-300 object-cover'
                        />
                        <div>
                          <p className='font-semibold'>{notification.title}</p>
                          <p className='text-sm text-gray-500'>
                            {notification.date}
                          </p>
                        </div>
                      </div>
                    </div>
                  </div>
                )}
              </Fragment>
            ))}
          </Menu.Items>
        </Transition>
      </Menu>
    </div>
  );
}
