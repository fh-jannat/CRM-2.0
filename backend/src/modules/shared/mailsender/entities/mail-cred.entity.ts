import { AbstractEntity } from '@/common/entities';
import { Column, Entity } from 'typeorm';

@Entity('mail_cred')
export class MailCred extends AbstractEntity<MailCred> {
  @Column({ name: 'smtp_host' })
  smtpHost: string;

  @Column({ name: 'smtp_port' })
  smtpPort: string;

  @Column({ name: 'smtp_from', nullable: true })
  smtpFrom: string;

  @Column({ name: 'smtp_user' })
  smtpUser: string;

  @Column({ name: 'smtp_password' })
  smtpPassword: string;
}
