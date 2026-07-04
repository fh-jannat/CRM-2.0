import SelectAssignee from '@/components/common/SelectAssignee';
import { useLeadContext } from '@/contexts/AddNewLeadContext';
import { Button, Card, Form, Modal, Select, Typography } from 'antd';
import { useState } from 'react';
import { StatusChangeForm } from '@/components/forms';
import { useGetRolesQuery } from '@/apis';
import { E_PURPOSE, E_STAGE, E_SUBSTAGE, Role } from '@/enums';
import { optionGenerator } from '@/utils';
import { SelectBranch } from '@/components/common/Selectors/SelectBranch';
import AttendanceForm from './AttendanceForm';

const { Title, Text } = Typography;

const LeadStatusForm = () => {
  const {
    form,
    setSelectedPurpose,
    onSubmit,
    leadId,
    selectedStage,
    setSelectedStage,
    subStage,
    setSubStage,
    setLeadId,
  } = useLeadContext();
  const [modalOpen, setOpenModal] = useState(false);
  const { data: roles } = useGetRolesQuery();
  const handleStatusSave = async () => {
    try {
      const values = await form.validateFields([
        'fullName',
        'email',
        'purpose',
        'stage',
        'subStage',
        'assignedTo',
        'classes',
        'branchName',
        'exams',
      ]);
      if (!values?.errorFields) {
        onSubmit(values);
      }
    } catch (error) {
      console.log(error);
    }
  };

  const getModalWidth = () => {
    if (typeof window !== 'undefined') {
      const screenWidth = window.innerWidth;
      if (screenWidth < 576) {
        return screenWidth - 32;
      } else {
        return 700;
      }
    }
  };

  return (
    <div className='mt-3 flex w-full flex-col gap-3'>
      {leadId && (
        <Card className='mb-4'>
          <div className='flex items-center justify-between'>
            <div>
              <Title level={4} className='mb-2'>
                Lead Status
              </Title>
              <div className='flex space-x-4'>
                <div>
                  <Text strong>Stage:</Text>
                  <Text className='ml-2' type='success'>
                    {selectedStage}
                  </Text>
                </div>
                <div>
                  <Text strong>Substage:</Text>
                  <Text className='ml-2' type='warning'>
                    {subStage}
                  </Text>
                </div>
              </div>
            </div>
            <Button type='primary' onClick={() => setOpenModal(true)}>
              Change Status
            </Button>
          </div>
        </Card>
      )}
      <div className='flex flex-wrap gap-3'>
        <Form.Item
          className='w-full md:max-w-[320px]'
          label='Purpose'
          name={'purpose'}
          initialValue={E_PURPOSE.STUDY_ABROAD}
          rules={[{ required: true, message: 'Please input purpose' }]}
        >
          <Select
            onChange={(value: any) => {
              setSelectedPurpose(value);
              if (value === E_PURPOSE.COURSES) {
                form.setFieldValue('stage', E_STAGE.COURSE_LEAD);
                form.setFieldValue('subStage', E_SUBSTAGE.COURSE_NEW);
              }
              if (value === E_PURPOSE.STUDY_ABROAD) {
                form.setFieldValue('stage', E_STAGE.LEAD);
                form.setFieldValue('subStage', E_SUBSTAGE.NEW);
              }
            }}
            options={optionGenerator(E_PURPOSE)}
            size='large'
            placeholder='Select purpose'
          />
        </Form.Item>

        <>
          <Form.Item
            label='Stage'
            name='stage'
            initialValue={E_STAGE.LEAD}
            hidden={true}
            className='w-full md:max-w-[320px]'
            rules={[
              {
                required: true,
                message: 'select stage',
              },
            ]}
          />
          {leadId && (
            <Form.Item
              label='Substage'
              name='subStage'
              hidden={true}
              className='w-full md:max-w-[320px]'
              rules={[
                {
                  required: true,
                  message: 'select substage',
                },
              ]}
            />
          )}
        </>

        {[Role.ADMIN].some((role) => roles?.includes(role)) ? (
          <>
            <Form.Item
              className='w-full md:max-w-[320px]'
              label='Branch'
              name={'branchName'}
              rules={[{ required: true, message: 'Please input branch' }]}
            >
              <SelectBranch size='large' placeholder='Select branch' />
            </Form.Item>
          </>
        ) : null}
        {[Role.ADMIN, Role.MANAGER].some((role) => roles?.includes(role)) ? (
          <>
            <Form.Item
              className='w-full md:max-w-[320px]'
              label='Assign to'
              name={'assignedTo'}
              rules={[{ required: true, message: 'Please input assigne' }]}
            >
              <SelectAssignee
                stage={selectedStage ?? 'all'}
                size='large'
                placeholder='Select assignee'
              />
            </Form.Item>
          </>
        ) : null}
      </div>
      {subStage === E_SUBSTAGE.IELTS_GENERAL ||
      subStage === E_SUBSTAGE.IELTS_FIRST_TRACK ||
      subStage === E_SUBSTAGE.IELTS_EXTENDED ||
      subStage === E_SUBSTAGE.PTE_GENERAL ||
      subStage === E_SUBSTAGE.PTE_FIRST_TRACK ||
      subStage === E_SUBSTAGE.PTE_EXTENDED ||
      subStage === E_SUBSTAGE.MOCK ||
      subStage === E_SUBSTAGE.EXAM ? (
        <AttendanceForm />
      ) : null}
      {/* <DocumentsForm /> */}

      <Modal
        title='Change Status'
        open={modalOpen}
        onCancel={() => setOpenModal(false)}
        style={{ height: '100vh', overflowY: 'auto', top: 10 }}
        footer={null}
        width={getModalWidth()}
      >
        <StatusChangeForm
          currentStage={selectedStage ?? E_STAGE.LEAD}
          currentSubStage={subStage ?? E_SUBSTAGE.NEW}
          id={leadId}
          onSubmit={(data: any) => {
            console.log(data);
            setSelectedStage(data?.stage);
            form.setFieldsValue({ stage: data?.stage });
            setSubStage(data?.subStage);
            form.setFieldsValue({ subStage: data?.subStage });
            setLeadId(data?.id);
            setOpenModal(false);
          }}
        />
      </Modal>
      <Form.Item>
        <Button type='primary' onClick={handleStatusSave}>
          Save
        </Button>
      </Form.Item>
    </div>
  );
};

export default LeadStatusForm;
