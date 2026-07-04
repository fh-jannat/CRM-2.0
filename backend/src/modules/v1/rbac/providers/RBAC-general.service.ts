import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';

import { Role, RolePermission, ModulePermission } from '../entity';
import { Permission } from '../entity/permission.entity';
import { SystemModule } from '../entity/sysmodule.entity';
import {
  AssignPermissionDto,
  AssignPermissionDto2,
} from '../dtos/assign-permission.dto';
import { CreateRoleDto } from '../dtos/create-role.dto';
import { UpdateRoleDto } from '../dtos/update-role.dto';
import { DynamicDto } from '../dtos/dynamic.dto';

@Injectable()
export class RBACGeneralService {
  constructor(
    @InjectRepository(Role) private readonly roleRepo: Repository<Role>,
    @InjectRepository(RolePermission)
    private readonly rpRepo: Repository<RolePermission>,
    @InjectRepository(Permission)
    private readonly permissionRepo: Repository<Permission>,
    @InjectRepository(SystemModule)
    private readonly systemRepo: Repository<SystemModule>,
    @InjectRepository(ModulePermission)
    private readonly mpRepo: Repository<ModulePermission>,
  ) {}

  async assignPermission(
    roleId: number,
    assignPermissionDto: AssignPermissionDto,
  ) {
    const role = await this.roleRepo.findOne({
      where: {
        id: roleId,
      },
    });
    // console.log('here');
    // console.log(assignPermissionDto);
    for (const pair of assignPermissionDto.pairs) {
      // console.log(pair);
      const module = await this.systemRepo.findOne({
        where: { id: pair.moduleId },
      });
      for (const i in pair.permissionIds) {
        const pId = pair.permissionIds[i];
        const permModule = await this.mpRepo.findOne({
          where: {
            permission: {
              id: pId,
            },
            module: {
              id: module.id,
            },
          },
        });

        // permArray.push(perm);
        const exisitng = await this.rpRepo.findOne({
          where: {
            permissionModule: {
              id: permModule.id,
            },
            role: {
              id: roleId,
            },
          },
        });

        if (exisitng) return;

        await this.rpRepo.save({
          role: role,
          permissionModule: permModule,
          name: permModule.name,
        });
      }
    }
  }
  async assignPermission2(
    roleId: number,
    assignPermissionDto: AssignPermissionDto2,
  ) {
    const obj = {
      roleId: roleId,
      pairs: [],
    };
    const readPerm = await this.permissionRepo.findOne({
      where: {
        name: 'READ',
      },
    });
    const writePerm = await this.permissionRepo.findOne({
      where: {
        name: 'WRITE',
      },
    });

    for (const i of assignPermissionDto.read) {
      obj.pairs.push({
        moduleId: i,
        permissionIds: [readPerm.id],
      });
    }
    for (const i of assignPermissionDto.write) {
      obj.pairs.push({
        moduleId: i,
        permissionIds: [writePerm.id],
      });
    }
    console.log(obj);
    await this.assignPermission(roleId, obj);
  }
  async init() {
    const systemModules = await this.systemRepo.find();
    const permissions = await this.permissionRepo.find();
    for (const module of systemModules) {
      for (const permission of permissions) {
        const instance = await this.mpRepo.findOne({
          where: {
            permission: {
              id: permission.id,
            },
            module: {
              id: module.id,
            },
          },
        });
        if (instance) return;

        await this.mpRepo.save({
          permission: permission,
          module: module,
          name: module.name + '-' + permission.name,
        });
      }
    }
  }

  async count() {
    return await this.roleRepo.count();
  }

  async create(createRoleDto: CreateRoleDto) {
    return await this.roleRepo.save(createRoleDto);
  }

  async findAllPairs() {
    return await this.mpRepo.find({
      relations: {
        permission: true,
        module: true,
      },
    });
  }

  async findAllPermissionsOfRole(roleId: number) {
    return await this.rpRepo.find({
      where: {
        role: {
          id: roleId,
        },
      },
      relations: {
        permissionModule: {
          permission: true,
          module: true,
        },
      },
    });
  }
  async findAll(queryParams: DynamicDto) {
    const {
      select = {},
      where = {},
      page = 1,
      limit = 10,
    } = queryParams?.query || {};
    const skip = ((page > 1 ? page : 1) - 1) * (limit > 0 ? limit : 1);
    console.log(select);
    return await this.roleRepo.find({
      select: select,
      where: where,
      skip: skip,
      take: limit,
      relations: {
        permissions: {
          permissionModule: {
            permission: true,
            module: true,
          },
        },
      },
    });
  }

  async findOne(id: number) {
    return await this.roleRepo.findOne({
      where: { id: id },
      relations: {
        permissions: {
          permissionModule: {
            permission: true,
            module: true,
          },
        },
      },
    });
  }
  async findOneByName(name: string) {
    return await this.roleRepo.findOne({ where: { name: name } });
  }

  async update(id: number, updateRoleDto: UpdateRoleDto) {
    console.log(updateRoleDto);
    return `This action updates a #${id} role`;
  }

  async remove(id: number) {
    return `This action removes a #${id} role`;
  }
}
