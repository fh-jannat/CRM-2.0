'use client';
import ApplicationList from '@/components/leads/createoredit/ApplicationList';
import DocumentList from '@/components/leads/createoredit/DocumentList';
import EnglishProficiencyForm from '@/components/leads/createoredit/EnglishProficiencyForm';
import EducationalInfoForm from '@/components/leads/createoredit/LastEducationalInfoForm';
import LeadStatusForm from '@/components/leads/createoredit/LeadStatusForm';
import PersonalInfoForm from '@/components/leads/createoredit/PersonalInfoForm';
import PreviousEducationHistoryForm from '@/components/leads/createoredit/PreviousEducationHistoryForm';
import { useLeadContext } from '@/contexts/AddNewLeadContext';
import { CaretRightOutlined } from '@ant-design/icons';
import {
  Button,
  Collapse,
  CollapseProps,
  Form,
  Space,
  Spin,
  theme,
} from 'antd';
import { useParams } from 'next/navigation';

const Page = () => {
  const leadId = useParams().leadId?.[0] as string;
  const { token } = theme.useToken();
  const { form, loading, setLeadId, selectedStage, onSubmit } =
    useLeadContext();
  if (leadId) {
    setLeadId(leadId);
  } else {
    setLeadId('');
  }

  const items: CollapseProps['items'] = [
    {
      key: 'personal',
      label: 'Personal Information',
      children: <PersonalInfoForm />,
    },
    {
      key: 'educational-history',
      label: 'Previous Education History',
      children: <PreviousEducationHistoryForm />,
    },
    {
      key: 'last-educational',
      label: 'Last Educational Information',
      children: <EducationalInfoForm />,
    },
    {
      key: 'english-proficiency',
      label: 'English Proficiency',
      children: <EnglishProficiencyForm />,
    },
    {
      key: 'lead-status',
      label: 'Lead Status & Assignee',
      children: <LeadStatusForm />,
    },
  ];
  if (
    selectedStage === 'potential' ||
    selectedStage === 'admission' ||
    selectedStage === 'compliance'
  ) {
    items.splice(items.length - 1, 0, {
      key: 'documents',
      label: 'Lead Documents',
      children: <DocumentList />,
    });
  }
  if (
    selectedStage === 'potential' ||
    selectedStage === 'admission' ||
    selectedStage === 'compliance'
  ) {
    items.splice(items.length - 1, 0, {
      key: 'applications',
      label: 'Student Applications',
      children: <ApplicationList />,
    });
  }

  return (
    <Spin tip='Processing....' spinning={loading}>
      <Form
        className='flex flex-col gap-5'
        form={form}
        layout='vertical'
        scrollToFirstError
        onFinish={onSubmit}
      >
        <Collapse
          items={items}
          defaultActiveKey={['personal']}
          bordered={false}
          expandIcon={({ isActive }) => (
            <CaretRightOutlined rotate={isActive ? 90 : 0} />
          )}
          style={{ background: token.colorBgContainer }}
        />
        <Space>
          <Form.Item>
            <Button
              htmlType='submit'
              style={{ borderRadius: '6px' }}
              size='large'
              type='primary'
            >
              {leadId ? 'Save Changes' : 'Create Lead'}
            </Button>
          </Form.Item>
          <Form.Item>
            <Button
              htmlType='reset'
              style={{ borderRadius: '6px' }}
              size='large'
            >
              Cancel
            </Button>
          </Form.Item>
        </Space>
      </Form>
    </Spin>
  );
};

export default Page;
