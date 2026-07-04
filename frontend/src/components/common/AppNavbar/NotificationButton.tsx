import { Badge, ButtonProps } from 'antd';
import { motion } from 'framer-motion';
import React from 'react';
import { FaBell } from 'react-icons/fa';

type Props = ButtonProps & {
  count: number;
};

export const NotificationButton: React.FC<Props> = ({
  size,
  disabled,
  count,
  onClick,
}) => {
  return (
    <motion.div
      whileHover={{ scale: 1.1 }}
      whileTap={{ scale: 0.9 }}
      onClick={onClick}
      className='flex h-[40px] w-[40px] cursor-pointer items-center justify-center rounded-full bg-[#ceeedf] transition-all duration-200 ease-in-out hover:bg-[#b5e4d0]'
      style={{
        height: size === 'large' ? '40px' : '32px',
        cursor: disabled ? 'not-allowed' : 'pointer',
      }}
    >
      <Badge count={count} offset={[0, 0]} size='small'>
        <FaBell className='text-xl' />
      </Badge>
    </motion.div>
  );
};

// import { BellOutlined } from '@ant-design/icons';
// import { Badge, ButtonProps } from 'antd';
// import React from 'react';

// type Props = ButtonProps & {
//   count: number;
// };
// export const NotificationButton: React.FC<Props> = ({
//   size,
//   disabled,
//   count,
//   onClick,
// }) => {
//   console.log(size, disabled);
//   return (
//     <div
//       onClick={onClick}
//       className='flex h-[30px] w-[30px] cursor-pointer items-center justify-center rounded-[50%] bg-[#ceeedf] hover:scale-105'
//     >
//       <Badge count={count} offset={[0, 0]} size='small'>
//         <BellOutlined className='' />
//       </Badge>
//     </div>
//   );
// };
