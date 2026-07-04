import { AbstractEntity } from '@/common/entities';
import { Column, Entity } from 'typeorm';

@Entity('substagelabel')
export class SubStagelabel extends AbstractEntity<SubStagelabel> {
  @Column({ name: 'stage', nullable: true })
  stage: string;

  @Column({ name: 'substage', nullable: true })
  substage: string;

  @Column({ name: 'substagelabel', nullable: true })
  substageLabel: string;
}
