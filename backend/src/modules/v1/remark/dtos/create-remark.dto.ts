import { User } from '../../user/entity';
import { Lead } from '../../lead/entity';

export class CreateRemarkDto {
  previousStep: string;
  currentStep: string;
  remark: string;
  lead: Lead;
  assigned: User;
}
