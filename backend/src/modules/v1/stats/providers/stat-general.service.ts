import { Injectable } from '@nestjs/common';
import { LeadCrudService } from '../../lead/providers';
import { DynamicDto } from '../dtos';

@Injectable()
export class StatGeneralService {
  constructor(private leadService: LeadCrudService) {}

  async prepStat() {
    let leadCount = 0;
    let complianceCount = 0;
    let admissionCount = 0;
    let studentCount = 0;
    const query = new DynamicDto();
    leadCount = await this.leadService.count(query);

    query['query'] = {
      where: {
        stage: 'compliance',
      },
    };
    complianceCount = await this.leadService.count(query);
    query['query'] = {
      where: {
        stage: 'admission',
      },
    };
    admissionCount = await this.leadService.count(query);
    query['query'] = {
      where: {
        stage: 'potential',
      },
    };
    studentCount = await this.leadService.count(query);
    leadCount = leadCount - admissionCount - studentCount - complianceCount;
    const response = {
      Lead: leadCount,
      Student: studentCount,
      Admission: admissionCount,
      'Visa Compliance': complianceCount,
    };
    return response;
  }
}
