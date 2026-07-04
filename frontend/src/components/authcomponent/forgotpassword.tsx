'use client';
import Link from 'next/link';
import React from 'react';
import { useForm } from 'react-hook-form';
import { KeyIcon } from '@heroicons/react/24/outline';
import { ArrowLeftIcon } from '@radix-ui/react-icons';
import { forgetPassword } from '@/apis';
import { toast } from 'react-toastify';
import { useRouter } from 'next/navigation';

export const ForgotPasswordForm: React.FC<object> = () => {
  const {
    register,
    handleSubmit,
    formState: { errors, isSubmitting },
  } = useForm<{ email: string }>();

  const router = useRouter();

  const onSubmit = async (data: { email: string }) => {
    try {
      const res = await forgetPassword(data.email);
      toast.success(res.message);
      router.push(`/otp?email=${data.email}`);
    } catch (error: any) {
      toast.error(error.response?.data?.message ?? 'Something went wrong');
      console.log('Error:', error.response?.data?.message);
    }
  };

  return (
    <div className='space-y-6 bg-white px-4 py-8 shadow sm:rounded-lg sm:px-10'>
      <form onSubmit={handleSubmit(onSubmit)} className='space-y-5'>
        <div className='mb-3 flex flex-col items-center space-y-4'>
          <div className='rounded-full bg-green-50 p-3'>
            <div className='rotate-180 rounded-full bg-green-100 p-3'>
              <KeyIcon className='h-8 w-8 ' />
            </div>
          </div>
          <h2 className='text-2xl font-semibold'>Forgot Password</h2>
          <p className='text-[12px]'>
            Please enter your email address to reset your password
          </p>
        </div>
        <div>
          <label htmlFor='email' className='mt-4 text-gray-800'>
            Email
          </label>
          <div className='flex space-x-2'>
            <input
              id='email'
              type='email'
              autoComplete='email'
              {...register('email', { required: true })}
              className='mt-2 block w-full rounded-md border bg-white px-4 py-2 text-gray-700 focus:border-2 focus:border-[#036c3c] focus:outline-none focus:ring-0'
            />
          </div>

          {errors.email && (
            <p className='text-red-500'>Please enter your email</p>
          )}
        </div>
        <input
          type='submit'
          disabled={isSubmitting}
          value='Reset Password'
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
  );
};
