import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { ILike, Repository } from 'typeorm';
import { Branch } from '../entities/branch.entity';
import { CreateBranchDto, UpdateBranchDto, DynamicDto } from '../dtos';

@Injectable()
export class BranchCrudService {
  constructor(
    @InjectRepository(Branch)
    private branchRepository: Repository<Branch>,
  ) {}

  async count(queryParams: DynamicDto): Promise<number> {
    const { where = {} } = queryParams?.query || {};
    const count = await this.branchRepository.count({ where });
    return count;
  }

  async options() {
    const options = await this.branchRepository.find({
      select: {
        id: true,
        branch: true,
      },
    });

    return options.map((option) => {
      return {
        value: option.branch,
        label: option.branch,
      };
    });
  }

  async create(createBranchDto: CreateBranchDto): Promise<Branch> {
    const university = this.branchRepository.create({
      branch: createBranchDto.branch,
      details: createBranchDto.details,
    });
    return this.branchRepository.save(university);
  }

  async findAll(queryParams: DynamicDto): Promise<Branch[]> {
    const {
      select = {},
      where = {},
      relations = {},
      page = 1,
      limit = 10,
    } = queryParams?.query || {};
    const skip = ((page > 1 ? page : 1) - 1) * (limit > 0 ? limit : 1);
    const whereClause = {};
    if (where) {
      Object.keys(where).forEach((key) => {
        if (key == 'branch') whereClause[key] = ILike(`${where[key]}`);
      });
    }
    return this.branchRepository.find({
      select: select,
      where: whereClause,
      relations: relations,
      skip: skip,
      take: limit,
      order: { createdAt: 'DESC' },
    });
  }

  async findOne(id: number, queryParams?: DynamicDto): Promise<Branch> {
    const {
      select = {},
      where = {},
      relations = {},
    } = queryParams?.query || {};
    return this.branchRepository.findOne({
      select: select,
      where: { id: id, ...where },
      relations: relations,
    });
  }
  async update(
    id: number,
    updateUniversityDto: UpdateBranchDto,
  ): Promise<Branch> {
    const remerk = await this.findOne(id);
    this.branchRepository.merge(remerk, updateUniversityDto);
    return this.branchRepository.save(remerk);
  }

  async remove(id: number): Promise<Branch> {
    const remerk = await this.findOne(id);
    await this.branchRepository.remove(remerk);
    return remerk;
  }
}
