// import { PERMISSIONS_KEY } from '@/common/decorator/roles.decorator';
import { Permission } from '@/common/enums/permission.enum';
import { CanActivate, ExecutionContext, Injectable } from '@nestjs/common';
import { Reflector } from '@nestjs/core';

@Injectable()
export class RbacGuard implements CanActivate {
  constructor(private reflector: Reflector) {}

  canActivate(context: ExecutionContext): boolean {
    const requiredPermissions = this.reflector.getAllAndOverride<Permission[]>(
      'PERMISSIONS_KEY',
      [context.getHandler(), context.getClass()],
    );
    if (!requiredPermissions) {
      return true;
    }

    const { user } = context.switchToHttp().getRequest();
    const listOfUserPerms = this.createPermissionList(user);
    console.log(listOfUserPerms);
    console.log(requiredPermissions);
    return requiredPermissions.some((perms) =>
      listOfUserPerms?.includes(perms),
    );
    // return true;
  }
  createPermissionList(user: any) {
    const permissionStringlist = [];
    console.log(user);
    for (const obj of user.role.permissions) {
      const str = obj.name;
      permissionStringlist.push(str);
    }
    return permissionStringlist;
  }
}
