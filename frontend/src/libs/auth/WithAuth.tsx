'use client';
import { LOGIN_PATH } from '@/constants';
import { useIsLoggedInQuery } from '@/apis';
import { useRouter } from 'next/navigation';
import { JSX } from 'react';

export function withAuth<P>(Component: React.ComponentType<P>) {
  return function WithAuth(props: JSX.IntrinsicAttributes & P) {
    const router = useRouter();
    const {
      isPending,
      error,
      data: isloggedin,
      isFetching,
    } = useIsLoggedInQuery();
    if (isPending || isFetching) return null;
    if (error) router.push(LOGIN_PATH);
    if (!isloggedin) router.push(LOGIN_PATH);

    return <>{isloggedin && <Component {...props} />}</>;
  };
}
