import { AbstractEntity } from '@/common/entities';
import { Column, Entity, ManyToOne, OneToMany, Relation } from 'typeorm';
import { Application } from '../../application/entity';
import { LeadDocument } from '../../leadDocument/entity';
import { User } from '../../user/entity';
import { Remark } from '../../remark/entities';

export interface LastEducationDto {
  degree: string;
  institute: string;
  country: string;
  year: string;
  result: string;
  month: string;
}

export interface EnglishProficiencyResult {
  writing?: string;
  reading?: string;
  speaking?: string;
  listening?: string;
  singleScore?: string;
}

export interface PrevEducationDto {
  name: string;
  year: number;
  result: number;
}

@Entity('lead')
export class Lead extends AbstractEntity<Lead> {
  // personal information
  @Column({ name: 'fullname', nullable: false })
  fullName: string;

  @Column({ name: 'email', nullable: false, unique: true })
  email: string;

  @Column({ name: 'phone_no', nullable: false })
  phoneNo: string;

  @Column({ name: 'country', nullable: true })
  country: string;

  @Column({ name: 'application_country', nullable: true })
  applicationCountry: string;

  @Column({ name: 'interested_country', nullable: true })
  interestedCountry: string;

  @Column({ name: 'state', nullable: true })
  state: string;

  @Column({ name: 'address_details', nullable: true })
  addressDetails: string;

  @Column({
    name: 'branch_name',
    nullable: true,
  })
  branchName: string;

  @Column({ name: 'previous_educations', type: 'simple-json', nullable: true })
  previousEducations: PrevEducationDto[];

  @Column({ name: 'last_education', type: 'json', nullable: true })
  lastEducation: LastEducationDto;

  @Column({ name: 'english_proficiency', nullable: true })
  englishProficiency: string;

  @Column({ type: 'jsonb', name: 'english_proficiency_result', nullable: true })
  englishProficiencyResult: EnglishProficiencyResult;

  @Column({ name: 'purpose', nullable: true })
  purpose: string;

  @Column({ name: 'stage', nullable: true })
  stage: string;

  @Column({ name: 'sub_stage', nullable: true })
  subStage: string;

  @Column({ name: 'source', nullable: true, default: 'others' })
  source: string;

  @Column({ name: 'has_account', nullable: false, default: false })
  hasAccount: boolean;

  @Column({ name: 'classes', type: 'jsonb', nullable: true })
  classes: boolean[] | null;

  @Column({ name: 'exams', type: 'jsonb', nullable: true })
  exams: boolean[] | null;

  @Column({ name: 'last_remark', nullable: true })
  lastRemark: string;

  @ManyToOne(() => User, { nullable: true })
  assigned: Relation<User>;

  @OneToMany(() => Remark, (remark) => remark.lead)
  remarks: Relation<Remark[]>;

  @OneToMany(() => LeadDocument, (docs) => docs.lead, { cascade: true })
  leadDocs: Relation<LeadDocument[]>;

  @OneToMany(() => Application, (app) => app.lead)
  leadApplications: Relation<Application[]>;
}
