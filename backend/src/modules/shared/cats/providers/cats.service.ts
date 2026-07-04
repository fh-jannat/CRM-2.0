import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CreateCatDto } from '../dto/create-cat.dto';
import { UpdateCatDto } from '../dto/update-cat.dto';
import { Cat } from '../entities/cat.entity';

@Injectable()
export class CatsService {
  constructor(
    @InjectRepository(Cat)
    private readonly catRepository: Repository<Cat>,
  ) {}

  async create(createCatDto: CreateCatDto): Promise<Cat> {
    const cat = this.catRepository.create(createCatDto);
    return await this.catRepository.save(cat);
  }

  async createBulk(createCatDtos: CreateCatDto[]): Promise<Cat[]> {
    const createdCats: Cat[] = [];
    for (const createCatDto of createCatDtos) {
      const cat = await this.create(createCatDto);
      createdCats.push(cat);
    }
    return createdCats;
  }

  async findAll(): Promise<Cat[]> {
    return await this.catRepository.find();
  }

  async findOne(id: number): Promise<Cat> {
    return await this.catRepository.findOne({ where: { id } });
  }

  async update(id: number, updateCatDto: UpdateCatDto): Promise<Cat> {
    const cat = await this.catRepository.findOne({ where: { id } });
    if (!cat) {
      return null; // Cat not found
    }
    this.catRepository.merge(cat, updateCatDto);
    return await this.catRepository.save(cat);
  }

  async remove(id: number): Promise<boolean> {
    const result = await this.catRepository.delete(id);
    return result.affected > 0;
  }
}
