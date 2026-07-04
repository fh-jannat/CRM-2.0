import { AbstractEntity } from '@/common/entities';
import { Lead } from '../../lead/entity';
import { User } from '../../user/entity';
import { Column, Entity, ManyToOne, Relation } from 'typeorm';

@Entity('status_change')
export class StatusChange extends AbstractEntity<StatusChange> {
  @Column({ nullable: false })
  initialStatus: string;
  @Column({ nullable: false })
  finalStatus: string;

  @Column({ name: 'branch_name', nullable: true })
  branchName: string;

  @ManyToOne(() => Lead)
  lead: Relation<Lead>;

  @ManyToOne(() => User)
  initiator: Relation<User>;
}
