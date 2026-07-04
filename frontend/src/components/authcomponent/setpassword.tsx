'use client';
import { forgotPasswordOtpNewPassword } from '@/apis';
import { KeyIcon } from '@heroicons/react/24/outline';
import {
  ArrowLeftIcon,
  EyeClosedIcon,
  EyeOpenIcon,
} from '@radix-ui/react-icons';
import Link from 'next/link';
import { useRouter } from 'next/navigation';
import React, { useEffect, useState } from 'react';
import { useForm } from 'react-hook-form';
import { toast } from 'react-toastify';

interface FormData {
  password: string;
  confirmPassword: string;
}

// props interface
interface Props {
  email: string;
}

export const SetPasswordForm: React.FC<Props> = ({ email }) => {
  const {
    register,
    handleSubmit,
    formState: { errors },
    watch,
  } = useForm<FormData>();

  const router = useRouter();

  const [showPassword, setShowPassword] = useState(false);
  const [otp, setOtp] = useState<string | null>(null);

  useEffect(() => {
    if (typeof window !== 'undefined') {
      const localotp = window.localStorage.getItem('userotp') ?? '394413';
      setOtp(localotp);
    }
  }, []);

  const onSubmit = async (data: FormData) => {
    if (!otp) {
      toast.error('OTP not found');
      return;
    }
    try {
      const ret = await forgotPasswordOtpNewPassword(email, otp, data.password);
      toast.success(ret?.message ?? 'Password updated successfuly');
      router.push(`/success`);
      localStorage.removeItem('userotp');
    } catch (error: any) {
      localStorage.removeItem('userotp');
      toast.error(error.response?.data?.message ?? 'Something went wrong');
      console.log('Error:', error);
    }
  };

  const confirmPassword = watch('password');

  return (
    <div className='flex min-h-full flex-1 flex-col justify-center px-6 py-12 lg:px-8'>
      <div className='rounded-md bg-white px-10 py-6 sm:mx-auto sm:w-full sm:max-w-sm'>
        {' '}
        <form onSubmit={handleSubmit(onSubmit)} className='space-y-5'>
          <div className='max-w-md'>
            <div className='mb-3 flex flex-col items-center space-y-4'>
              <div className='rounded-full bg-green-50 p-3'>
                <div className='rotate-180 rounded-full bg-green-100 p-3'>
                  <KeyIcon className='h-8 w-8 ' />
                </div>
              </div>
              <h2 className='text-2xl font-semibold'>Set New Password</h2>
              <p className='px-2 text-center text-[14px] text-gray-500'>
                {`  Your new password must be different to previously used passwords.`}
              </p>
            </div>
            <div className='relative'>
              <label htmlFor='password' className='mt-4 text-gray-800'>
                Password
              </label>
              <div className='flex items-center'>
                <input
                  id='password'
                  type={showPassword ? 'text' : 'password'}
                  autoComplete='new-password'
                  {...register('password', { required: true })}
                  className='mt-2 block w-full rounded-md border bg-white px-4 py-2 text-gray-700 focus:border-2 focus:border-[#036c3c] focus:outline-none focus:ring-0'
                />
                <button
                  type='button'
                  onClick={() => setShowPassword(!showPassword)}
                  className='absolute inset-y-0 right-0 top-8 flex items-center px-2 focus:outline-none'
                >
                  {showPassword ? <EyeClosedIcon /> : <EyeOpenIcon />}
                </button>
              </div>
              {errors.password && (
                <p className='text-red-500'>
                  Password must be at least 6 characters
                </p>
              )}
            </div>

            <div className='relative'>
              <label htmlFor='confirmPassword' className='mt-4 text-gray-800'>
                Confirm Password
              </label>
              <input
                id='confirmPassword'
                type={showPassword ? 'text' : 'password'}
                autoComplete='new-password'
                {...register('confirmPassword', {
                  required: true,
                  validate: (value) =>
                    value === confirmPassword || 'The passwords do not match',
                })}
                className='mt-2 block w-full rounded-md border bg-white px-4 py-2 text-gray-700 focus:border-2 focus:border-[#036c3c] focus:outline-none focus:ring-0'
              />
              <button
                type='button'
                onClick={() => setShowPassword(!showPassword)}
                className='absolute inset-y-0 right-0 top-8 flex items-center px-2 focus:outline-none'
              >
                {showPassword ? <EyeClosedIcon /> : <EyeOpenIcon />}
              </button>
              {errors.confirmPassword && (
                <p className='text-red-500'>Passwords do not match</p>
              )}
            </div>
          </div>
          <input
            type='submit'
            value='Set Password'
            className='my-6 w-full transform cursor-pointer rounded-md bg-[#036c3c] px-4 py-3 tracking-wide text-white transition-colors duration-200 hover:bg-green-600 focus:bg-gray-600 focus:outline-none'
          />
        </form>
        <p className='mt-4 text-center text-sm text-gray-700'>
          <Link
            href='/signin'
            className='flex items-center justify-center font-medium text-gray-500 hover:text-gray-700 hover:underline'
          >
            <ArrowLeftIcon className='mr-1 mt-1 h-4 w-4' /> Back to sign in
          </Link>
        </p>
      </div>
    </div>
  );
};
