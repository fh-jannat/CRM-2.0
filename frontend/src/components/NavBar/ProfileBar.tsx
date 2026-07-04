import { Menu, Transition } from '@headlessui/react';
import { ChevronDownIcon } from '@heroicons/react/20/solid';
import { Pencil2Icon, CopyIcon } from '@radix-ui/react-icons';
import { Fragment } from 'react';
import NotificationBar from './NotificationBar';

export default function Example() {
  return (
    <div className=' flex  w-56 space-x-2 text-right'>
      <NotificationBar />
      <Menu as='div' className='relative inline-block text-left'>
        <div>
          <Menu.Button className='inline-flex w-full justify-center rounded-md border-2 border-[#036c3c] px-4 py-2 text-sm font-medium text-[#036c3c] hover:bg-gray-200 focus:outline-none focus-visible:ring-2 focus-visible:ring-white/75'>
            Karim
            <ChevronDownIcon
              className='-mr-1 ml-2 h-5 w-5 text-[#036c3c] hover:text-violet-100'
              aria-hidden='true'
            />
          </Menu.Button>
        </div>
        <Transition
          as={Fragment}
          enter='transition ease-out duration-100'
          enterFrom='transform opacity-0 scale-95'
          enterTo='transform opacity-100 scale-100'
          leave='transition ease-in duration-75'
          leaveFrom='transform opacity-100 scale-100'
          leaveTo='transform opacity-0 scale-95'
        >
          <Menu.Items className='absolute right-0 mt-2 w-56 origin-top-right divide-y divide-gray-100 rounded-md bg-white shadow-lg ring-1 ring-black/5 focus:outline-none'>
            <div className='px-1 py-1 '>
              <Menu.Item>
                {({ active }: any) => (
                  <button
                    className={`${
                      active ? 'bg-violet-500 text-white' : 'text-gray-900'
                    } group flex w-full items-center rounded-md px-2 py-2 text-sm`}
                  >
                    {active ? (
                      <Pencil2Icon
                        className='mr-2 h-5 w-5'
                        aria-hidden='true'
                      />
                    ) : (
                      <Pencil2Icon
                        className='mr-2 h-5 w-5'
                        aria-hidden='true'
                      />
                    )}
                    Edit
                  </button>
                )}
              </Menu.Item>
              <Menu.Item>
                {({ active }: any) => (
                  <button
                    className={`${
                      active ? 'bg-violet-500 text-white' : 'text-gray-900'
                    } group flex w-full items-center rounded-md px-2 py-2 text-sm`}
                  >
                    {active ? (
                      <CopyIcon className='mr-2 h-5 w-5' aria-hidden='true' />
                    ) : (
                      <CopyIcon className='mr-2 h-5 w-5' aria-hidden='true' />
                    )}
                    Duplicate
                  </button>
                )}
              </Menu.Item>
            </div>
          </Menu.Items>
        </Transition>
      </Menu>
    </div>
  );
}
