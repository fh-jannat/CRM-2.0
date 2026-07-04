'use client';
import { signin, useGetRolesQuery, useIsLoggedInQuery } from '@/apis';
import { HOME_PATH } from '@/constants';
import { Role } from '@/enums';
import { Button, Checkbox, Form, Input } from 'antd';
import Link from 'next/link';
import { useRouter, useSearchParams } from 'next/navigation';
import { useEffect } from 'react';
import { toast } from 'react-toastify';

export const SignInFormClient = () => {
  const [form] = Form.useForm();
  const router = useRouter();
  const searchParams = useSearchParams();
  const redirect = searchParams.get('redirect');
  const { data: isloggedin, refetch } = useIsLoggedInQuery();
  const { refetch: refetchRole } = useGetRolesQuery();

  useEffect(() => {
    if (isloggedin) {
      const redirectTo = redirect ? decodeURIComponent(redirect) : HOME_PATH;
      router.push(redirectTo);
    }
  }, [isloggedin, router, redirect]);

  const onSubmit = async (data: any) => {
    try {
      const ret = await signin(data);
      toast.success('Login successful');
      await refetch();
      await refetchRole();
      const isStudent = ret?.user.role?.includes(Role.STUDENT);
      const redirectTo = isStudent
        ? 'student-details'
        : redirect
          ? decodeURIComponent(redirect)
          : '/dashboard';
      router.push(redirectTo);
    } catch (error: any) {
      if (error.response?.data?.message === 'User not verified') {
        router.push(`/otp?email=${data.email}&t=new`);
      }
      toast.error(error.response?.data?.message ?? 'Something went wrong');
      console.log(error);
    }
  };

  return (
    <Form
      form={form}
      name='basic'
      initialValues={{ remember: true }}
      layout='vertical'
      onFinish={onSubmit}
    >
      <Form.Item
        name='email'
        label='Email'
        rules={[{ required: true, message: 'Please input your email!' }]}
      >
        <Input size='large' placeholder='Email or Phone Number' />
      </Form.Item>

      <Form.Item
        label={
          <div className='flex w-full min-w-[340px] flex-row justify-between gap-4 md:min-w-[370px]'>
            <div>
              <span>Password</span>
            </div>
            <div>
              <Link href='./forgotpassword' className='text-sm text-blue-600'>
                Forgot Password?
              </Link>
            </div>
          </div>
        }
        name='password'
        rules={[{ required: true, message: 'Please input your password!' }]}
      >
        <Input.Password size='large' placeholder='Password' />
      </Form.Item>

      <Form.Item
        style={{ marginTop: '-20px', marginLeft: '5px' }}
        name='remember'
        valuePropName='checked'
      >
        <Checkbox>Remember me</Checkbox>
      </Form.Item>

      <Form.Item noStyle>
        <Button
          className='bg-[#F68E1D]'
          size='large'
          type='primary'
          htmlType='submit'
          block
        >
          Log In
        </Button>
      </Form.Item>
    </Form>
  );
};

// "use client"
// import React, { useEffect, useState } from 'react';
// import { signin, useIsLoggedInQuery } from '@/apis';
// import { HOME_PATH } from '@/constants';
// import { handleErrorToast } from '@/utils';
// import Link from 'next/link';
// import { useRouter, useSearchParams } from 'next/navigation';
// import { toast } from 'react-toastify';

// export const SignInFormClient = () => {
//   const [form, setForm] = useState({ email: '', password: '', remember: true });
//   const router = useRouter();
//   const searchParams = useSearchParams();
//   const redirect = searchParams.get('redirect');
//   const { data: isloggedin } = useIsLoggedInQuery();

//   useEffect(() => {
//     if (isloggedin) {
//       const redirectTo = redirect ? decodeURIComponent(redirect) : HOME_PATH;
//       router.push(redirectTo);
//     }
//   }, [isloggedin, router, redirect]);

//   const handleInputChange = (e:any) => {
//     const { name, value, type, checked } = e.target;
//     setForm(prevForm => ({
//       ...prevForm,
//       [name]: type === 'checkbox' ? checked : value
//     }));
//   };

//   const onFinish = async (e:any) => {
//     e.preventDefault();
//     try {
//       await signin(form);
//       toast.success('Login successful');
//       const redirectTo = redirect ? decodeURIComponent(redirect) : HOME_PATH;
//       router.push(redirectTo);
//     } catch (error:any) {
//       if (error?.response?.data?.message === 'User not verified') {
//         router.push(
//           `/otp?email=${form.email}&t=new&redirect=${encodeURIComponent(redirect || HOME_PATH)}`
//         );
//       }
//       handleErrorToast(error);
//     }
//   };

//   return (
//     <form onSubmit={onFinish} className="space-y-4">
//       <div>
//         <label htmlFor="email" className="block text-sm font-medium text-gray-700">Email</label>
//         <input
//           type="email"
//           id="email"
//           name="email"
//           value={form.email}
//           onChange={handleInputChange}
//           required
//           className="mt-1 block w-full px-3 py-2 bg-white border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"
//           placeholder="Email or Phone Number"
//         />
//       </div>

//       <div>
//         <div className="flex justify-between items-center">
//           <label htmlFor="password" className="block text-sm font-medium text-gray-700">Password</label>
//           <Link href="./forgotpassword" className="text-sm text-blue-600">Forgot Password?</Link>
//         </div>
//         <input
//           type="password"
//           id="password"
//           name="password"
//           value={form.password}
//           onChange={handleInputChange}
//           required
//           className="mt-1 block w-full px-3 py-2 bg-white border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"
//           placeholder="Password"
//         />
//       </div>

//       <div className="flex items-center">
//         <input
//           type="checkbox"
//           id="remember"
//           name="remember"
//           checked={form.remember}
//           onChange={handleInputChange}
//           className="h-4 w-4 text-indigo-600 focus:ring-indigo-500 border-gray-300 rounded"
//         />
//         <label htmlFor="remember" className="ml-2 block text-sm text-gray-900">Remember me</label>
//       </div>

//       <button
//         type="submit"
//         className="w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-[#F68E1D] hover:bg-[#E67D0C] focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-[#F68E1D]"
//       >
//         Log In
//       </button>
//     </form>
//   );
// };

// export default SignInFormClient;
