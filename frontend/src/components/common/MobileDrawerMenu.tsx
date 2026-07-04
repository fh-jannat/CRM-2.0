'use client';
import { Drawer } from 'antd';
import React, { useState } from 'react';
import AppMenu from './AppMenu';

type MobileDrawerProps = {
  setShowDrawer: React.Dispatch<React.SetStateAction<boolean>>;
};

const MobileDrawerMenu: React.FC<MobileDrawerProps> = ({ setShowDrawer }) => {
  const [visible, setVisible] = useState(true);

  const onClose = () => {
    setVisible(false);
    setShowDrawer(false); //
  };

  return (
    <Drawer
      placement='right'
      closable={true}
      onClose={onClose}
      open={visible}
      width={300}
    >
      <AppMenu />
    </Drawer>
  );
};

export default MobileDrawerMenu;
