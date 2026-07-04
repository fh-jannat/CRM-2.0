import { Entity, JoinColumn, ManyToOne, Relation, Column } from 'typeorm';
import { Lead } from '../../lead/entity';
import { AbstractEntity } from '@/common/entities';

@Entity('lead_document')
export class LeadDocument extends AbstractEntity<LeadDocument> {
  @Column({ name: 'document_name', nullable: true })
  docName: string;

  @Column({ name: 'document_link', nullable: true })
  link: string;

  @ManyToOne(() => Lead, (lead) => lead.leadDocs, { nullable: true })
  @JoinColumn()
  lead: Relation<Lead>;
}
