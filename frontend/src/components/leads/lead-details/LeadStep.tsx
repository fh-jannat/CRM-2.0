import { COUNTRY, E_SUBSTAGE } from '@/enums';
import { Steps } from 'antd';
import { motion } from 'framer-motion';
import React, { useRef, useEffect } from 'react';
import {
  FaBookOpen,
  FaCheckCircle,
  FaClipboardCheck,
  FaDollarSign,
  FaEnvelopeOpen,
  FaFileSignature,
  FaGraduationCap,
  FaPassport,
  FaSchool,
  FaTimesCircle,
  FaUserPlus,
  FaUserTimes,
} from 'react-icons/fa';

interface LeadStepProps {
  leadStage: string;
  subStage?: string;
  country?: string;
}

export const LeadStep: React.FC<LeadStepProps> = ({
  leadStage,
  subStage,
  country,
}) => {
  const activeStepRef = useRef<HTMLDivElement | null>(null);

  // Assuming `steps` is already defined and populated elsewhere
  const steps =
    leadStage !== 'compliance'
      ? [
          { title: 'Lead', icon: FaUserPlus, step: 0 },
          { title: 'Student', icon: FaGraduationCap, step: 1 },
          { title: 'Admission', icon: FaBookOpen, step: 2 },
          { title: 'Visa', icon: FaPassport, step: 3 },
        ]
      : country === COUNTRY.AUSTRALIA
        ? [
            { title: E_SUBSTAGE.GTE, icon: FaClipboardCheck },
            { title: E_SUBSTAGE.FIRST_PAYMENT, icon: FaDollarSign },
            { title: E_SUBSTAGE.FINAL_CHOICE, icon: FaCheckCircle },
            { title: E_SUBSTAGE.GS_INTERVIEW, icon: FaFileSignature },
            { title: E_SUBSTAGE.COE_REQUESTED, icon: FaEnvelopeOpen },
            { title: E_SUBSTAGE.COE_RECEIVED, icon: FaCheckCircle },
            { title: E_SUBSTAGE.VISA_APPLICATION, icon: FaPassport },
            { title: E_SUBSTAGE.VISA_INTERVIEW, icon: FaFileSignature },
            { title: E_SUBSTAGE.VISA, icon: FaPassport },
            { title: E_SUBSTAGE.FINAL_PAYMENT, icon: FaDollarSign },
            { title: E_SUBSTAGE.ENROLLED, icon: FaSchool },
            { title: E_SUBSTAGE.REFUSED, icon: FaTimesCircle },
            { title: E_SUBSTAGE.NOT_ENROLLED, icon: FaUserTimes },
          ]
        : country === COUNTRY.USA
          ? [
              { title: E_SUBSTAGE.FIRST_PAYMENT, icon: FaDollarSign },
              { title: E_SUBSTAGE.FINAL_CHOICE, icon: FaCheckCircle },
              { title: E_SUBSTAGE.I20_REQUESTED, icon: FaEnvelopeOpen },
              { title: E_SUBSTAGE.I20_RECEIVED, icon: FaCheckCircle },
              { title: E_SUBSTAGE.VISA_APPLICATION, icon: FaPassport },
              { title: E_SUBSTAGE.VISA_INTERVIEW, icon: FaFileSignature },
              { title: E_SUBSTAGE.VISA, icon: FaPassport },
              { title: E_SUBSTAGE.FINAL_PAYMENT, icon: FaDollarSign },
              { title: E_SUBSTAGE.ENROLLED, icon: FaSchool },
              { title: E_SUBSTAGE.REFUSED, icon: FaTimesCircle },
              { title: E_SUBSTAGE.NOT_ENROLLED, icon: FaUserTimes },
            ]
          : country === COUNTRY.EUROPE
            ? [
                { title: E_SUBSTAGE.FIRST_INTERVIEW, icon: FaFileSignature },
                { title: E_SUBSTAGE.FIRST_PAYMENT, icon: FaDollarSign },
                { title: E_SUBSTAGE.FINAL_CHOICE, icon: FaCheckCircle },
                { title: E_SUBSTAGE.VISA_APPLICATION, icon: FaPassport },
                { title: E_SUBSTAGE.VISA_INTERVIEW, icon: FaFileSignature },
                { title: E_SUBSTAGE.VISA, icon: FaPassport },
                { title: E_SUBSTAGE.FINAL_PAYMENT, icon: FaDollarSign },
                { title: E_SUBSTAGE.ENROLLED, icon: FaSchool },
                { title: E_SUBSTAGE.REFUSED, icon: FaTimesCircle },
                { title: E_SUBSTAGE.NOT_ENROLLED, icon: FaUserTimes },
              ]
            : country === COUNTRY.NEWZEALAND
              ? [
                  { title: E_SUBSTAGE.FINAL_CHOICE, icon: FaCheckCircle },
                  { title: E_SUBSTAGE.VISA_APPLICATION, icon: FaPassport },
                  { title: E_SUBSTAGE.VISA_INTERVIEW, icon: FaFileSignature },
                  { title: E_SUBSTAGE.VISA, icon: FaPassport },
                  { title: E_SUBSTAGE.FINAL_PAYMENT, icon: FaDollarSign },
                  { title: E_SUBSTAGE.ENROLLED, icon: FaSchool },
                  { title: E_SUBSTAGE.REFUSED, icon: FaTimesCircle },
                  { title: E_SUBSTAGE.NOT_ENROLLED, icon: FaUserTimes },
                ]
              : country === COUNTRY.UAE
                ? [
                    { title: E_SUBSTAGE.FIRST_PAYMENT, icon: FaDollarSign },
                    { title: E_SUBSTAGE.FINAL_CHOICE, icon: FaCheckCircle },
                    { title: E_SUBSTAGE.VISA_APPLICATION, icon: FaPassport },
                    { title: E_SUBSTAGE.VISA_INTERVIEW, icon: FaFileSignature },
                    { title: E_SUBSTAGE.VISA, icon: FaPassport },
                    { title: E_SUBSTAGE.FINAL_PAYMENT, icon: FaDollarSign },
                    { title: E_SUBSTAGE.ENROLLED, icon: FaSchool },
                    { title: E_SUBSTAGE.REFUSED, icon: FaTimesCircle },
                    { title: E_SUBSTAGE.NOT_ENROLLED, icon: FaUserTimes },
                  ]
                : country === COUNTRY.MALAYSIA
                  ? [
                      { title: E_SUBSTAGE.FIRST_PAYMENT, icon: FaDollarSign },
                      { title: E_SUBSTAGE.FINAL_CHOICE, icon: FaCheckCircle },
                      { title: E_SUBSTAGE.VISA_APPLICATION, icon: FaPassport },
                      {
                        title: E_SUBSTAGE.VISA_INTERVIEW,
                        icon: FaFileSignature,
                      },
                      { title: E_SUBSTAGE.VISA, icon: FaPassport },
                      { title: E_SUBSTAGE.FINAL_PAYMENT, icon: FaDollarSign },
                      { title: E_SUBSTAGE.ENROLLED, icon: FaSchool },
                      { title: E_SUBSTAGE.REFUSED, icon: FaTimesCircle },
                      { title: E_SUBSTAGE.NOT_ENROLLED, icon: FaUserTimes },
                    ]
                  : country === COUNTRY.UK
                    ? [
                        { title: E_SUBSTAGE.FIRST_PAYMENT, icon: FaDollarSign },
                        { title: E_SUBSTAGE.FINAL_CHOICE, icon: FaCheckCircle },
                        {
                          title: E_SUBSTAGE.COMPLIANCE_INTERVIEW,
                          icon: FaClipboardCheck,
                        },
                        {
                          title: E_SUBSTAGE.CAS_REQUESTED,
                          icon: FaEnvelopeOpen,
                        },
                        { title: E_SUBSTAGE.CAS_RECEIVED, icon: FaCheckCircle },
                        {
                          title: E_SUBSTAGE.VISA_APPLICATION,
                          icon: FaPassport,
                        },
                        {
                          title: E_SUBSTAGE.VISA_INTERVIEW,
                          icon: FaFileSignature,
                        },
                        { title: E_SUBSTAGE.VISA, icon: FaPassport },
                        { title: E_SUBSTAGE.FINAL_PAYMENT, icon: FaDollarSign },
                        { title: E_SUBSTAGE.ENROLLED, icon: FaSchool },
                        { title: E_SUBSTAGE.REFUSED, icon: FaTimesCircle },
                        { title: E_SUBSTAGE.NOT_ENROLLED, icon: FaUserTimes },
                      ]
                    : country === COUNTRY.DENMARK
                      ? [
                          {
                            title: E_SUBSTAGE.FIRST_PAYMENT,
                            icon: FaDollarSign,
                          },
                          {
                            title: E_SUBSTAGE.FINAL_CHOICE,
                            icon: FaCheckCircle,
                          },
                          {
                            title: E_SUBSTAGE.VISA_APPLICATION,
                            icon: FaPassport,
                          },
                          {
                            title: E_SUBSTAGE.VISA_INTERVIEW,
                            icon: FaFileSignature,
                          },
                          { title: E_SUBSTAGE.VISA, icon: FaPassport },
                          {
                            title: E_SUBSTAGE.FINAL_PAYMENT,
                            icon: FaDollarSign,
                          },
                          { title: E_SUBSTAGE.ENROLLED, icon: FaSchool },
                          { title: E_SUBSTAGE.REFUSED, icon: FaTimesCircle },
                          { title: E_SUBSTAGE.NOT_ENROLLED, icon: FaUserTimes },
                        ]
                      : country === COUNTRY.CANADA
                        ? [
                            {
                              title: E_SUBSTAGE.FIRST_PAYMENT,
                              icon: FaDollarSign,
                            },
                            {
                              title: E_SUBSTAGE.FINAL_CHOICE,
                              icon: FaCheckCircle,
                            },
                            {
                              title: E_SUBSTAGE.PAL_RECEIVED,
                              icon: FaClipboardCheck,
                            },
                            {
                              title: E_SUBSTAGE.VISA_APPLICATION,
                              icon: FaPassport,
                            },
                            {
                              title: E_SUBSTAGE.VISA_INTERVIEW,
                              icon: FaFileSignature,
                            },
                            { title: E_SUBSTAGE.VISA, icon: FaPassport },
                            {
                              title: E_SUBSTAGE.FINAL_PAYMENT,
                              icon: FaDollarSign,
                            },
                            { title: E_SUBSTAGE.ENROLLED, icon: FaSchool },
                            { title: E_SUBSTAGE.REFUSED, icon: FaTimesCircle },
                            {
                              title: E_SUBSTAGE.NOT_ENROLLED,
                              icon: FaUserTimes,
                            },
                          ]
                        : [];
  const getCurrentStep = (stage: string, subStage?: string) => {
    if (stage === 'lead') return 0;
    else if (stage === 'potential') return 1;
    else if (stage === 'admission') return 2;
    const stepIndex = steps.findIndex((item) => item.title === subStage);
    return stepIndex ?? 0;
  };

  const currentStep = getCurrentStep(leadStage, subStage);

  useEffect(() => {
    if (activeStepRef.current) {
      activeStepRef.current.scrollIntoView({
        behavior: 'smooth',
        block: 'center',
      });
    }
  }, [currentStep]);

  return (
    <motion.div
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.5 }}
      className='flex w-full max-w-3xl items-center justify-center overflow-y-auto rounded-lg    bg-white p-4 shadow-md scrollbar-hide'
    >
      <Steps
        current={currentStep}
        responsive={true}
        labelPlacement='vertical'
        items={steps.map((step, index) => ({
          title: (
            <span
              className={`!w-3xl truncate whitespace-nowrap text-xs font-medium capitalize ${
                currentStep === index ? 'text-blue-600' : 'text-gray-500'
              }`}
            >
              {step.title}
            </span>
          ),
          icon: (
            <motion.div
              whileHover={{ scale: 1.1 }}
              ref={currentStep === index ? activeStepRef : null}
              className={`flex h-8 w-8 items-center justify-center rounded-full ${
                currentStep === index
                  ? 'bg-blue-600 text-white'
                  : 'bg-gray-200 text-gray-500'
              }`}
            >
              <step.icon className='text-lg' />
            </motion.div>
          ),
          status:
            currentStep === index
              ? 'process'
              : currentStep > index
                ? 'finish'
                : 'wait',
        }))}
      />
    </motion.div>
  );
};
