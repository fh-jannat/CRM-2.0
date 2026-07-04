import React, { createContext, useContext, useState } from 'react';

interface AdminLayoutContextType {
  collapsed: boolean;
  setCollapsed: React.Dispatch<React.SetStateAction<boolean>>;
  drawer: boolean;
  setDrawer: (value: boolean) => void;
}

const initialAdminLayoutContext: AdminLayoutContextType = {
  collapsed: false,
  setCollapsed: () => {},
  drawer: false,
  setDrawer: () => {},
};

const AdminLayoutContext = createContext<AdminLayoutContextType>(
  initialAdminLayoutContext
);

export const useAdminLayout = () => useContext(AdminLayoutContext);

interface AdminLayoutProviderProps {
  children: React.ReactNode;
}

const AdminLayoutProvider: React.FC<AdminLayoutProviderProps> = ({
  children,
}: AdminLayoutProviderProps) => {
  const [collapsed, setCollapsed] = useState<boolean>(false);
  const [drawer, setDrawer] = useState(false);

  return (
    <AdminLayoutContext.Provider
      value={{ collapsed, setCollapsed, drawer, setDrawer }}
    >
      {children}
    </AdminLayoutContext.Provider>
  );
};

export default AdminLayoutProvider;
