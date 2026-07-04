'use client';
import { Disclosure } from '@headlessui/react';
import { Bars3Icon, XMarkIcon } from '@heroicons/react/24/outline';
import Image from 'next/image';
import Link from 'next/link';
import React, { useEffect, useState } from 'react';
import ProfileBar from './ProfileBar';

const NavBar: React.FC = () => {
  const [activeMenu, setActiveMenu] = useState(() => {
    if (typeof window !== 'undefined') {
      return localStorage.getItem('activeMenu') || 'signin';
    }
    return 'signin';
  });

  useEffect(() => {
    localStorage.setItem('activeMenu', activeMenu);
  }, [activeMenu]);

  const navigation = [
    { name: 'SignUp', href: '/signup' },
    { name: 'SignIn', href: '/signin' },
  ];

  const handleMenuClick = (name: string) => {
    setActiveMenu(name);
  };

  return (
    <Disclosure as='nav' className='bg-white shadow'>
      {({ open }: any) => (
        <>
          <div className='mx-auto max-w-7xl px-4 sm:px-6 lg:px-8'>
            <div className='flex h-16 justify-between'>
              <div className='flex'>
                <div className='flex flex-shrink-0 items-center'>
                  <Image
                    src={'/navLogoRoundMain.png'}
                    alt='logo'
                    height={48}
                    width={150}
                  />
                </div>
              </div>
              <div className='hidden sm:ml-6 sm:flex sm:space-x-8'>
                {navigation.map((item) => (
                  <Link
                    key={item.name}
                    href={item.href} // Use href attribute for routing
                    onClick={() => handleMenuClick(item.name)}
                    className={`inline-flex items-center px-1 pt-1 text-sm font-semibold text-gray-500 hover:text-gray-700 ${
                      activeMenu === item.name
                        ? 'border-b-2 border-gray-500'
                        : ''
                    }`}
                  >
                    <span>{item.name}</span>
                  </Link>
                ))}
              </div>

              <div className='-mr-2 flex items-center sm:hidden'>
                {/* Mobile menu button */}
                <Disclosure.Button className='relative inline-flex items-center justify-center rounded-md p-2 text-gray-400 hover:bg-gray-100 hover:text-gray-500 focus:outline-none focus:ring-2 focus:ring-inset focus:ring-indigo-500'>
                  <span className='absolute -inset-0.5' />
                  <span className='sr-only'>Open main menu</span>
                  {open ? (
                    <XMarkIcon className='block h-6 w-6' aria-hidden='true' />
                  ) : (
                    <Bars3Icon className='block h-6 w-6' aria-hidden='true' />
                  )}
                </Disclosure.Button>
              </div>
              <div className='hidden items-center md:flex  '>
                <ProfileBar />
              </div>
            </div>
          </div>

          <Disclosure.Panel className='sm:hidden '>
            <div className='space-y-1 pb-3 pt-2'>
              {navigation.map((item) => (
                <Link
                  key={item.name}
                  href={item.href}
                  onClick={() => handleMenuClick(item.name)}
                  className={`block py-2 pl-3 pr-4 text-base font-medium text-gray-500 hover:text-gray-700 ${
                    activeMenu === item.name ? 'border-l-4 border-gray-500' : ''
                  }`}
                >
                  <span>{item.name}</span>
                </Link>
              ))}
            </div>
          </Disclosure.Panel>
        </>
      )}
    </Disclosure>
  );
};

export default NavBar;
