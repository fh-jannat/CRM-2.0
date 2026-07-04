import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { ILike, Repository } from 'typeorm';
import { University } from '../entities/university.entity';
import {
  CreateUniversityDto,
  UpdateUniversityDto,
  CreateUniversitiesDto,
} from '../dtos';
import { DynamicDto } from '../dtos/dynamic.dto';

@Injectable()
export class UniversityCrudService {
  constructor(
    @InjectRepository(University)
    private universityRepository: Repository<University>,
  ) {}

  async count(queryParams: DynamicDto): Promise<number> {
    const { where = {} } = queryParams?.query || {};
    const count = await this.universityRepository.count({ where });
    return count;
  }

  async seed(
    createUniversitiesDto: CreateUniversitiesDto,
  ): Promise<University[]> {
    return this.universityRepository.save(createUniversitiesDto.universities);
  }

  async create(createUniversityDto: CreateUniversityDto): Promise<University> {
    const university = this.universityRepository.create(createUniversityDto);
    return this.universityRepository.save(university);
  }

  async options() {
    const options = await this.universityRepository.find({
      select: {
        id: true,
        universityName: true,
      },
    });

    return options.map((option) => {
      return {
        value: option.id,
        label: option.universityName,
      };
    });
  }

  async findAll(queryParams: DynamicDto): Promise<University[]> {
    const {
      select = {},
      where = {},
      relations = {},
      page = 1,
      limit = 10,
    } = queryParams?.query || {};
    const skip = ((page > 1 ? page : 1) - 1) * (limit > 0 ? limit : 1);
    const whereClause = {};
    Object.keys(where).forEach((key) => {
      if (key == 'universityName') {
        whereClause[key] = ILike(`%${where[key]}%`);
      }
      if (key == 'country') {
        whereClause[key] = ILike(`%${where[key]}%`);
      }
    });

    return this.universityRepository.find({
      select: select,
      where: whereClause,
      relations: relations,
      skip: skip,
      take: limit,
      order: {
        createdAt: 'DESC',
      },
    });
  }

  async findOne(id: number, queryParams?: DynamicDto): Promise<University> {
    const {
      select = {},
      where = {},
      relations = {},
    } = queryParams?.query || {};
    return this.universityRepository.findOne({
      select: select,
      where: { id: id, ...where },
      relations: relations,
    });
  }
  async update(
    id: number,
    updateUniversityDto: UpdateUniversityDto,
  ): Promise<University> {
    const university = await this.findOne(id);
    this.universityRepository.merge(university, updateUniversityDto);
    return this.universityRepository.save(university);
  }

  async remove(id: number): Promise<University> {
    const university = await this.findOne(id);
    await this.universityRepository.remove(university);
    return university;
  }
}
