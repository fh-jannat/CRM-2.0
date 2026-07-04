import { AbstractEntity } from '@/common/entities';
import { User } from '@/entities';

import { Column, Entity, ManyToOne } from 'typeorm';

@Entity('activity_event')
export class ActivityEvent extends AbstractEntity<ActivityEvent> {
  @Column({ name: 'event_id' })
  eventId: number;

  @Column({ name: 'details' })
  details: string;

  @ManyToOne(() => User)
  user: User;

  @Column({ name: 'branch' })
  branch: string;

  @Column({ name: 'role', nullable: true })
  role: string;
}
