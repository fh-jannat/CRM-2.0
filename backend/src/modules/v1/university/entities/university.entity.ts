import { AbstractEntity } from '@/common/entities';
import { Column, Entity, OneToMany, Relation } from 'typeorm';
import { Application } from '../../application/entity';

@Entity('university')
export class University extends AbstractEntity<University> {
  @Column({ name: 'university_name', nullable: false })
  universityName: string;

  @Column({ name: 'country', nullable: false })
  country: string;

  @OneToMany(() => Application, (app) => app.university)
  applications: Relation<Application[]>;
}
