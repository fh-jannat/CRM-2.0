'use client';
import { useGetRolesQuery } from '@/apis';
import InfoCard from '@/components/leads/lead-details/InfoCard';
import { Role } from '@/enums';
import { motion } from 'framer-motion';
import Image from 'next/image';
import React from 'react';
import {
  FaBook,
  FaBullseye,
  FaCcVisa,
  FaClipboardList,
  FaComments,
  FaFileAlt,
  FaGraduationCap,
  FaLanguage,
  FaMapMarkerAlt,
  FaUser,
} from 'react-icons/fa';
import { ApplicationTable } from './ApplicationTable';
import { DocumentTable } from './DocumentTable';
import { LeadStep } from './LeadStep';
import { RemarkTable } from './RemarkTable';
import { VisaTable } from './VisaTable';
import { SendMail } from '@/components/sendmail/SendMail';
import { CopyButton } from '@/components/common/CopyButton';

interface LeadBodyProps {
  leadInfo: any;
  refetch: () => Promise<any>;
}

export const LeadBody: React.FC<LeadBodyProps> = ({ leadInfo, refetch }) => {
  const { data: roles } = useGetRolesQuery();

  const titleAndValue = (title: string, value: any) => (
    <motion.div
      className='flex flex-wrap gap-[8px] rounded-md p-2 transition-colors duration-300 hover:bg-gray-100'
      whileHover={{ scale: 1.02 }}
    >
      <div className='text-[16px] font-semibold text-gray-700'>{title}:</div>
      <div className='text-[16px] font-medium text-gray-600'>{value}</div>
      <CopyButton value={value} />
    </motion.div>
  );

  const showRemarks = [
    Role.ADMIN,
    Role.MANAGER,
    Role.APPLICATION,
    Role.COMPLIANCE,
    Role.COUNSELLOR,
    Role.TEACHER,
  ].some((role) => roles?.includes(role));

  return (
    <motion.div
      className='flex flex-col gap-[16px] font-sans'
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      transition={{ duration: 0.5 }}
    >
      <div className='overflow-hidden rounded-[16px] border-[1px] border-[#bec8d9] bg-white shadow-lg'>
        {/* Header */}
        <div className='flex w-full flex-col items-center justify-between gap-[20px] bg-gradient-to-r from-primaryColor to-blue-500 p-[24px] md:flex-row'>
          <div className='flex flex-row items-center gap-[24px]'>
            <motion.div className='relative' whileHover={{ scale: 1.1 }}>
              <Image
                className='h-[120px] w-[120px] rounded-full border-4 border-white shadow-md'
                width={500}
                height={500}
                src={leadInfo?.profilePicture || '/avatar.jpeg'}
                alt='profile'
              />
            </motion.div>
            <div className='text-white'>
              <h1 className='text-3xl font-bold'>
                {leadInfo?.fullName || 'N/A'}
              </h1>
              <p className='text-xl'>{leadInfo?.email || 'N/A'}</p>
            </div>
          </div>
          <LeadStep
            leadStage={leadInfo?.stage}
            subStage={leadInfo?.subStage}
            country={leadInfo?.applicationCountry}
          />
        </div>
        {showRemarks && <SendMail email={leadInfo?.email} />}
        <div className='grid grid-cols-1 gap-[32px] bg-gray-50 p-[24px]'>
          <InfoCard heading='PERSONAL INFORMATION' icon={<FaUser />}>
            <div className='grid grid-cols-1 gap-4 md:grid-cols-2'>
              {titleAndValue('Full Name', leadInfo?.fullName || 'N/A')}
              {titleAndValue('Email Address', leadInfo?.email || 'N/A')}
              {titleAndValue('Phone', leadInfo?.phoneNo || 'N/A')}
              {titleAndValue('Substage', leadInfo?.subStage || 'N/A')}
            </div>
          </InfoCard>
        </div>
        {/* Content */}
        <div className='grid grid-cols-1 gap-[32px] bg-gray-50 p-[24px] md:grid-cols-2'>
          <InfoCard
            heading='LAST EDUCATIONAL INFORMATION'
            icon={<FaGraduationCap />}
          >
            <div className='grid grid-cols-1 gap-4 md:grid-cols-2'>
              {leadInfo?.lastEducation ? (
                <>
                  {titleAndValue(
                    'Last Education',
                    leadInfo?.lastEducation?.degree ?? 'N/A'
                  )}
                  {titleAndValue(
                    'Passing year',
                    leadInfo?.lastEducation?.year ?? 'N/A'
                  )}
                  {titleAndValue(
                    'Result',
                    leadInfo?.lastEducation?.result ?? 'N/A'
                  )}
                  {titleAndValue(
                    'Institute',
                    leadInfo?.lastEducation?.institute ?? 'N/A'
                  )}
                  {titleAndValue(
                    'Country',
                    leadInfo?.lastEducation?.country ?? 'N/A'
                  )}
                </>
              ) : (
                'N/A'
              )}
            </div>
          </InfoCard>

          <InfoCard heading='PREVIOUS EDUCATION' icon={<FaBook />}>
            <div className='space-y-4'>
              {leadInfo?.previousEducations &&
              leadInfo?.previousEducations?.length > 0
                ? leadInfo.previousEducations.map(
                    (education: any, index: number) => (
                      <div
                        key={index}
                        className='grid grid-cols-1 gap-2 border-b pb-2 md:grid-cols-2'
                      >
                        {titleAndValue(
                          'Qualification',
                          education?.name ?? 'N/A'
                        )}
                        {titleAndValue(
                          'Passing Year',
                          education?.year ?? 'N/A'
                        )}
                        {titleAndValue('Result', education?.result ?? 'N/A')}
                      </div>
                    )
                  )
                : 'No previous education data available'}
            </div>
          </InfoCard>

          <InfoCard heading='ENGLISH PROFICIENCY' icon={<FaLanguage />}>
            <div className='grid grid-cols-1 gap-4 md:grid-cols-2'>
              {titleAndValue(
                'English Proficiency',
                leadInfo?.englishProficiency ?? 'N/A'
              )}
              {leadInfo?.englishProficiency === 'IELTS' ||
              leadInfo?.englishProficiency === 'PTE' ||
              leadInfo?.englishProficiency === 'OIETC' ||
              leadInfo?.englishProficiency === 'TOEFL' ? (
                <>
                  {titleAndValue(
                    'Reading',
                    leadInfo?.englishProficiencyResult?.reading ?? 'N/A'
                  )}
                  {titleAndValue(
                    'Writing',
                    leadInfo?.englishProficiencyResult?.writing ?? 'N/A'
                  )}
                  {titleAndValue(
                    'Speaking',
                    leadInfo?.englishProficiencyResult?.speaking ?? 'N/A'
                  )}
                  {titleAndValue(
                    'Listening',
                    leadInfo?.englishProficiencyResult?.listening ?? 'N/A'
                  )}
                  {titleAndValue(
                    'Overall',
                    leadInfo?.englishProficiencyResult?.overall ?? 'N/A'
                  )}
                </>
              ) : leadInfo?.englishProficiency === 'Duolingo' ? (
                <>
                  {titleAndValue(
                    'Literacy',
                    leadInfo?.englishProficiencyResult?.literacy ?? 'N/A'
                  )}
                  {titleAndValue(
                    'Comprehension',
                    leadInfo?.englishProficiencyResult?.comprehension ?? 'N/A'
                  )}
                  {titleAndValue(
                    'Conversation',
                    leadInfo?.englishProficiencyResult?.conversation ?? 'N/A'
                  )}
                  {titleAndValue(
                    'Production',
                    leadInfo?.englishProficiencyResult?.production ?? 'N/A'
                  )}
                  {titleAndValue(
                    'Overall',
                    leadInfo?.englishProficiencyResult?.overall ?? 'N/A'
                  )}
                </>
              ) : (
                titleAndValue(
                  'Score',
                  leadInfo?.englishProficiencyResult?.singleScore ?? 'N/A'
                )
              )}
            </div>
          </InfoCard>

          <InfoCard heading='ADDRESS' icon={<FaMapMarkerAlt />}>
            <div className='grid grid-cols-1 gap-4 md:grid-cols-2'>
              {titleAndValue('Country', leadInfo?.country ?? 'N/A')}
              {titleAndValue('State', leadInfo?.state ?? 'N/A')}
              {titleAndValue('Address', leadInfo?.addressDetails ?? 'N/A')}
            </div>
          </InfoCard>

          <InfoCard heading='PURPOSE' icon={<FaBullseye />}>
            <div className='grid grid-cols-1 gap-4 md:grid-cols-2'>
              {titleAndValue('Purpose', leadInfo?.purpose ?? 'N/A')}
              {titleAndValue('Stage', leadInfo?.stage ?? 'N/A')}
              {leadInfo?.stage &&
                titleAndValue('Sub-stage', leadInfo?.subStage ?? 'N/A')}
            </div>
          </InfoCard>

          <InfoCard heading='DOCUMENTS' icon={<FaFileAlt />}>
            <DocumentTable
              data={leadInfo?.leadDocs}
              leadId={leadInfo?.id}
              refetch={refetch}
            />
          </InfoCard>

          {leadInfo?.leadApplications &&
            leadInfo?.leadApplications.length > 0 && (
              <InfoCard
                heading='APPLICATIONS'
                icon={<FaClipboardList />}
                className='md:col-span-2'
              >
                <ApplicationTable
                  data={leadInfo?.leadApplications}
                  refetch={refetch}
                />
              </InfoCard>
            )}

          {leadInfo?.applicationCountry && (
            <InfoCard
              heading='VISA'
              icon={<FaCcVisa />}
              className='md:col-span-2'
            >
              <VisaTable
                leadId={leadInfo?.id}
                country={leadInfo?.applicationCountry}
                stage={leadInfo?.stage}
                subStage={leadInfo?.subStage}
                refetch={refetch}
              />
            </InfoCard>
          )}

          {showRemarks && (
            <InfoCard
              heading='REMARKS'
              icon={<FaComments />}
              className='md:col-span-2'
            >
              <RemarkTable data={leadInfo?.remarks} />
            </InfoCard>
          )}
        </div>
      </div>
    </motion.div>
  );
};
