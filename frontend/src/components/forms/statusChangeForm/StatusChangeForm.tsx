'use client';
import { useUpdateLead } from '@/apis';
import SelectAssignee from '@/components/common/SelectAssignee';
import { E_STAGE, E_SUBSTAGE } from '@/enums';
import { ISubmittedData } from '@/interfaces';
import { ArrowDownOutlined } from '@ant-design/icons';
import { Button, Form, Input, Select } from 'antd';
import { BaseOptionType } from 'antd/es/select';
import React from 'react';
import { toast } from 'react-toastify';
import ApplicationsForm from './ApplicationsForm';
import DocumentsForm from './DocumentsForm';
import { getStatusOptions } from './helper';
import { handleErrorToast } from '@/utils/handleErrorToast';

interface StatusChangeFormProps {
  id?: string;
  currentStage: string;
  currentSubStage: string;
  country?: string;
  onSubmit?: (data?: any) => void;
}
export const StatusChangeForm: React.FC<StatusChangeFormProps> = ({
  id,
  currentStage,
  currentSubStage,
  country,
  onSubmit,
}) => {
  const [form] = Form.useForm();
  const updateLead = useUpdateLead();
  const onFinish = async (data: ISubmittedData) => {
    data.id = id;
    // data.stage = currentStage;
    console.log(data);

    try {
      await updateLead.mutateAsync(data);
      if (onSubmit) {
        onSubmit(data);
      }
      toast.success('Status updated successfully');
    } catch (error: any) {
      handleErrorToast(error);
    } finally {
      form.resetFields();
    }
  };

  const statusOptionsLength = getStatusOptions(
    currentStage as E_STAGE,
    currentSubStage as E_SUBSTAGE,
    country
  ).length;

  return (
    <Form form={form} onFinish={onFinish} layout='vertical'>
      <div className='flex w-full flex-col items-center justify-center gap-4'>
        <div className='mb-3 w-full border-[1px] border-gray-200' />
        <div className='flex w-full flex-col gap-4'>
          <div className='w-full text-[1.2rem] font-semibold text-blue-400'>
            Current Status <ArrowDownOutlined />
          </div>
          <div className='flex w-full flex-row gap-3'>
            <Input
              size='large'
              value={`Stage: ${currentStage}`}
              disabled
              className='capitalize'
            />
            <Input
              size='large'
              value={`Sub-stage: ${currentSubStage}`}
              disabled
              className='capitalize'
            />
          </div>
        </div>
        <div className='flex w-full flex-col gap-4'>
          <div className='w-full text-[1.2rem] font-semibold text-blue-400'>
            <div className='mt-4'>
              Change Status To <ArrowDownOutlined />
            </div>
          </div>
          <div className='flex flex-wrap space-x-4'></div>
        </div>

        <>
          <Form.Item hidden name={'stage'} />
          <Form.Item
            className='w-full'
            label='Change status to'
            name={'subStage'}
            rules={[{ required: true, message: 'Please select a status' }]}
          >
            <Select
              size='large'
              style={{ width: '100%' }}
              placeholder={`${statusOptionsLength ? 'Select status' : 'No option'}`}
              disabled={
                getStatusOptions(
                  currentStage as E_STAGE,
                  currentSubStage as E_SUBSTAGE,
                  country
                ).length === 0
              }
              options={
                getStatusOptions(
                  currentStage as E_STAGE,
                  currentSubStage as E_SUBSTAGE,
                  country
                ).filter((option) => option !== null) as BaseOptionType[]
              }
              onChange={(value) => {
                console.log(value);
                if (
                  value === E_SUBSTAGE.WAITING_FOR_DOCUMENT ||
                  value === E_SUBSTAGE.APPOINTMENT_BOOK
                ) {
                  form.setFieldValue('stage', E_STAGE.POTENTIAL);
                } else if (value === E_SUBSTAGE.DOCUMENT_RECEIVED) {
                  form.setFieldValue('stage', E_STAGE.ADMISSION);
                } else if (value === E_SUBSTAGE.FINAL_CHOICE) {
                  form.setFieldValue('stage', E_STAGE.COMPLIANCE);
                } else if (
                  value === E_SUBSTAGE.IELTS_FIRST_TRACK ||
                  value === E_SUBSTAGE.IELTS_GENERAL ||
                  value === E_SUBSTAGE.IELTS_EXTENDED ||
                  value === E_SUBSTAGE.PTE_FIRST_TRACK ||
                  value === E_SUBSTAGE.PTE_GENERAL ||
                  value === E_SUBSTAGE.PTE_EXTENDED ||
                  value === E_SUBSTAGE.MOCK ||
                  value === E_SUBSTAGE.EXAM ||
                  value === E_SUBSTAGE.PASS ||
                  value === E_SUBSTAGE.FAIL
                ) {
                  form.setFieldValue('stage', E_STAGE.ENROLLED);
                } else {
                  form.setFieldValue('stage', currentStage);
                }
              }}
            />
            {(currentSubStage === E_SUBSTAGE.APPLIED ||
              currentSubStage === E_SUBSTAGE.START_APPLICATION) && (
              <div className='text-red-500'>
                Please change application status
              </div>
            )}
          </Form.Item>
          <></>
        </>

        {currentSubStage === E_SUBSTAGE.WAITING_FOR_DOCUMENT && (
          <>
            <DocumentsForm />
            <ApplicationsForm />
          </>
        )}

        <Form.Item
          rules={[{ required: true, message: 'Please add a remark' }]}
          className='w-full'
          label='Remark'
          name={'remark'}
        >
          <Input
            size='large'
            placeholder='Remark'
            disabled={statusOptionsLength === 0}
          />
        </Form.Item>
        {(currentSubStage === E_SUBSTAGE.WAITING_FOR_DOCUMENT ||
          currentSubStage === E_SUBSTAGE.END_APPLICATION) && (
          <Form.Item
            className='w-full'
            label='Assignee'
            name={'assignedTo'}
            rules={[{ required: true, message: 'Please select assignee' }]}
          >
            <SelectAssignee
              stage={currentStage}
              size='large'
              placeholder='Select assignee'
            />
          </Form.Item>
        )}

        <Form.Item>
          <Button
            type='primary'
            onClick={() => {
              form.submit();
            }}
          >
            Submit
          </Button>
        </Form.Item>
      </div>
    </Form>
  );
};
