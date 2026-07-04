import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { SystemModule } from '../entity/sysmodule.entity';
import { CreateSystemmoduleDto } from '../dtos/create-systemmodule.dto';
import { UpdateSystemmoduleDto } from '../dtos/update-systemmodule.dto';

@Injectable()
export class SystemModuleService {
  constructor(
    @InjectRepository(SystemModule)
    private readonly systemModuleRepo: Repository<SystemModule>,
  ) {}
  async create(createSystemmoduleDto: CreateSystemmoduleDto) {
    console.log(createSystemmoduleDto);
    return await this.systemModuleRepo.save(createSystemmoduleDto);
  }

  async findAll() {
    console.log('here');
    return await this.systemModuleRepo.find();
  }

  findOne(id: number) {
    return `This action returns a #${id} systemmodule`;
  }

  update(id: number, updateSystemmoduleDto: UpdateSystemmoduleDto) {
    console.log(updateSystemmoduleDto);
    return `This action updates a #${id} systemmodule`;
  }

  remove(id: number) {
    return `This action removes a #${id} systemmodule`;
  }
}
