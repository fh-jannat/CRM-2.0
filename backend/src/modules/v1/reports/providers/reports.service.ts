import { Injectable } from '@nestjs/common';

import { LeadCrudService } from '../../lead/providers';

@Injectable()
export class ReportsService {
  constructor(private leadService: LeadCrudService) {}
  async getLeadReport(queryParams: any) {
    console.log(queryParams);
    return this.leadService.getLeadGraph();
  }

  async getAdmissionReport(queryParams: any) {
    console.log(queryParams);
    return this.leadService.getAdmissionData();
  }

  async getStudentReport(queryParams: any) {
    console.log(queryParams);
    return this.leadService.getStudentData();
  }
}
