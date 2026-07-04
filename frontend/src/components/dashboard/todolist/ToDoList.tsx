import { CheckOutlined, DeleteFilled, PlusOutlined } from '@ant-design/icons';
import { Button, Select } from 'antd';
import React, { useState } from 'react';
import TaskForm from './TaskForm';
import TaskTable from './TaskTable';

interface Task {
  id: number;
  task: string;
  taskDetails: string;
  from: string;
  to: string;
  status: string;
  assigned: string;
}

const ToDoList: React.FC = () => {
  const [tasks, setTasks] = useState<Task[]>([]);
  const [visible, setVisible] = useState(false);

  const handleAddTask = () => {
    setVisible(true);
  };

  const handleModalOk = (values: any) => {
    const newTask: Task = {
      id: tasks.length + 1,
      task: values.task,
      taskDetails: values.taskDetails,
      from: values.from.format('YYYY-MM-DD HH:mm'),
      to: values.to.format('YYYY-MM-DD HH:mm'),
      status: 'Pending',
      assigned: values.assigned,
    };
    setTasks([...tasks, newTask]);
    setVisible(false);
  };

  const handleModalCancel = () => {
    setVisible(false);
  };

  const columns = [
    {
      title: 'No',
      dataIndex: 'id',

      width: 50,
    },
    {
      title: 'Task',
      dataIndex: 'task',
      fixed: 'left' as const,
      width: 150,
    },
    {
      title: 'Task Details',
      dataIndex: 'taskDetails',
    },
    {
      title: 'From',
      dataIndex: 'from',
    },
    {
      title: 'To',
      dataIndex: 'to',
    },
    {
      title: 'Status',
      dataIndex: 'status',
    },
    {
      title: 'Assigned',
      dataIndex: 'assigned',
    },
    {
      title: 'Actions',
      dataIndex: 'actions',
      fixed: 'right' as const,
      width: 150,
      render: () => (
        <div className='flex flex-1'>
          <Button
            type='primary'
            danger
            icon={<DeleteFilled />}
            style={{ marginRight: 8 }}
          >
            Cancel
          </Button>
          <Button type='primary' icon={<CheckOutlined />}>
            Resolve
          </Button>
        </div>
      ),
    },
  ];

  const { Option } = Select;

  const users = [
    { name: 'Srabonti', role: 'Counsellors' },
    { name: 'Rikita', role: 'CRO' },
  ];

  return (
    <div className='pt-10'>
      <h2 className='text-3xl font-bold'>To Do List</h2>
      <div className='mb-10 flex justify-between'>
        <Select defaultValue='All' style={{ width: 200, textAlign: 'left' }}>
          <Option value='All'>All Task</Option>
          {users.map((option) => (
            <Option key={option.name} value={option.name}>
              {option.name} ({option.role})
            </Option>
          ))}
        </Select>

        <Button type='primary' icon={<PlusOutlined />} onClick={handleAddTask}>
          New Task
        </Button>
      </div>
      <TaskForm
        visible={visible}
        onCancel={handleModalCancel}
        onOk={handleModalOk}
        users={users}
      />
      <TaskTable dataSource={tasks} columns={columns} />
    </div>
  );
};

export default ToDoList;
