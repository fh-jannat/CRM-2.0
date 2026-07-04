'use client';
import { useCreateLead, useGetLeadById, useUpdateLead } from '@/apis';
import { E_SUBSTAGE } from '@/enums';
import { ApplicationType, DocumentType } from '@/types';
import { handleErrorToast } from '@/utils/handleErrorToast';
import { Form, FormInstance } from 'antd';
import { useRouter } from 'next/navigation';
import {
  ReactNode,
  createContext,
  useContext,
  useEffect,
  useState,
} from 'react';
import { toast } from 'react-toastify';

interface AddNewLeadContextData {
  form: FormInstance;
  selectedPurpose: string;
  setSelectedPurpose: (purpose: string) => void;
  selectedStage: string;
  setSelectedStage: (stage: string) => void;
  subStage: string;
  setSubStage: (subStage: string) => void;
  documents: DocumentType[];
  setDocuments: (documents: DocumentType[]) => void;
  applications: ApplicationType[];
  setApplications: (applications: ApplicationType[]) => void;
  onSubmit: (values: any) => Promise<void>;
  loading: boolean;
  setLoading: (loading: boolean) => void;
  leadId: string;
  setLeadId: (leadId: string) => void;
  countryId: number;
  setCountryId: (id: number) => void;
  isClass: boolean;
  setIsClass: (isClass: boolean) => void;
  classes: any[];
  setClasses: (classes: any[]) => void;
  exams: any[];
  setexams: (exams: any[]) => void;
  // activeFormKey: string;
  // setActiveFormkey: (value:string) => void;
}

const AddNewLeadContext = createContext<AddNewLeadContextData>(
  {} as AddNewLeadContextData
);

export const useLeadContext = () => {
  const context = useContext(AddNewLeadContext);
  if (!context) {
    throw new Error('useSensorContext must be used within a SensorProvider');
  }
  return context;
};

interface LeadContextProviderProps {
  children: ReactNode;
}

export const LeadContextProvider: React.FC<LeadContextProviderProps> = ({
  children,
}) => {
  const [form] = Form.useForm();
  const [documents, setDocuments] = useState<DocumentType[]>([]);
  const [applications, setApplications] = useState<ApplicationType[]>([]);
  const [selectedPurpose, setSelectedPurpose] = useState('');
  const [selectedStage, setSelectedStage] = useState('');
  const [subStage, setSubStage] = useState<string>('');
  const [loading, setLoading] = useState<boolean>(false);
  const [leadId, setLeadId] = useState<string>('');
  const [countryId, setCountryId] = useState<number>(-1);
  const [isClass, setIsClass] = useState(false);
  const [classes, setClasses] = useState<any[]>([]);
  const [exams, setexams] = useState<any[]>([]);
  const leadByIdQuery = {
    query: {
      relations: {
        leadApplications: { university: true },
        assigned: true,
        leadDocs: true,
      },
    },
  };
  const router = useRouter();
  const createLead = useCreateLead();
  const updateLead = useUpdateLead();
  const getLeadById = useGetLeadById(leadId, leadByIdQuery);

  useEffect(() => {
    if (leadId) fetchLeadInfo();
    else form.resetFields();
  }, [leadId]);

  useEffect(() => {
    setIsClass(
      subStage === E_SUBSTAGE.IELTS_GENERAL ||
        subStage === E_SUBSTAGE.IELTS_FIRST_TRACK ||
        subStage === E_SUBSTAGE.IELTS_EXTENDED ||
        subStage === E_SUBSTAGE.PTE_GENERAL ||
        subStage === E_SUBSTAGE.PTE_FIRST_TRACK ||
        subStage === E_SUBSTAGE.PTE_EXTENDED
    );
    form.resetFields(['classes', 'exams']);
  }, [subStage]);

  const fetchLeadInfo = async () => {
    setLoading(true);
    const { data: leadInfo } = await getLeadById.refetch();
    if (leadInfo?.assigned) {
      leadInfo.assignedTo = leadInfo?.assigned?.id;
    }
    form.setFieldsValue(leadInfo);
    setSelectedPurpose(leadInfo?.purpose);
    setSelectedStage(leadInfo?.stage);
    setSubStage(leadInfo?.subStage);
    if (leadInfo?.classes) {
      setClasses(leadInfo?.classes);
    }
    if (leadInfo?.exams) {
      setexams(leadInfo?.exams);
    }
    if (leadInfo?.leadApplications) setApplications(leadInfo?.leadApplications);
    if (leadInfo?.leadDocs) setDocuments(leadInfo?.leadDocs);
    setLoading(false);
    console.log('LeadInfo by id', leadInfo);
  };

  const onSubmit = async (values: any): Promise<void> => {
    console.log('values', values);
    try {
      setLoading(true);
      if (leadId) {
        await updateLead.mutateAsync({ ...values, id: leadId });
        toast.success('Updated successfully');
      } else {
        const data = await createLead.mutateAsync(values);
        toast.success('Saved successfully');
        form.resetFields();
        router.push(`/lead-create/${data.id}`);
      }
    } catch (error) {
      handleErrorToast(error);
    } finally {
      setLoading(false);
      await fetchLeadInfo();
    }
  };

  const contextValue: AddNewLeadContextData = {
    form,
    selectedPurpose,
    setSelectedPurpose,
    selectedStage,
    setSelectedStage,
    subStage,
    setSubStage,
    documents,
    setDocuments,
    applications,
    setApplications,
    onSubmit,
    loading,
    setLoading,
    leadId,
    setLeadId,
    countryId,
    setCountryId,
    isClass,
    setIsClass,
    classes,
    setClasses,
    exams,
    setexams,
  };

  return (
    <AddNewLeadContext.Provider value={contextValue}>
      {children}
    </AddNewLeadContext.Provider>
  );
};
