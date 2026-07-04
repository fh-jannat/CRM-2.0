import { Injectable, NotFoundException } from '@nestjs/common';
import { CreateFacebookDto } from './dto/create-facebook.dto';
import { UpdateFacebookDto } from './dto/update-facebook.dto';

import axios from 'axios';
import { Facebook } from './entities/facebook.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';

@Injectable()
export class FacebookService {
  constructor(
    @InjectRepository(Facebook)
    private facebookRepository: Repository<Facebook>,
  ) {}

  async getLeads(accessToken: string, adId: string) {
    const url = `https://graph.facebook.com/v20.0/${adId}/leadgen_forms?access_token=${accessToken}`;
    console.log(url);
    const res = await axios.get(url);
    // const res2 = await lastValueFrom(res);
    console.log(res.data);
    return res.data;
  }
  async create(createFacebookDto: CreateFacebookDto) {
    const facebook = this.facebookRepository.create(createFacebookDto);
    return await this.facebookRepository.save(facebook);
  }

  async count() {
    return this.facebookRepository.count();
  }

  async findAll() {
    return this.facebookRepository.find({ order: { createdAt: 'DESC' } });
  }

  async findOne(id: number) {
    return this.facebookRepository.findOne({ where: { id } });
  }

  async update(id: number, updateFacebookDto: UpdateFacebookDto) {
    const facebook = await this.facebookRepository.findOne({ where: { id } });
    if (!facebook) {
      throw new NotFoundException(`Facebook #${id} not found`);
    }
    this.facebookRepository.merge(facebook, updateFacebookDto);
    return this.facebookRepository.save(facebook);
  }

  remove(id: number) {
    return this.facebookRepository.softDelete(id);
  }
}
