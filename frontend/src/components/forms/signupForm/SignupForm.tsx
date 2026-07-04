'use client';
import Link from 'next/link';
import React, { useState } from 'react';
import { useForm } from 'react-hook-form';
import { EyeOpenIcon, EyeClosedIcon } from '@radix-ui/react-icons';
import Image from 'next/image';
import { toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import { useRouter } from 'next/navigation';
import GoogleIcons from '@/components/svg/google';
import { signup } from '@/apis';

export const SignupForm: React.FC = () => {
  const {
    register,
    handleSubmit,
    formState: { errors },
    watch,
  } = useForm();
  const [showPassword, setShowPassword] = useState(false);
  const router = useRouter();
  const onSubmit = async (data: any) => {
    delete data.confirmPassword;
    try {
      const res = await signup(data);
      if (res) {
        toast.success(`An email sent ${data.email}`);
        router.push(`/otp?email=${data.email}&t=new`);
      } else {
        toast.error('Sign up failed1. Please try again.');
      }
    } catch (error: any) {
      console.log(error);
      toast.error(error.response?.data?.message ?? 'Something went wrong');
    }
  };

  // Watch the value of confirmPassword field
  const confirmPassword = watch('password');

  return (
    <>
      <div className='flex min-h-full flex-1 flex-col justify-center px-6 py-12 lg:px-8'>
        <div className='rounded-md bg-white px-10 py-6 sm:mx-auto sm:w-full sm:max-w-sm'>
          <div className='mb-3 space-y-2'>
            <Image
              src='/navLogoRoundMain.png'
              alt='logo image'
              height={35}
              width={130}
            />
            <h2 className='text-center text-2xl font-semibold'>
              Sign up for an Account
            </h2>
            <p className='text-sm'>
              Create your account by filling out the information below
            </p>
          </div>
          <form onSubmit={handleSubmit(onSubmit)} className='space-y-9'>
            <div className='max-w-lg'>
              <label htmlFor='name' className='text-gray-800'>
                Name
              </label>
              <input
                id='name'
                type='text'
                autoComplete='name'
                {...register('name', { required: true })}
                className='mt-2 block w-full rounded-md border bg-white px-4 py-2 text-gray-700 focus:border-2 focus:border-[#036c3c] focus:outline-none focus:ring-0'
              />
              {errors.name && <p className='text-red-500'>Name is required</p>}

              <label htmlFor='email' className='mt-4 text-gray-800'>
                Email
              </label>
              <input
                id='email'
                type='email'
                autoComplete='email'
                {...register('email', { required: true })}
                className='mt-2 block w-full rounded-md border bg-white px-4 py-2 text-gray-700 focus:border-2 focus:border-[#036c3c] focus:outline-none focus:ring-0'
              />
              {errors.email && (
                <p className='text-red-500'>Email is required</p>
              )}

              <div className='relative'>
                <label htmlFor='password' className='mt-4 text-gray-800'>
                  Password
                </label>
                <div className='flex items-center'>
                  <input
                    id='password'
                    type={showPassword ? 'text' : 'password'}
                    autoComplete='new-password'
                    {...register('password', { required: true, minLength: 6 })}
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
                {errors.password?.type === 'required' && (
                  <p className='text-red-500'>Password is required</p>
                )}
                {errors.password?.type === 'minLength' && (
                  <p className='text-red-500'>
                    Please try something more then 6 character
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

              <input
                type='submit'
                className='mt-4 w-full transform cursor-pointer rounded-md bg-[#036c3c] px-4 py-2 text-white  transition-colors duration-200 hover:bg-green-600 focus:bg-gray-600 focus:outline-none'
                value='Sign Up'
              />
            </div>
          </form>
          <div className='relative mt-6 flex w-full items-center justify-center rounded-md border border-t'>
            <Link
              href='/signin'
              className='flex items-center gap-x-2  py-2 text-[14px] text-gray-500'
            >
              <GoogleIcons />
              Continue with Google
            </Link>
          </div>
          <p className='mt-4 text-center text-sm text-gray-700'>
            Already have an account?{' '}
            <Link
              href='/signin'
              className='font-medium text-blue-600 hover:underline'
            >
              SignIn
            </Link>
          </p>
        </div>
      </div>
    </>
  );
};
