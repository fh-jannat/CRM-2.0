import { E_STAGE, E_SUBSTAGE, COUNTRY } from '@/enums';

export const getStatusOptions = (
  currentStage: E_STAGE,
  currentSubStage: E_SUBSTAGE,
  country?: string
) => {
  const options = [];

  switch (currentStage) {
    case E_STAGE.LEAD:
      if (currentSubStage === E_SUBSTAGE.NEW) {
        options.push({ label: '1st', value: E_SUBSTAGE.FIRST });
      } else if (currentSubStage === E_SUBSTAGE.FIRST) {
        options.push({ label: '2nd', value: E_SUBSTAGE.SECOND });
      } else if (currentSubStage === E_SUBSTAGE.SECOND) {
        options.push({ label: '3rd', value: E_SUBSTAGE.EXTENDED });
      } else if (currentSubStage === E_SUBSTAGE.EXTENDED) {
        options.push({ label: 'Final call', value: E_SUBSTAGE.FINAL_CALL });
      } else if (currentSubStage === E_SUBSTAGE.FUTURE_INTEREST) {
        options.push({ label: '1st', value: E_SUBSTAGE.FIRST });
      }
      if (
        currentSubStage !== E_SUBSTAGE.UNREACHABLE &&
        currentSubStage !== E_SUBSTAGE.NOT_INTERESTED &&
        currentSubStage !== E_SUBSTAGE.FUTURE_INTEREST
      ) {
        options.push({
          label: 'Not Interested',
          value: E_SUBSTAGE.NOT_INTERESTED,
        });
        options.push({ label: 'Unreachable', value: E_SUBSTAGE.UNREACHABLE });
        options.push({
          label: 'Future Interest',
          value: E_SUBSTAGE.FUTURE_INTEREST,
        });
        options.push({
          label: 'Appointment book',
          value: E_SUBSTAGE.APPOINTMENT_BOOK,
        });
        options.push({
          label: 'Waiting for Document',
          value: E_SUBSTAGE.WAITING_FOR_DOCUMENT,
        });
      }

      break;

    case E_STAGE.POTENTIAL:
      if (currentSubStage === E_SUBSTAGE.APPOINTMENT_BOOK) {
        options.push({
          label: 'Waiting for Document',
          value: E_SUBSTAGE.WAITING_FOR_DOCUMENT,
        });
        options.push({
          label: 'Postponed',
          value: E_SUBSTAGE.POSTPONED,
        });
        options.push({
          label: 'Cancel',
          value: E_SUBSTAGE.CANCEL,
        });
      } else if (currentSubStage === E_SUBSTAGE.WAITING_FOR_DOCUMENT) {
        options.push({
          label: 'Document Received',
          value: E_SUBSTAGE.DOCUMENT_RECEIVED,
        });
      } else if (currentSubStage === E_SUBSTAGE.CANCEL) {
        options.push({
          label: 'Appointment book',
          value: E_SUBSTAGE.APPOINTMENT_BOOK,
        });
      } else if (currentSubStage === E_SUBSTAGE.POSTPONED) {
        options.push({
          label: 'Appointment book',
          value: E_SUBSTAGE.APPOINTMENT_BOOK,
        });
      }
      break;

    case E_STAGE.ADMISSION:
      if (currentSubStage === E_SUBSTAGE.START_APPLICATION) {
        // options.push({ label: 'Applied', value: E_SUBSTAGE.APPLIED });
      } else if (currentSubStage === E_SUBSTAGE.APPLIED) {
        // options.push({
        //   label: 'Offer Received',
        //   value: E_SUBSTAGE.OFFER_RECEIVED,
        // });
      } else if (currentSubStage === E_SUBSTAGE.OFFER_RECEIVED) {
        options.push({ label: 'Offer', value: E_SUBSTAGE.OFFER });
        options.push({
          label: 'Unconditional Offer',
          value: E_SUBSTAGE.UNCONDITIONAL_OFFER,
        });
      } else if (
        currentSubStage === E_SUBSTAGE.OFFER ||
        currentSubStage === E_SUBSTAGE.UNCONDITIONAL_OFFER
      ) {
        if (country === COUNTRY.AUSTRALIA) {
          options.push({
            label: 'GTE',
            value: E_SUBSTAGE.GTE,
          });
        } else if (country === COUNTRY.EUROPE) {
          options.push({
            label: 'First Interview',
            value: E_SUBSTAGE.FIRST_INTERVIEW,
          });
        } else if (country === COUNTRY.NEWZEALAND) {
          options.push({
            label: 'End application',
            value: E_SUBSTAGE.END_APPLICATION,
          });
        } else {
          options.push({
            label: 'First Payment',
            value: E_SUBSTAGE.FIRST_PAYMENT,
          });
        }
      } else if (currentSubStage === E_SUBSTAGE.FIRST_INTERVIEW) {
        options.push({
          label: 'First Payment',
          value: E_SUBSTAGE.FIRST_PAYMENT,
        });
      } else if (currentSubStage === E_SUBSTAGE.GTE) {
        options.push({
          label: 'First Payment',
          value: E_SUBSTAGE.FIRST_PAYMENT,
        });
      } else if (currentSubStage === E_SUBSTAGE.FIRST_PAYMENT) {
        options.push({
          label: 'End application',
          value: E_SUBSTAGE.END_APPLICATION,
        });
      } else if (currentSubStage === E_SUBSTAGE.END_APPLICATION) {
        options.push({
          label: 'Final Choice',
          value: E_SUBSTAGE.FINAL_CHOICE,
        });
      }
      break;

    case E_STAGE.COMPLIANCE:
      if (currentSubStage === E_SUBSTAGE.FINAL_CHOICE) {
        if (country === COUNTRY.AUSTRALIA) {
          options.push({
            label: 'GS Interview',
            value: E_SUBSTAGE.GS_INTERVIEW,
          });
        } else if (country === COUNTRY.USA) {
          options.push({
            label: 'I20 Requested',
            value: E_SUBSTAGE.I20_REQUESTED,
          });
        } else if (country === COUNTRY.UK) {
          options.push({
            label: 'Compliance Interview',
            value: E_SUBSTAGE.COMPLIANCE_INTERVIEW,
          });
        } else if (country === COUNTRY.CANADA) {
          options.push({
            label: 'PAL Received',
            value: E_SUBSTAGE.PAL_RECEIVED,
          });
        } else {
          options.push({
            label: 'Visa applied',
            value: E_SUBSTAGE.VISA_APPLICATION,
          });
        }
      } else if (currentSubStage === E_SUBSTAGE.GS_INTERVIEW) {
        options.push({
          label: 'COE Requested',
          value: E_SUBSTAGE.COE_REQUESTED,
        });
      } else if (currentSubStage === E_SUBSTAGE.COE_REQUESTED) {
        options.push({
          label: 'COE Received',
          value: E_SUBSTAGE.COE_RECEIVED,
        });
      } else if (currentSubStage === E_SUBSTAGE.COE_RECEIVED) {
        options.push({
          label: 'Visa applied',
          value: E_SUBSTAGE.VISA_APPLICATION,
        });
      } else if (currentSubStage === E_SUBSTAGE.I20_REQUESTED) {
        options.push({
          label: 'I20 Received',
          value: E_SUBSTAGE.I20_RECEIVED,
        });
      } else if (currentSubStage === E_SUBSTAGE.I20_RECEIVED) {
        options.push({
          label: 'Visa applied',
          value: E_SUBSTAGE.VISA_APPLICATION,
        });
      } else if (currentSubStage === E_SUBSTAGE.COMPLIANCE_INTERVIEW) {
        options.push({
          label: 'CAS Requested',
          value: E_SUBSTAGE.CAS_REQUESTED,
        });
      } else if (currentSubStage === E_SUBSTAGE.CAS_REQUESTED) {
        options.push({ label: 'CAS Received', value: E_SUBSTAGE.CAS_RECEIVED });
      } else if (currentSubStage === E_SUBSTAGE.CAS_RECEIVED) {
        options.push({
          label: 'Visa applied',
          value: E_SUBSTAGE.VISA_APPLICATION,
        });
      } else if (currentSubStage === E_SUBSTAGE.PAL_RECEIVED) {
        options.push({
          label: 'Visa applied',
          value: E_SUBSTAGE.VISA_APPLICATION,
        });
      } else if (currentSubStage === E_SUBSTAGE.VISA_APPLICATION) {
        options.push({
          label: 'Visa Interview',
          value: E_SUBSTAGE.VISA_INTERVIEW,
        });
      } else if (currentSubStage === E_SUBSTAGE.VISA_INTERVIEW) {
        options.push({ label: 'Visa', value: E_SUBSTAGE.VISA });
        options.push({ label: 'Refused', value: E_SUBSTAGE.REFUSED });
      } else if (currentSubStage === E_SUBSTAGE.VISA) {
        if (
          country === COUNTRY.AUSTRALIA ||
          country === COUNTRY.USA ||
          country === COUNTRY.DENMARK ||
          country === COUNTRY.CANADA
        ) {
          options.push({ label: 'Enrolled', value: E_SUBSTAGE.ENROLLED });
          options.push({
            label: 'Not enrolled',
            value: E_SUBSTAGE.NOT_ENROLLED,
          });
        } else if (
          country === COUNTRY.EUROPE ||
          country === COUNTRY.NEWZEALAND ||
          country === COUNTRY.UAE ||
          country === COUNTRY.MALAYSIA ||
          country === COUNTRY.UK
        ) {
          options.push({
            label: 'Final Payment',
            value: E_SUBSTAGE.FINAL_PAYMENT,
          });
        }
      } else if (currentSubStage === E_SUBSTAGE.FINAL_PAYMENT) {
        options.push({ label: 'Enrolled', value: E_SUBSTAGE.ENROLLED });
        options.push({ label: 'Not enrolled', value: E_SUBSTAGE.NOT_ENROLLED });
      }
      break;
    case E_STAGE.COURSE_LEAD:
      if (currentSubStage === E_SUBSTAGE.COURSE_NEW) {
        options.push({ label: '1st', value: E_SUBSTAGE.COURSE_FIRST });
      } else if (currentSubStage === E_SUBSTAGE.COURSE_FIRST) {
        options.push({ label: '2nd', value: E_SUBSTAGE.COURSE_SECOND });
      } else if (currentSubStage === E_SUBSTAGE.COURSE_SECOND) {
        options.push({
          label: 'Final call',
          value: E_SUBSTAGE.COURSE_FINAL_CALL,
        });
      }
      if (currentSubStage !== E_SUBSTAGE.COURSE_FINAL_CALL) {
        options.push({
          label: 'Not Interested',
          value: E_SUBSTAGE.COURSE_NOT_INTERESTED,
        });
        options.push({
          label: 'Unreachable',
          value: E_SUBSTAGE.COURSE_UNREACHABLE,
        });
      }
      options.push({
        label: 'IELTS First track',
        value: E_SUBSTAGE.IELTS_FIRST_TRACK,
      });
      options.push({
        label: 'IELTS General',
        value: E_SUBSTAGE.IELTS_GENERAL,
      });
      options.push({
        label: 'IELTS Extended course',
        value: E_SUBSTAGE.IELTS_EXTENDED,
      });
      options.push({
        label: 'PTE First track',
        value: E_SUBSTAGE.PTE_FIRST_TRACK,
      });
      options.push({
        label: 'PTE General',
        value: E_SUBSTAGE.PTE_GENERAL,
      });
      options.push({
        label: 'PTE Extended course',
        value: E_SUBSTAGE.PTE_EXTENDED,
      });
      options.push({
        label: 'Exam',
        value: E_SUBSTAGE.EXAM,
      });
      options.push({
        label: 'Mock',
        value: E_SUBSTAGE.MOCK,
      });
      options.push({
        label: 'Not enrolled',
        value: E_SUBSTAGE.COURSE_NOT_INTERESTED,
      });
      break;
    case E_STAGE.ENROLLED:
      options.push({
        label: 'IELTS First track',
        value: E_SUBSTAGE.IELTS_FIRST_TRACK,
      });
      options.push({
        label: 'IELTS General',
        value: E_SUBSTAGE.IELTS_GENERAL,
      });
      options.push({
        label: 'IELTS Extended course',
        value: E_SUBSTAGE.IELTS_EXTENDED,
      });
      options.push({
        label: 'PTE First track',
        value: E_SUBSTAGE.PTE_FIRST_TRACK,
      });
      options.push({
        label: 'PTE General',
        value: E_SUBSTAGE.PTE_GENERAL,
      });
      options.push({
        label: 'PTE Extended course',
        value: E_SUBSTAGE.PTE_EXTENDED,
      });
      options.push({
        label: 'Exam',
        value: E_SUBSTAGE.EXAM,
      });
      options.push({
        label: 'Mock',
        value: E_SUBSTAGE.MOCK,
      });
      options.push({
        label: 'Pass',
        value: E_SUBSTAGE.PASS,
      });
      options.push({
        label: 'Fail',
        value: E_SUBSTAGE.FAIL,
      });
      break;
    case E_STAGE.NOT_ENROLLED:
      break;
    default:
      break;
  }

  return options;
};
