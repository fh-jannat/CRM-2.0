import React from 'react';

interface AppLoaderProps {
  className?: string;
  logoUrl?: string;
  text?: string;
  size?: number;
  color?: string;
}

const AppLoader: React.FC<AppLoaderProps> = ({
  className = '',
  logoUrl = '/navLogoRoundMain.png',
  text,
  size = 40,
  color = '#3B82F6', // Default to blue-500
}) => {
  return (
    <div className={`flex flex-col items-center justify-center ${className}`}>
      <div className='relative' style={{ width: size, height: size }}>
        {/* Spinning border */}
        <div
          className='absolute inset-0 animate-spin rounded-full'
          style={{
            borderWidth: '2px',
            borderStyle: 'solid',
            borderColor: `${color} ${color} transparent transparent`,
          }}
        ></div>

        {/* Logo */}
        {logoUrl && (
          <img
            src={logoUrl || '/navLogoRoundMain.png'}
            alt='Loading'
            className='absolute inset-0 m-auto'
            style={{ width: size * 0.6, height: size * 0.6 }}
          />
        )}
      </div>

      {/* Optional text */}
      {text && <p className='mt-2 text-sm text-gray-600'>{text}</p>}
    </div>
  );
};

export default AppLoader;
