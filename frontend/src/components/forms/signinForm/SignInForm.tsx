import { SignInFormClient } from './SignInFormClient';
import { SignInFormServer } from './SignInFormServer';

export const SignInForm: React.FC = () => {
  return (
    <SignInFormServer>
      <SignInFormClient />
    </SignInFormServer>
  );
};

// 'use client';
// import Link from 'next/link';
// import React, { useEffect, useState } from 'react';
// import { useForm } from 'react-hook-form';
// import Image from 'next/image';
// import { EyeOpenIcon, EyeClosedIcon } from '@radix-ui/react-icons';
// import { toast } from 'react-toastify';
// import { useRouter, useSearchParams } from 'next/navigation';
// import { getRoles, signin, useIsLoggedInQuery } from '@/apis';
// import { useLoadingContext } from '@/contexts';
// import { Role } from '@/enums';

// export const SignInForm: React.FC = () => {
//   const {
//     register,
//     handleSubmit,
//     formState: { errors },
//   } = useForm();
//   const [showPassword, setShowPassword] = useState(false);

//   const router = useRouter();
//   const { setIsLoadingGlobal } = useLoadingContext();

//   const { data: isloggedin, refetch } = useIsLoggedInQuery();

//   const searchParams = useSearchParams();
//   const redirect = searchParams.get('redirect');

//   const onSubmit = async (data: any) => {
//     try {
//       const ret = await signin(data);
//       const isStudent = ret?.user?.role?.includes(Role.STUDENT);
//       toast.success('Login successful');
//       await refetch();
//       const redirectTo = isStudent
//         ? 'student-details'
//         : redirect
//           ? decodeURIComponent(redirect)
//           : '/dashboard';
//       router.push(redirectTo);
//     } catch (error: any) {
//       if (error.response?.data?.message === 'User not verified') {
//         router.push(`/otp?email=${data.email}&t=new`);
//       }
//       toast.error(error.response?.data?.message ?? 'Something went wrong');
//       console.log(error);
//     }
//   };

//   const getRedirectionUrl = async () => {
//     const role = await getRoles();
//     console.log(role);
//     const isStudent = role?.includes(Role.STUDENT);
//     const redirectTo = isStudent
//       ? 'student-details'
//       : redirect
//         ? decodeURIComponent(redirect)
//         : '/dashboard';
//     console.log(redirectTo);
//     router.push(redirectTo);
//   };

//   useEffect(() => {
//     if (isloggedin) {
//       getRedirectionUrl();
//     }
//   }, [isloggedin, router, redirect]);

//   useEffect(() => {
//     setIsLoadingGlobal(false);
//   }, []);

//   return (
//     <>
//       {isloggedin === false && (
//         <div className='flex min-h-screen flex-1 flex-col justify-center px-6 py-12 lg:px-8'>
//           <div className='rounded-md bg-white px-10 py-6 sm:mx-auto sm:w-full sm:max-w-sm'>
//             <form onSubmit={handleSubmit(onSubmit)} className='space-y-5'>
//               <div className=''>
//                 <div className='mb-3 space-y-2'>
//                   <Image
//                     src='/navLogoWide.png'
//                     alt='logo image'
//                     height={50}
//                     width={200}
//                     className='w-full'
//                   />
//                   <h2 className='text-center text-2xl font-semibold'>
//                     Sign in to your Account
//                   </h2>
//                   <p className='text-center text-sm text-gray-500'>
//                     Use your email to log in to your account
//                   </p>
//                 </div>
//                 <label htmlFor='email' className='text-gray-800'>
//                   Email
//                 </label>
//                 <input
//                   id='email'
//                   type='email'
//                   autoComplete='email'
//                   {...register('email', { required: true })}
//                   className='mt-2 block w-full rounded-md border bg-white px-4 py-2 text-gray-700 focus:border-2 focus:border-[#036c3c] focus:outline-none focus:ring-0'
//                 />
//                 {errors.email && (
//                   <p className='text-red-500'>Email is required</p>
//                 )}
//               </div>
//               <div className='relative'>
//                 <div className='flex justify-between'>
//                   <label htmlFor='password' className='text-gray-800'>
//                     Password
//                   </label>
//                   <Link href='/forgotpassword'>
//                     <span className='text-blue-600 hover:underline'>
//                       Forgot Password?
//                     </span>
//                   </Link>
//                 </div>
//                 <div className='flex items-center'>
//                   <input
//                     id='password'
//                     type={showPassword ? 'text' : 'password'}
//                     autoComplete='new-password'
//                     {...register('password', { required: true, minLength: 6 })}
//                     className='mt-2 block w-full rounded-md border bg-white px-4 py-2 text-gray-700 focus:border-2 focus:border-[#036c3c] focus:outline-none focus:ring-0'
//                   />
//                   <button
//                     type='button'
//                     onClick={() => setShowPassword(!showPassword)}
//                     className='absolute right-3 p-2 focus:outline-none'
//                   >
//                     {showPassword ? <EyeClosedIcon /> : <EyeOpenIcon />}
//                   </button>
//                 </div>
//                 {errors.password?.type === 'required' && (
//                   <p className='text-red-500'>Password is required</p>
//                 )}
//                 {errors.password?.type === 'minLength' && (
//                   <p className='text-red-500'>
//                     Please try something more then 6 character
//                   </p>
//                 )}
//               </div>

//               <div className='flex items-center '>
//                 <input
//                   type='checkbox'
//                   id='rememberMe'
//                   {...register('rememberMe')}
//                   className='mr-2 h-4 w-4  cursor-pointer rounded border border-gray-400 accent-[#036c3c]'
//                 />
//                 <label
//                   htmlFor='rememberMe'
//                   className='font-normal text-gray-800'
//                 >
//                   Remember me
//                 </label>
//               </div>

//               <input
//                 type='submit'
//                 value='Sign In'
//                 className='w-full transform cursor-pointer rounded-md bg-[#036c3c] px-4 py-2 tracking-wide text-white transition-colors duration-200 hover:bg-green-600 focus:bg-gray-600 focus:outline-none'
//               />
//             </form>
//           </div>
//         </div>
//       )}
//     </>
//   );
// };
