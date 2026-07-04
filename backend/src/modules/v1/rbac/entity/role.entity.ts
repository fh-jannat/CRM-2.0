import {
  Column,
  CreateDateColumn,
  DeleteDateColumn,
  Entity,
  OneToMany,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';
import { RolePermission } from '.';
import { User } from '../../user/entity';

@Entity('role')
export class Role {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  name: string;

  @OneToMany(() => RolePermission, (permission) => permission.role)
  permissions: RolePermission[];

  @CreateDateColumn({ type: 'timestamp without time zone', name: 'created_at' })
  public createdAt: Date;

  @UpdateDateColumn({ type: 'timestamp without time zone', name: 'updated_at' })
  public updatedAt: Date;

  @DeleteDateColumn({
    type: 'timestamp without time zone',
    name: 'deleted_at',
    nullable: true,
  })
  public deletedAt: Date;

  @OneToMany(() => User, (user) => user.role)
  users: User[];
}
