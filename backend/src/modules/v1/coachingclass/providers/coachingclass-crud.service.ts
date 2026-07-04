import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Coachingclass } from '../entity/coachingclass.entity';
import { CreateCoachingclassDto, UpdateCoachingclassDto } from '../dtos';
import { DynamicDto } from '../dtos/dynamic.dto';
import { LeadCrudService } from '../../lead/providers';

@Injectable()
export class CoachingclassCrudService {
  constructor(
    @InjectRepository(Coachingclass)
    private readonly coachingclassRepository: Repository<Coachingclass>,
    private readonly leadService: LeadCrudService,
  ) {}

  async create(coachingclass: CreateCoachingclassDto): Promise<Coachingclass> {
    const lead = await this.leadService.findById(coachingclass.leadId);
    if (!lead) {
      throw new NotFoundException('lead does not exist');
    }
    const tempClass = {
      classDate: coachingclass.classDate,
      isPresent: coachingclass?.isPresent,
      lead: lead,
      name: coachingclass.name,
      cType: coachingclass.cType,
    };
    const createdCoachingclass = this.coachingclassRepository.create(tempClass);
    return await this.coachingclassRepository.save(createdCoachingclass);
  }

  async findAll(queryParams: DynamicDto): Promise<Coachingclass[]> {
    const {
      select = {},
      where = {},
      page = 1,
      limit = 10,
    } = queryParams?.query || {};
    const skip = ((page > 1 ? page : 1) - 1) * (limit > 0 ? limit : 1);
    console.log(select, where, page, limit, skip);
    return await this.coachingclassRepository.find({});
  }

  async findById(id: number): Promise<Coachingclass> {
    const coachingclass = await this.coachingclassRepository.findOne({
      where: { id },
      relations: {
        lead: true,
      },
    });
    if (!coachingclass) {
      throw new NotFoundException('coachingclass not found');
    }
    return coachingclass;
  }

  async update(
    id: number,
    updateCoachingclassDto: UpdateCoachingclassDto,
  ): Promise<Coachingclass> {
    const coachingclass = await this.findById(id);

    const updatedCoachingclass = await this.coachingclassRepository.save({
      ...coachingclass,
      ...updateCoachingclassDto,
    });
    return updatedCoachingclass;
  }

  async delete(id: number): Promise<Coachingclass> {
    const coachingclass = await this.findById(id);
    if (coachingclass) {
      await this.coachingclassRepository.remove(coachingclass);
      return coachingclass;
    } else return null;
  }
}
