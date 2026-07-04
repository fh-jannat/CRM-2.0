import { AbstractEntity } from '@/common/entities';
import { Column, Entity } from 'typeorm';

@Entity('metacridential')
export class Facebook extends AbstractEntity<Facebook> {
  @Column({ name: 'app_id', nullable: true })
  appId: string;

  @Column({ name: 'app_secret', nullable: true })
  appSecret: string;

  @Column({ name: 'page_id', nullable: true })
  pageId: string;

  @Column({ name: 'page_access_token', nullable: true })
  pageAccessToken: string;
}
