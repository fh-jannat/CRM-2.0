import React from 'react';
import { motion } from 'framer-motion';

type InfoCardProps = {
  children: React.ReactNode;
  heading: string;
  icon?: React.ReactNode;
  className?: string;
};

const InfoCard: React.FC<InfoCardProps> = ({
  children,
  heading,
  icon,
  className = '',
}) => {
  return (
    <motion.div
      className={`flex w-full flex-col gap-[14px] overflow-hidden rounded-lg bg-white shadow-md ${className}`}
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.3 }}
    >
      <div className='flex items-center bg-gradient-to-r from-primaryColor to-blue-500 p-4'>
        {icon && <span className='mr-2 text-xl text-white'>{icon}</span>}
        <h2 className='text-[16px] font-bold uppercase text-white'>
          {heading}
        </h2>
      </div>
      <div className='p-5'>{children}</div>
    </motion.div>
  );
};

export default InfoCard;

// import React from 'react';

// type InfoCardProps = {
//   children: React.ReactNode;
//   heading: string;
// };
// const InfoCard: React.FC<InfoCardProps> = ({ children, heading }) => {
//   return (
//     <div className='flex w-full flex-col gap-[14px] bg-slate-100 p-5'>
//       <div className='text-[13px] font-extrabold text-primaryColor'>
//         {heading}
//       </div>
//       {children}
//     </div>
//   );
// };

// export default InfoCard;
