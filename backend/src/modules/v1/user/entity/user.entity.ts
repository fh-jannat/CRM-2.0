import { AbstractEntity } from '@/common/entities/abstract.entity';

import { Column, Entity, OneToMany } from 'typeorm';
import { Exclude } from 'class-transformer';
import { Lead } from '../../lead/entity';
import { Role } from '@/modules/enums/role.enum';
import { Branch } from '@/modules/enums/branch.enum';
import { Remark } from '../../remark/entities';
import { Task } from '../../task/entities';

@Entity('users')
export class User extends AbstractEntity<User> {
  @Column({ name: 'full_name' })
  fullName: string;

  @Column({ name: 'email', unique: true })
  email: string;

  @Column({ name: 'password' })
  @Exclude()
  password: string;

  @Column({ name: 'status', default: 'active' })
  status: string;

  @Column({ name: 'is_verified', default: false })
  isVerified: boolean;

  @Column({ name: 'phone_number', nullable: true })
  phoneNumber: string;

  @Exclude()
  @Column({ name: 'otp', nullable: true })
  otp: string;

  @Column({ name: 'provider', nullable: true })
  provider: string;

  @Column({
    name: 'branch_name',
    default: Branch.DHANMONDI,
    nullable: true,
  })
  branchName: string;

  @Column({
    name: 'role',
    type: 'simple-array',
    enum: Role,
    default: [Role.USER],
  })
  role: Role[];

  @OneToMany(() => Lead, (lead) => lead.assigned)
  leads: Lead[];

  @OneToMany(() => Remark, (remark) => remark.assigned)
  remarks: Remark[];

  @OneToMany(() => Task, (task) => task.assigned)
  tasks: Task[];
}
