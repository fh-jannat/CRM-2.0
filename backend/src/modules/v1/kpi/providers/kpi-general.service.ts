import { Injectable } from '@nestjs/common';

import { LeadCrudService, LeadGeneralService } from '../../lead/providers';
import { StatusChangeService } from '../../status-change/providers';

@Injectable()
export class KpiGeneralService {
  constructor(
    private readonly leadService: LeadCrudService,
    private readonly leadGenService: LeadGeneralService,
    private readonly statusChangeService: StatusChangeService,
  ) {}

  // Define E_STAGE enumeration if not already defined
  // enum E_STAGE {
  //   LEAD = 'LEAD',
  //   POTENTIAL = 'POTENTIAL',
  //   ADMISSION = 'ADMISSION',
  //   COMPLIANCE = 'COMPLIANCE',
  // }

  // Arrays for each stage
  LEAD_STAGES = [
    'new',
    'first',
    'second',
    'third',
    'final-call',
    'unreachable',
    'not-interested',
    'future-interest',
  ];

  POTENTIAL_STAGES = [
    'appointment-book',
    'document-received',
    'postponed',
    'waiting-for-document',
    'cancel',
  ];

  ADMISSION_STAGES = [
    'applied',
    'waiting-for-offer',
    'offer-received',
    'offer',
    'paid',
    'visa-start',
    'add-document',
    'start-application',
    'end-application',
    'first-interview',
    'first-payment',
    'unconditional-offer',
    'final-payment',
  ];

  COMPLIANCE_STAGES = [
    'final-choice',
    'gte',
    'i20-requested',
    'i20-received',
    'gs-interview',
    'pal-received',
    'compliance-interview',
    'coe-requested',
    'coe-received',
    'cas-requested',
    'cas-received',
    'visa-application',
    'visa-interview',
    'visa',
    'refused',
    'not-enrolled',
    'archive',
  ];

  async getCompanyWideLeadInfo() {
    const totalLeads = await this.leadService.count({ query: {} });
    console.log(totalLeads);
    const successLeads = await this.leadService.count({
      query: {
        where: {
          subStage: 'enrolled',
        },
      },
    });

    let conversionRate = successLeads / totalLeads;
    conversionRate = Number(
      (Math.round(conversionRate * 100) / 100).toFixed(2),
    );

    return {
      conversionRate,
      totalLeads,
      successLeads,
    };
  }
  async getConversionTrends(query: any) {
    let branch;

    const queryParam = JSON.parse(query?.query ?? '{}');
    if (queryParam?.branch) branch = queryParam['branch'];

    const leadGeneration =
      await this.leadGenService.groupLeadGenerationByLast12Months(branch);
    const leadSuccess =
      await this.leadGenService.groupLeadSpecificStatusByLast12Months(
        'enrolled',
        branch,
      );
    return {
      generated: leadGeneration,
      successful: leadSuccess,
    };
  }
  async getStageWiseLeadCounts(query: any) {
    const queryParam = query?.query ?? {};

    const stages = [
      { name: 'Lead', status: this.LEAD_STAGES },
      { name: 'Potential', status: this.POTENTIAL_STAGES },
      { name: 'Admission', status: this.ADMISSION_STAGES },
      { name: 'Compliance', status: this.COMPLIANCE_STAGES },
      { name: 'Success', status: ['enrolled'] },
    ];

    const counts = await Promise.all(
      stages.map(async (stage) => {
        queryParam['finalStatus'] = stage.status;
        const count = await this.statusChangeService.count(queryParam);
        return { name: stage.name, count };
      }),
    );

    return counts;
  }
}
