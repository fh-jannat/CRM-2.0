import { AbstractEntity } from '@/common/entities';
import { Column, Entity } from 'typeorm';

@Entity()
export class Notification extends AbstractEntity<Notification> {
  @Column()
  userId: number;

  @Column()
  message: string;

  @Column({ default: false })
  isRead: boolean;

  @Column({ nullable: true })
  url: string;
}
