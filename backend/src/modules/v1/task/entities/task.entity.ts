import { AbstractEntity } from '@/common/entities';
import { Column, Entity, ManyToOne, Relation } from 'typeorm';
import { User } from '../../user/entity';

@Entity('task')
export class Task extends AbstractEntity<Task> {
  @Column({ name: 'task', nullable: true })
  task: string;

  @Column({ name: 'description', nullable: true })
  description: string;

  @Column({ name: 'status', nullable: true })
  status: string;

  @Column({ name: 'start_date', nullable: true })
  startDate: Date;

  @Column({ name: 'end_date', nullable: true })
  endDate: Date;

  @ManyToOne(() => User, (user) => user.tasks, { nullable: true })
  assigned: Relation<User>;
}
