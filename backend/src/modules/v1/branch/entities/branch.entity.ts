import { AbstractEntity } from '@/common/entities';
import { Column, Entity } from 'typeorm';

@Entity('branch')
export class Branch extends AbstractEntity<Branch> {
  @Column({ name: 'details', nullable: true })
  details: string;

  @Column({ name: 'branch', nullable: true })
  branch: string;
}
