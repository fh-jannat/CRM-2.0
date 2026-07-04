// subStageMapping.ts

import { E_STAGE } from '@/common/enums/stage.enum';

export const SUB_STAGE_MAPPING: { [key: string]: E_STAGE } = {
  // Lead
  new: E_STAGE.LEAD,
  first: E_STAGE.LEAD,
  second: E_STAGE.LEAD,
  third: E_STAGE.LEAD,
  'final-call': E_STAGE.LEAD,
  unreachable: E_STAGE.LEAD,
  'not-interested': E_STAGE.LEAD,
  'future-interest': E_STAGE.LEAD,

  // Potential
  'appointment-book': E_STAGE.POTENTIAL,
  'document-received': E_STAGE.POTENTIAL,
  postponed: E_STAGE.POTENTIAL,
  'waiting-for-document': E_STAGE.POTENTIAL,
  cancel: E_STAGE.POTENTIAL,

  // Admission
  applied: E_STAGE.ADMISSION,
  'waiting-for-offer': E_STAGE.ADMISSION,
  'offer-received': E_STAGE.ADMISSION,
  offer: E_STAGE.ADMISSION,
  paid: E_STAGE.ADMISSION,
  'visa-start': E_STAGE.ADMISSION,
  'add-document': E_STAGE.ADMISSION,
  'start-application': E_STAGE.ADMISSION,
  'end-application': E_STAGE.ADMISSION,
  'first-interview': E_STAGE.ADMISSION,
  'first-payment': E_STAGE.ADMISSION,
  'unconditional-offer': E_STAGE.ADMISSION,
  'final-payment': E_STAGE.ADMISSION,

  // Compliance

  'final-choice': E_STAGE.COMPLIANCE,
  gte: E_STAGE.COMPLIANCE,
  'i20-requested': E_STAGE.COMPLIANCE,
  'i20-received': E_STAGE.COMPLIANCE,

  'gs-interview': E_STAGE.COMPLIANCE,
  'pal-received': E_STAGE.COMPLIANCE,
  'compliance-interview': E_STAGE.COMPLIANCE,
  'coe-requested': E_STAGE.COMPLIANCE,
  'coe-received': E_STAGE.COMPLIANCE,
  'cas-requested': E_STAGE.COMPLIANCE,
  'cas-received': E_STAGE.COMPLIANCE,
  'visa-application': E_STAGE.COMPLIANCE,
  'visa-interview': E_STAGE.COMPLIANCE,
  visa: E_STAGE.COMPLIANCE,
  refused: E_STAGE.COMPLIANCE,
  enrolled: E_STAGE.COMPLIANCE,
  'not-enrolled': E_STAGE.COMPLIANCE,

  archive: E_STAGE.COMPLIANCE,

  // Course Lead
  'course-new': E_STAGE.COURSE_LEAD,
  'course-first': E_STAGE.COURSE_LEAD,
  'course-second': E_STAGE.COURSE_LEAD,
  'course-final-call': E_STAGE.COURSE_LEAD,
  'course-unreachable': E_STAGE.COURSE_LEAD,
  'course-not-interested': E_STAGE.COURSE_LEAD,
  'ielts-first-track': E_STAGE.COURSE_LEAD,
  'ielts-general': E_STAGE.COURSE_LEAD,
  'ielts-extended': E_STAGE.COURSE_LEAD,
  'pte-first-track': E_STAGE.COURSE_LEAD,
  'pte-general': E_STAGE.COURSE_LEAD,
  'pte-extended': E_STAGE.COURSE_LEAD,
  exam: E_STAGE.COURSE_LEAD,
  mock: E_STAGE.COURSE_LEAD,
  pass: E_STAGE.COURSE_LEAD,
  fail: E_STAGE.COURSE_LEAD,
};
