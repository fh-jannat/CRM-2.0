import { Entity, JoinColumn, ManyToOne, Relation, Column } from 'typeorm';
import { University } from '../../university/entities/university.entity';
import { Lead } from '../../lead/entity';
import { AbstractEntity } from '@/common/entities';

@Entity('application')
export class Application extends AbstractEntity<Application> {
  @Column({ name: 'course_label', nullable: true })
  courseLabel: string;

  @Column({ name: 'application_status', nullable: true, default: 'pending' })
  applicationStatus: string;

  @Column({ name: 'intake_year', nullable: true })
  intakeYear: string;

  @Column({ name: 'intake_month', nullable: true })
  intakeMonth: string;

  @Column({ name: 'course_details', nullable: true })
  courseDetails: string;

  @ManyToOne(() => University, (university) => university.applications, {
    nullable: true,
  })
  @JoinColumn()
  university: Relation<University>;

  @ManyToOne(() => Lead, (lead) => lead.leadApplications, { nullable: true })
  @JoinColumn()
  lead: Relation<Lead>;
}
