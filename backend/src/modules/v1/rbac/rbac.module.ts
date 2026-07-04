import { Module } from '@nestjs/common';
import { RolePermission } from './entity/role-permission.entity';
import { ModulePermission } from './entity/module-permission.entity';
import { SystemModule } from './entity/sysmodule.entity';
import { Role } from './entity/role.entity';
import { TypeOrmModule } from '@nestjs/typeorm';
import * as providers from './providers';
import * as controller from './controllers';
import { Permission } from './entity/permission.entity';
@Module({
  imports: [
    // MongooseModule.forFeature([{ name: User.name, schema: UserSchema }]),
    TypeOrmModule.forFeature([
      ModulePermission,
      SystemModule,
      Role,
      RolePermission,
      Permission,
    ]),
  ],
  providers: Object.values(providers),
  controllers: Object.values(controller),
  exports: [providers.RBACGeneralService],
})
export class RbacModule {}
