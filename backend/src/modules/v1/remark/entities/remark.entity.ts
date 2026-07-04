import { AbstractEntity } from '@/common/entities';
import { Column, Entity, ManyToOne, Relation } from 'typeorm';
import { Lead } from '../../lead/entity';
import { User } from '../../user/entity';

@Entity('remark')
export class Remark extends AbstractEntity<Remark> {
  @Column({ name: 'previous_step', nullable: true })
  previousStep: string;

  @Column({ name: 'current_step', nullable: true })
  currentStep: string;

  @Column({ name: 'remark', nullable: true })
  remark: string;

  @ManyToOne(() => Lead, (lead) => lead.remarks, { nullable: true })
  lead: Relation<Lead>;

  @ManyToOne(() => User, (user) => user.remarks, { nullable: true })
  assigned: Relation<User>;
}
