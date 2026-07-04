/** @type {import('next').NextConfig} */
const nextConfig = {
  output: 'standalone',
  async rewrites() {
    return [
      {
        source: '/',
        destination: '/dashboard',
      },
    ];
  },
};

export default nextConfig;
