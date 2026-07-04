import { User } from '../../user/entity';
import { Lead } from '../../lead/entity';

export class CreateKpiDto {
  previousStep: string;
  currentStep: string;
  kpi: string;
  lead: Lead;
  assigned: User;
}
