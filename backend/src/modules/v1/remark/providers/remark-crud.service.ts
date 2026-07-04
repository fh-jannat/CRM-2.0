import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Remark } from '../entities/remark.entity';
import { CreateRemarkDto, UpdateRemarkDto, DynamicDto } from '../dtos';

@Injectable()
export class RemarkCrudService {
  constructor(
    @InjectRepository(Remark)
    private remarkRepository: Repository<Remark>,
  ) {}

  async count(queryParams: DynamicDto): Promise<number> {
    const { where = {} } = queryParams?.query || {};
    const count = await this.remarkRepository.count({ where });
    return count;
  }

  async create(createRemarkDto: CreateRemarkDto): Promise<Remark> {
    const university = this.remarkRepository.create({
      previousStep: createRemarkDto.previousStep,
      currentStep: createRemarkDto.currentStep,
      remark: createRemarkDto.remark,
      lead: createRemarkDto.lead,
      assigned: createRemarkDto.assigned,
    });
    return this.remarkRepository.save(university);
  }

  async findAll(queryParams: DynamicDto): Promise<Remark[]> {
    const {
      select = {},
      where = {},
      relations = {},
      page = 1,
      limit = 10,
    } = queryParams?.query || {};
    const skip = ((page > 1 ? page : 1) - 1) * (limit > 0 ? limit : 1);
    return this.remarkRepository.find({
      select: select,
      where: where,
      relations: relations,
      skip: skip,
      take: limit,
      order: { createdAt: 'DESC' },
    });
  }

  async findOne(id: number, queryParams?: DynamicDto): Promise<Remark> {
    const {
      select = {},
      where = {},
      relations = {},
    } = queryParams?.query || {};
    return this.remarkRepository.findOne({
      select: select,
      where: { id: id, ...where },
      relations: relations,
    });
  }
  async update(
    id: number,
    updateUniversityDto: UpdateRemarkDto,
  ): Promise<Remark> {
    const remerk = await this.findOne(id);
    this.remarkRepository.merge(remerk, updateUniversityDto);
    return this.remarkRepository.save(remerk);
  }

  async remove(id: number): Promise<Remark> {
    const remerk = await this.findOne(id);
    await this.remarkRepository.remove(remerk);
    return remerk;
  }
}
