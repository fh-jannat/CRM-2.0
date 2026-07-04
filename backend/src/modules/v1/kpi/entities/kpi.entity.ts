import { AbstractEntity } from '@/common/entities';
import { Entity } from 'typeorm';

@Entity('kpi')
export class Kpi extends AbstractEntity<Kpi> {}
