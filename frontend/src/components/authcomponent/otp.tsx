'use client';
import { forgotPasswordOtp } from '@/apis';
import { EnvelopeClosedIcon } from '@radix-ui/react-icons';
import Link from 'next/link';
import { useRouter } from 'next/navigation';
import React from 'react';
import { useForm } from 'react-hook-form';
import { toast } from 'react-toastify';

const OTP_SIZE = 6;

interface FormData {
  [key: string]: string;
}

interface Props {
  email: string;
  isVerifyOnly: boolean;
}

export const OTPForm: React.FC<Props> = ({ email, isVerifyOnly }) => {
  const {
    register,
    handleSubmit,
    formState: { errors },
  } = useForm<FormData>();
  // const firstInputRef = useRef<HTMLInputElement>(null);
  const router = useRouter();

  const onSubmit = async (data: any) => {
    try {
      const otpString = Object.values(data).join('');
      const ret = await forgotPasswordOtp(email, otpString, isVerifyOnly);
      toast.success(ret?.message ?? 'OTP submitted successfully');
      if (isVerifyOnly) {
        router.push(`/signin`);
      } else {
        localStorage.setItem('userotp', otpString);
        router.push(`/setpassword?email=${email}`);
      }
    } catch (error: any) {
      toast.error(error.response?.data?.message ?? 'Something went wrong');
      console.log('Error:', error);
    }
  };

  const handleInputChange = (
    e: React.ChangeEvent<HTMLInputElement>,
    index: number
  ) => {
    const inputLength = e.target.value.length;
    const nextIndex = (index % OTP_SIZE) + 1;
    if (inputLength === 1 && nextIndex !== 1) {
      setTimeout(() => {
        const nextInput = document.getElementById(
          `otp${nextIndex}`
        ) as HTMLInputElement;
        if (nextInput) {
          nextInput.focus();
        }
      }, 0);
    }
  };

  const handlePaste = (e: React.ClipboardEvent<HTMLInputElement>) => {
    e.preventDefault();
    const pastedData = e.clipboardData
      .getData('text')
      .trim()
      .substring(0, OTP_SIZE);
    const otpDigits = pastedData.split('');
    otpDigits.forEach((digit, index) => {
      const currentInput = document.getElementById(
        `otp${index + 1}`
      ) as HTMLInputElement;
      if (currentInput) {
        currentInput.value = digit;
        currentInput.focus();
        currentInput.dispatchEvent(new Event('input', { bubbles: true }));
      }
    });
  };

  const isAllOTPFilled = () => {
    for (let i = 1; i <= OTP_SIZE; i++) {
      if (errors[`otp${i}`]) {
        return true;
      }
    }
    return false;
  };

  return (
    <div className='flex min-h-full flex-1 flex-col justify-center px-6 py-12 lg:px-8'>
      <div className='rounded-md bg-white px-10 py-6 sm:mx-auto sm:w-full sm:max-w-sm'>
        <form onSubmit={handleSubmit(onSubmit)} className='space-y-5'>
          <div className='max-w-md'>
            <div className='mb-3 flex flex-col items-center space-y-4'>
              <div className='rounded-full bg-green-50 p-3'>
                <div className='rounded-full bg-green-100 p-3'>
                  <EnvelopeClosedIcon className='h-8 w-8 ' />
                </div>
              </div>
              <h2 className='text-2xl font-semibold'>Check your email</h2>
              <p className='text-[12px]'>
                We have sent a verification code to {email}
              </p>
            </div>
            <div className='flex space-x-2'>
              {[...Array(OTP_SIZE)].map((_, index: number) => (
                <input
                  key={index}
                  id={`otp${index + 1}`}
                  type='text'
                  maxLength={1}
                  {...register(`otp${index + 1}`, {
                    required: true,
                    maxLength: 1,
                    minLength: 1,
                  })}
                  className='mt-2 flex w-1/4 items-center justify-center rounded-md border bg-white px-2 py-2 text-center text-3xl font-semibold text-[#036c3c]  focus:border-2 focus:border-[#036c3c] focus:outline-none focus:ring-0'
                  onChange={(e) => handleInputChange(e, index + 1)}
                  // ref={index === 0 ? firstInputRef : undefined}
                  onPaste={handlePaste}
                />
              ))}
            </div>

            {isAllOTPFilled() && (
              <p className='text-red-500'>
                Please enter all {OTP_SIZE} OTP digits
              </p>
            )}
          </div>
          <input
            type='submit'
            value='Submit'
            className='my-6 w-full transform cursor-pointer rounded-md bg-[#036c3c] px-4 py-3 tracking-wide text-white transition-colors duration-200 hover:bg-green-600 focus:bg-gray-600 focus:outline-none'
          />
        </form>

        <div className='relative my-6 flex w-full items-center justify-center border border-t'>
          <div className='absolute bg-gray-100 px-5 text-black'>Or</div>
        </div>

        <p className='mt-4 text-center text-sm text-gray-700'>
          {'Create an account '}
          <Link
            href='/signup'
            className='font-medium text-blue-600 hover:underline'
          >
            Signup
          </Link>
        </p>
      </div>
    </div>
  );
};
