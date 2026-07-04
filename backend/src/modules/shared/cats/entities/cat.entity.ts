import { AbstractEntity } from '@/common/entities';
import { Column, Entity } from 'typeorm';

@Entity('cats')
export class Cat extends AbstractEntity<Cat> {
  @Column({ name: 'parent', nullable: true })
  parent: number;

  @Column({ name: 'label' })
  label: string;

  @Column({ name: 'value' })
  value: string;
}
