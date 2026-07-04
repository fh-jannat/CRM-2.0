export enum E_PURPOSE {
  COURSES = 'courses',
  STUDY_ABROAD = 'study-abroad',
}

export enum E_STAGE {
  LEAD = 'lead',
  POTENTIAL = 'potential',
  ADMISSION = 'admission',
  COMPLIANCE = 'compliance',
  ENROLLED = 'enrolled',
  NOT_ENROLLED = 'not-enrolled',
  COURSE_LEAD = 'course-lead',
  NON_POTENTIAL = 'non-potential',
}

export enum E_SUBSTAGE {
  NEW = 'new',
  FIRST = 'first',
  SECOND = 'second',
  EXTENDED = 'third',
  FINAL_CALL = 'final-call',
  UNREACHABLE = 'unreachable',
  NOT_INTERESTED = 'not-interested',
  FUTURE_INTEREST = 'future-interest',

  APPOINTMENT_BOOK = 'appointment-book',
  DOCUMENT_RECEIVED = 'document-received',
  POSTPONED = 'postponed',
  CANCEL = 'cancel',

  APPLIED = 'applied',
  WAITING_FOR_OFFER = 'waiting-for-offer',
  OFFER_RECEIVED = 'offer-received',
  PAID = 'paid',
  VISA_START = 'visa-start',
  WAITING_FOR_DOCUMENT = 'waiting-for-document',
  ADD_DOCUMENT = 'add-document',
  START_APPLICATION = 'start-application',
  END_APPLICATION = 'end-application',

  // visa
  OFFER = 'offer',
  UNCONDITIONAL_OFFER = 'unconditional-offer',
  FINAL_CHOICE = 'final-choice',
  GTE = 'gte',
  I20_REQUESTED = 'i20-requested',
  I20_RECEIVED = 'i20-received',
  FIRST_INTERVIEW = 'first-interview',
  FIRST_PAYMENT = 'first-payment',
  GS_INTERVIEW = 'gs-interview',
  PAL_RECEIVED = 'pal-received',
  COMPLIANCE_INTERVIEW = 'compliance-interview',
  COE_REQUESTED = 'coe-requested',
  COE_RECEIVED = 'coe-received',
  CAS_REQUESTED = 'cas-requested',
  CAS_RECEIVED = 'cas-received',
  VISA_APPLICATION = 'visa-application',
  VISA_INTERVIEW = 'visa-interview',
  VISA = 'visa',
  REFUSED = 'refused',
  ENROLLED = 'enrolled',
  NOT_ENROLLED = 'not-enrolled',
  FINAL_PAYMENT = 'final-payment',
  ARCHIVE = 'archive',

  // course
  COURSE_NEW = 'course-new',
  COURSE_FIRST = 'course-first',
  COURSE_SECOND = 'course-second',
  COURSE_FINAL_CALL = 'course-final-call',
  COURSE_UNREACHABLE = 'course-unreachable',
  COURSE_NOT_INTERESTED = 'course-not-interested',
  IELTS_FIRST_TRACK = 'ielts-first-track',
  IELTS_GENERAL = 'ielts-general',
  IELTS_EXTENDED = 'ielts-extended',
  PTE_FIRST_TRACK = 'pte-first-track',
  PTE_GENERAL = 'pte-general',
  PTE_EXTENDED = 'pte-extended',
  EXAM = 'exam',
  MOCK = 'mock',
  PASS = 'pass',
  FAIL = 'fail',
}

export enum E_COURSE_STAGE {
  ENROLLED = 'enrolled',
  NOT_ENROLLED = 'not-enrolled',
  COURSE_LEAD = 'course-lead',
}

export enum E_COURSE_SUBSTAGE {
  COURSE_NEW = 'course-new',
  COURSE_FIRST = 'course-first',
  COURSE_SECOND = 'course-second',
  COURSE_FINAL_CALL = 'course-final-call',
  COURSE_UNREACHABLE = 'course-unreachable',
  COURSE_NOT_INTERESTED = 'course-not-interested',
  FIRST_TRACK = 'first-track',
  GENERAL = 'general',
  COURSE_EXTENDED = 'course-extended',
  EXAM = 'exam',
  MOCK = 'mock',
  PASS = 'pass',
  FAIL = 'fail',
}

