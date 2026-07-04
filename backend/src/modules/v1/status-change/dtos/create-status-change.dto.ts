import { Lead } from '../../lead/entity';
import { User } from '../../user/entity';

export class CreateStatusChangeDto {
  initialStatus: string;
  finalStatus: string;
  initator: User;
  branchName: string;
  lead: Lead;
}
