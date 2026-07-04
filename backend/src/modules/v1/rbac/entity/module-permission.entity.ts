import {
  Column,
  Entity,
  PrimaryGeneratedColumn,
  CreateDateColumn,
  UpdateDateColumn,
  DeleteDateColumn,
  ManyToOne,
} from 'typeorm';
import { SystemModule } from './sysmodule.entity';
import { Permission } from './permission.entity';

@Entity('module_permission')
export class ModulePermission {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ name: 'name', nullable: false })
  name: string;

  @ManyToOne(() => SystemModule)
  module: SystemModule;

  @ManyToOne(() => Permission)
  permission: Permission;

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
}
