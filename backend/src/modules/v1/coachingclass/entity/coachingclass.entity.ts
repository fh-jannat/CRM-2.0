import { Column, Entity, ManyToOne, JoinColumn, Relation } from 'typeorm';
import { Lead } from '../../lead/entity';
import { AbstractEntity } from '@/common/entities';

@Entity('coachingclass')
export class Coachingclass extends AbstractEntity<Coachingclass> {
  @Column({ name: 'name', nullable: false })
  name: string;

  @Column({ name: 'c_type', nullable: true })
  c_type: string;

  @Column({ name: 'class_date', nullable: true })
  classDate: Date;

  @Column({ name: 'is_present', nullable: true, default: false })
  isPresent: boolean;

  @ManyToOne(() => Lead, { nullable: true })
  @JoinColumn()
  lead: Relation<Lead>;
}
