'use client';

import { useGetReportData, useGetRolesQuery } from '@/apis';
import BarChart from '@/components/chart/BarChart';
import PieChart from '@/components/chart/PieChart';
import NotFoundChart from '@/components/chart/NotFoundChart';
import { Button, DatePicker, Spin } from 'antd';
import React, { useState } from 'react';
import SelectAssignee from '../common/SelectAssignee';

import dayjs from 'dayjs';
import { SelectBranch } from '../common/Selectors/SelectBranch';
import { Role } from '@/enums';

export const Reports = () => {
  const [query, setQuery] = useState({
    query: {
      startDate: null,
      endDate: null,
      branchName: null,
      initiatorId: null,
    },
  });

  const handleDateChange = (dates: any) => {
    setQuery((prevQuery) => ({
      ...prevQuery,
      query: {
        ...prevQuery.query,
        startDate: dates ? dates[0].format('YYYY-MM-DD hh:mm:ss') : null,
        endDate: dates ? dates[1].format('YYYY-MM-DD hh:mm:ss') : null,
      },
    }));
  };

  const handleRoleChange = (value: any) => {
    setQuery((prevQuery) => ({
      ...prevQuery,
      query: {
        ...prevQuery.query,
        initiatorId: value,
      },
    }));
  };

  const handleBranchChange = (value: any) => {
    setQuery((prevQuery) => ({
      ...prevQuery,
      query: {
        ...prevQuery.query,
        branchName: value,
      },
    }));
  };

  const clearQuery = () => {
    setQuery({
      query: {
        startDate: null,
        endDate: null,
        branchName: null,
        initiatorId: null,
      },
    });
  };

  const { data, isLoading } = useGetReportData(query);
  const { data: roles } = useGetRolesQuery();

  // Define the order of stages to render in a specific order if needed
  const stageOrder = ['lead', 'potential', 'admission', 'compliance'];

  // Sort data according to the defined stageOrder
  const sortedData = data?.slice().sort((a: any, b: any) => {
    return (
      stageOrder.indexOf(a.stage.toLowerCase()) -
      stageOrder.indexOf(b.stage.toLowerCase())
    );
  });

  return (
    <div className='relative flex w-full flex-col'>
      <div>
        <DatePicker.RangePicker
          onChange={handleDateChange}
          showTime
          value={
            query.query.startDate && query.query.endDate
              ? [dayjs(query.query.startDate), dayjs(query.query.endDate)]
              : null
          }
        />
        <SelectAssignee
          placeholder='Select assignee'
          stage='all'
          branchSpecificApplication={
            ![Role.ADMIN].some((role) => roles?.includes(role))
          }
          style={{ width: 200, marginLeft: 10 }}
          onChange={handleRoleChange}
          value={query.query.initiatorId}
        />
        <SelectBranch
          placeholder='Select branch'
          style={{ width: 200, marginLeft: 10 }}
          onChange={handleBranchChange}
          value={query.query.branchName}
        />
        <Button
          type='primary'
          onClick={clearQuery}
          style={{ width: 200, marginLeft: 10 }}
          className='rounded-lg'
        >
          Clear
        </Button>
      </div>

      <Spin spinning={isLoading}>
        <div className='grid w-full grid-cols-2 gap-4 py-4'>
          {['lead', 'potential', 'admission', 'compliance', 'course-lead'].map(
            (stage, index) => {
              const stageFound = sortedData?.find(
                (stageData: any) => stageData.stage === stage
              );
              if (index === 1 || index === 4) {
                return (
                  <div
                    key={stage}
                    className={`${index === 4 ? 'col-span-2' : 'col-span-1'}`}
                  >
                    {stageFound ? (
                      <BarChart
                        data={stageFound.subStageInfo}
                        stage={stageFound.stage}
                      />
                    ) : (
                      <NotFoundChart stage={stage} />
                    )}
                  </div>
                );
              } else {
                return (
                  <div key={stage} className='col-span-1'>
                    {stageFound ? (
                      <PieChart
                        data={stageFound.subStageInfo}
                        stage={stageFound.stage}
                      />
                    ) : (
                      <NotFoundChart stage={stage} />
                    )}
                  </div>
                );
              }
            }
          )}
        </div>
      </Spin>
    </div>
  );
};