export enum E_DESIRED_COURSE {
  NONE = '',
  IELTS_ACADEMIC = 'ielts-academic',
  IELTS_GENERAL = 'ielts-general',
  PTE = 'pte',
  OET = 'oet',
  CAMBRIDGE_ENGLISH = 'cambridge-english',
  TOEFL = 'toefl',
  SPOKEN = 'spoken',
  ENGLISH_FOUNDATION = 'english-foundation',
  DUOLINGO = 'duolingo',
  OIETC = 'oietc',
  SAT = 'sat',
  GRE = 'gre',
}

export enum E_ENGLISH_PROFICIENCY {
  NA = 'na',
  IELTS_ACADEMIC = 'ielts_academic',
  IELTS_GENERAL = 'ielts_general',
  DUOLINGO = 'duolingo',
  MOI = 'moi',
  OIETC = 'oietc',
  PTE = 'pte',
  INTERNAL_TEST = 'internal_test',
  OTHERS = 'others',
}

export enum E_SOURCE {
  LINKEDIN = 'linkedin',
  META = 'meta',
  WEBSITE = 'website',
  GOOGLE = 'google',
  REFERRAL = 'referral',
  INTERNAL = 'internal',
}

export enum E_PASSPORT {
  NONE = '',
  YES = 'yes',
  NO = 'No',
}

export enum E_DESTINATION {
  NONE = '',
  AUSTRALIA = 'australia',
  CANADA = 'canada',
  SWEDEN = 'sweden',
  USA = 'usa',
  UK = 'uk',
  OTHERS = 'others',
}

export enum E_UNIVERSITY {
  NONE = '',
  MIT = 'mit',
  OXFORD = 'oxford',
  HARVARD = 'harvard',
  CAMBRIDGE = 'cambridge',
  STANFORD = 'stanford',
  OTHERS = 'others',
}

export enum E_FILTER_STATUS {
  NONE = '',
  APPLIED = 'mit',
  PAID = 'oxford',
  VISA = 'harvard',
  ENROLLED = 'cambridge',
}

export enum E_USER {
  NONE = '',
  NORMAL_USER = 'normal user',
  ADMIN = 'admin',
  MANAGER = 'manager',
  CUSTOMER_SUPPORT = 'customer support',
}

export enum E_COUNSELLOR {
  UNASSIGNED = 'unassigned',
  SRABONTI_COUNSELLOR = 'srabonti_counsellor',
  SHARMIN_SULTANA_RIKTA_COUNSELLOR = 'sharmin_sultana_rikta_counsellor',
  FARZANA_FIROZ_ANTARA_COUNSELLOR = 'farzana_firoz_antara_counsellor',
  MD_KAMRUL_HASAN_SUJON_COUNSELLOR = 'md_kamrul_hasan_sujon_counsellor',
  SADIA_SULTANA_FLORINA_CRO = 'sadia_sultana_florina_cro',
}

export enum E_EDUCATION {
  PHD = 'phd',
  MBA = 'mba',
  MASTERS = 'masters',
  BACHELORS = 'bachelors',
  DIPLOMA = 'diploma',
  HSC = 'hsc',
  SSC = 'ssc',
  A_LEVELS = 'a_levels',
  O_LEVELS = 'o_levels',
}

export enum E_CATEGORY {
  LEADS = 'leads',
  STUDENT = 'student',
  ADMITTED = 'admitted',
}

export enum E_SUB_CATEGORY {
  NEW_LEADS = 'new_leads',
  FIRST_CONTACT = '1st_contact',
  SECOND_CONTACT = '2nd_contact',
  THIRD_CONTACT = '3rd_contact',
  FINAL_CALL = 'final_call',
  DOCUMENTS_SUBMITTED = 'documents_submitted',
  OFFER_RECEIVED = 'offer_received',
  VISA_APPLIED = 'visa_applied',
  ENROLLED = 'enrolled',
}
