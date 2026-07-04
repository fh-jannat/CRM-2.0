import {
  CheckOutlined,
  CompassOutlined,
  DeleteOutlined,
  EditOutlined,
  MailOutlined,
  PlusOutlined,
  SwapOutlined,
} from '@ant-design/icons';
import { Button, Popconfirm, Tooltip } from 'antd';
import React from 'react';

// Define props for each custom button component
type ActionButtonProps = {
  children?: React.ReactNode;
  onClick?: () => void;
  disabled?: boolean;
};

// Define the ActionButton component
const ActionButton: React.FC<ActionButtonProps> & {
  Edit: React.FC<ActionButtonProps>;
  DeleteWithConfirmation: React.FC<ActionButtonProps>;
  Convert: React.FC<ActionButtonProps>;
  AddRemark: React.FC<ActionButtonProps>;
  ChangeStatus: React.FC<ActionButtonProps>;
  AdminChangeStatus: React.FC<ActionButtonProps>;
  SendMail: React.FC<ActionButtonProps>;
  AssignTask: React.FC<ActionButtonProps>;
  MarkAsRead: React.FC<ActionButtonProps>;
} = ({ children, onClick, disabled }) => {
  return (
    <>
      {React.Children.map(children, (child, index) =>
        React.cloneElement(child as React.ReactElement, {
          onClick, // Pass onClick function to the child button
          disabled,
          key: index, // Ensure each child has a unique key
        })
      )}
    </>
  );
};

// Define custom button components with display names
ActionButton.Edit = function EditButton({ onClick }) {
  return (
    <Tooltip title='Edit'>
      <Button
        size='small'
        style={{ color: 'white', background: '#6366F1', borderRadius: '50%' }}
        onClick={(event: any) => {
          event.stopPropagation();
          onClick && onClick();
        }}
        icon={<EditOutlined />}
      />
    </Tooltip>
  );
};

ActionButton.DeleteWithConfirmation = function DeleteButton({ onClick }) {
  return (
    <Tooltip title='Delete'>
      <Popconfirm
        okText='Yes'
        placement='left'
        onConfirm={(event: any) => {
          event.stopPropagation();
          onClick && onClick();
        }}
        onCancel={() => {}}
        title='Warning!!!!'
        description='Are you sure to delete?'
        okButtonProps={{ danger: true }}
      >
        <Button
          size='small'
          onClick={(event: any) => {
            event.stopPropagation();
          }}
          style={{ color: 'white', background: '#EF4444', borderRadius: '50%' }}
          icon={<DeleteOutlined />}
        />
      </Popconfirm>
    </Tooltip>
  );
};

ActionButton.Convert = function ConvertButton({ onClick }) {
  return (
    <Tooltip title='Convert Lead'>
      <Popconfirm
        okText='Yes'
        placement='left'
        onConfirm={(event: any) => {
          event.stopPropagation();
          onClick && onClick();
        }}
        onCancel={() => {}}
        title='Warning!!!!'
        description='Are you sure to convert?'
        okButtonProps={{ danger: true }}
      >
        <Button
          size='small'
          style={{ color: 'white', background: '#F59E0B', borderRadius: '50%' }}
          onClick={(event: any) => {
            event.stopPropagation();
          }}
          icon={<SwapOutlined />}
        />
      </Popconfirm>
    </Tooltip>
  );
};

ActionButton.AddRemark = function AddRemarkButton({ onClick }) {
  return (
    <Tooltip title='Add Remarks'>
      <Button
        size='small'
        style={{ color: 'white', background: '#34D399', borderRadius: '50%' }}
        onClick={(event: any) => {
          event.stopPropagation();
          onClick && onClick();
        }}
        icon={<PlusOutlined />}
      />
    </Tooltip>
  );
};

ActionButton.ChangeStatus = function ChangeStatusButton({ onClick }) {
  return (
    <Tooltip title='Change Status'>
      <Button
        size='small'
        style={{ color: 'white', background: '#34D399', borderRadius: '50%' }}
        onClick={(event: any) => {
          event.stopPropagation();
          onClick && onClick();
        }}
        icon={<PlusOutlined />}
      />
    </Tooltip>
  );
};

ActionButton.AdminChangeStatus = function ChangeStatusButton({ onClick }) {
  return (
    <Tooltip title='Admin Change Status'>
      <Button
        size='small'
        style={{ color: 'white', background: '#34D399', borderRadius: '50%' }}
        onClick={(event: any) => {
          event.stopPropagation();
          onClick && onClick();
        }}
        icon={<CompassOutlined />}
      />
    </Tooltip>
  );
};

ActionButton.AssignTask = function AssignTaskButton({ onClick }) {
  return (
    <Tooltip title='Assign Task'>
      <Button
        size='small'
        style={{ color: 'white', background: '#34D399', borderRadius: '50%' }}
        onClick={(event: any) => {
          event.stopPropagation();
          onClick && onClick();
        }}
        icon={<PlusOutlined />}
      />
    </Tooltip>
  );
};

ActionButton.SendMail = function SendMailButton({ onClick }) {
  return (
    <Tooltip title='Send Credentials'>
      <Button
        size='small'
        style={{ color: 'white', background: '#10B981', borderRadius: '50%' }}
        onClick={(event: any) => {
          event.stopPropagation();
          onClick && onClick();
        }}
        icon={<MailOutlined />}
      />
    </Tooltip>
  );
};

ActionButton.MarkAsRead = function MarkAsReadButton({ onClick, disabled }) {
  return (
    <Tooltip title='Mark as read'>
      <Button
        size='small'
        style={{ color: 'white', background: '#10B981', borderRadius: '50%' }}
        onClick={(event: any) => {
          event.stopPropagation();
          onClick && onClick();
        }}
        icon={<CheckOutlined />}
        disabled={disabled}
      />
    </Tooltip>
  );
};

ActionButton.displayName = 'ActionButton'; // Set component name

export default ActionButton;
