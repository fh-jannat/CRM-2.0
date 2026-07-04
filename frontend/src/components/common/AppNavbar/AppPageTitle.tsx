import { usePathname } from 'next/navigation';
import React from 'react';

const AppPageTitle: React.FC = () => {
  const pathname = usePathname();

  const getPageHeading = () => {
    switch (pathname) {
      case '/dashboard':
        return 'Dashboard';
      case '/leads':
        return 'All Leads';
      case '/new-leads':
        return 'New Leads';
      case '/pendingtask':
        return 'PendingDocs';
      case '/metacridential':
        return 'Meta Cridential';
      case '/third-contact':
        return 'Third Contact';
      case '/application':
        return 'Application';
      case '/universities':
        return 'Universities';
      case '/activities':
        return 'Activities';
      case '/users':
        return 'User Management';
      case '/1st-contact':
        return 'First Contact';
      case '/2nd-contact':
        return 'Second Contact';
      case '/3rd-contact':
        return 'Third Contact';
      case '/final-call':
        return 'Final Call';
      case '/cold':
        return 'Cold';
      case '/dead':
        return 'Dead';
      case '/appointment-book':
        return 'Appointment-book Leads';
      case '/waiting-for-documents':
        return 'Waiting-for-documents Leads';
      case '/partial-documents':
        return 'Partial-documents Leads';
      case '/document-received':
        return 'Document-received Leads';
      case '/applied':
        return 'Applied Leads';
      case '/waiting-conditional-offer':
        return 'Waiting-for-conditional-offer-issued Leads';
      case '/waiting-unconditional-offer':
        return 'Waiting-for-unconditional-offer-issued Leads';
      case '/payment-expected':
        return 'Payment-expected Leads';
      case '/paid':
        return 'Paid Leads';
      case '/waiting-for-cas':
        return 'Waiting-for-cas Leads';
      case '/interview-in-process':
        return 'Interview in process Leads';
      case '/cas-or-final-confirmation':
        return 'Cas or final confirmation offered issued Leads';
      case '/applied-for-visa':
        return 'Applied for visa Leads';
      case '/visa-issued':
        return 'Visa Issued Leads';
      case '/enrolled':
        return 'Enrolled Leads';
      case '/refund':
        return 'Refund Leads';
      case '/withdrawn':
        return 'Withdrawn Leads';
      case '/notifications':
        return 'Notifications';
      default:
        return '';
    }
  };

  return (
    <div className='font-Inter text-[24px] font-bold leading-[30px] text-primaryColor'>
      {getPageHeading()}
    </div>
  );
};

export default AppPageTitle;
