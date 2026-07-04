import React from 'react';
import { Table } from 'antd';

interface TaskTableProps {
  dataSource: any[];
  columns: any[];
}

const TaskTable: React.FC<TaskTableProps> = ({ dataSource, columns }) => {
  return (
    <Table
      dataSource={dataSource}
      columns={columns}
      scroll={{ x: 'max-content' }}
    />
  );
};

export default TaskTable;
