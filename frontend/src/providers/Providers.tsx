'use client';
import React from 'react';
import { AntdRegistry } from '@ant-design/nextjs-registry';
import { ConfigProvider } from 'antd';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { ReactQueryDevtools } from '@tanstack/react-query-devtools';
import AdminLayoutProvider from '@/contexts/AdminLayoutContext';
import { ToastContainer } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import { LeadContextProvider } from '@/contexts/AddNewLeadContext';
import { IsMobileProvider, LoadingProvider, SocketProvider } from '@/contexts';
import { GlobalLoadingContainer } from '@/components/common/loading/GlobalLoading';
import { antdTheme } from '@/constants';

export const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      refetchOnWindowFocus: false,
    },
  },
});

export function Providers({ children }: { children: React.ReactNode }) {
  return (
    <QueryClientProvider client={queryClient}>
      <IsMobileProvider>
        <SocketProvider>
          <LoadingProvider>
            <ToastContainer />
            <LeadContextProvider>
              <AdminLayoutProvider>
                <AntdRegistry>
                  <ConfigProvider theme={antdTheme}>{children}</ConfigProvider>
                </AntdRegistry>
              </AdminLayoutProvider>
            </LeadContextProvider>
            <ReactQueryDevtools initialIsOpen />
            <GlobalLoadingContainer />
          </LoadingProvider>
        </SocketProvider>
      </IsMobileProvider>
    </QueryClientProvider>
  );
}
