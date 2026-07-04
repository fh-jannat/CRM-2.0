import { useState } from 'react';
import { FaCopy } from 'react-icons/fa';

interface CopyButtonProps {
  value: string;
}

export const CopyButton: React.FC<CopyButtonProps> = ({ value }) => {
  const [isCopied, setIsCopied] = useState(false);

  const handleCopy = () => {
    navigator.clipboard.writeText(value.toString());
    setIsCopied(true);
    setTimeout(() => {
      setIsCopied(false);
    }, 1000);
  };

  return (
    <button
      className='group flex items-center text-gray-500 hover:text-gray-700 active:ml-1 active:scale-105'
      onClick={handleCopy}
    >
      <FaCopy />
      <span
        className={`ml-1 text-xs text-green-500 transition-opacity duration-1000 ease-out ${
          isCopied ? 'opacity-100' : 'opacity-0'
        }`}
      >
        Copied
      </span>
    </button>
  );
};
