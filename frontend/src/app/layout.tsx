import { Providers } from '@/providers';
import { Metadata } from 'next';
import { Lato } from 'next/font/google';
import './globals.css';
import { Suspense } from 'react';

const lato = Lato({
  subsets: ['latin'],
  weight: ['100', '300', '400', '700', '900'],
});

export const metadata: Metadata = {
  title: {
    template: '%s | CRM',
    default: 'CRM',
  },
  description: 'CRM',
  metadataBase: new URL(
    process.env.NEXT_PUBLIC_APP_URL ?? 'https://saascrm.factoryze.tech'
  ),
  alternates: {
    canonical: './',
  },
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang='en'>
      <head>
        <link rel='manifest' href='/manifest.json' />
        <link
          rel='apple-touch-icon'
          sizes='192x192'
          href='/icons/apple-touch-icon.png'
        />
        <meta name='theme-color' content='#ffffff' />
        <link rel='icon' href='/favicon.ico' />
        <link
          rel='icon'
          type='image/png'
          sizes='32x32'
          href='/favicon-32x32.png'
        />
        <link
          rel='icon'
          type='image/png'
          sizes='16x16'
          href='/favicon-16x16.png'
        />
      </head>
      <body className={lato.className}>
        <Providers>
          <Suspense>
            <main className='w-full'>{children}</main>
          </Suspense>
        </Providers>
      </body>
    </html>
  );
}
