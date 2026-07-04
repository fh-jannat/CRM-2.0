import { User } from '@/entities';

class eventStructure {
  details: string;
  user: User;
  branch: string;
  role: string;
}

export class EventTriggeredEvent {
  constructor(
    public readonly eventId: number,
    public readonly payload: eventStructure,
  ) {}
}
