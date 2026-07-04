'use client';
import React, { useState } from 'react';

const Page: React.FC = () => {
  const [appId, setAppId] = useState('');
  const [appSecret, setAppSecret] = useState('');
  const [pageId, setPageId] = useState('');
  const [pageAccessToken, setPageAccessToken] = useState('');

  const handleAppIdChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setAppId(e.target.value);
  };

  const handleAppSecretChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setAppSecret(e.target.value);
  };

  const handlePageIdChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setPageId(e.target.value);
  };

  const handlePageAccessTokenChange = (
    e: React.ChangeEvent<HTMLInputElement>
  ) => {
    setPageAccessToken(e.target.value);
  };

  return (
    <div className='mx-auto flex w-full justify-between'>
      <div className='flex w-1/2 flex-col justify-between'>
        <input
          type='text'
          id='appId'
          value={appId}
          onChange={handleAppIdChange}
          className='mb-4 rounded border border-gray-300 px-4 py-2 placeholder-gray-500 focus:border-blue-500 focus:outline-none'
          placeholder='Enter APP ID'
        />
        <input
          type='text'
          id='appSecret'
          value={appSecret}
          onChange={handleAppSecretChange}
          className='mb-4 rounded border border-gray-300 px-4 py-2 placeholder-gray-500 focus:border-blue-500 focus:outline-none'
          placeholder='Enter APP Secret'
        />
        <input
          type='text'
          id='pageId'
          value={pageId}
          onChange={handlePageIdChange}
          className='mb-4 rounded border border-gray-300 px-4 py-2 placeholder-gray-500 focus:border-blue-500 focus:outline-none'
          placeholder='Enter Page ID'
        />
      </div>
      <div className='flex w-1/2 justify-end'>
        <input
          type='text-area'
          id='pageAccessToken'
          value={pageAccessToken}
          onChange={handlePageAccessTokenChange}
          className='h-38 w-[750px] rounded border border-gray-300 px-4 py-2 placeholder-gray-500 focus:border-blue-500 focus:outline-none'
          placeholder='Enter PAGE Access Token'
        />
      </div>
    </div>
  );
};

export default Page;
