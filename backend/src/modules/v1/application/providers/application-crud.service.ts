import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Application } from '../entity/application.entity';
import { CreateApplicationDto, UpdateApplicationDto } from '../dtos';
import { UniversityCrudService } from '../../university/providers';

import { Lead } from '../../lead/entity';

@Injectable()
export class ApplicationCrudService {
  constructor(
    @InjectRepository(Application)
    private readonly applicationRepository: Repository<Application>,
    @InjectRepository(Lead)
    private readonly leadRepository: Repository<Lead>,
    private readonly universityService: UniversityCrudService,
  ) {}

  async create(
    createApplicationDto: CreateApplicationDto,
  ): Promise<Application> {
    const university = await this.universityService.findOne(
      createApplicationDto.universityId,
    );
    if (!university) {
      throw new NotFoundException();
    }
    const application = this.applicationRepository.create(createApplicationDto);
    application.university = university;
    await this.applicationRepository.save(application);
    return application;
  }

  async findAll(): Promise<Application[]> {
    return await this.applicationRepository.find({
      relations: {
        lead: true,
        university: true,
      },
      order: {
        createdAt: 'DESC',
      },
    });
  }

  async findById(id: number): Promise<Application> {
    const application = await this.applicationRepository.findOne({
      where: { id },
      relations: {
        lead: true,
        university: true,
      },
    });
    if (!application) {
      throw new NotFoundException('application not found');
    }
    return application;
  }

  async update(
    id: number,
    updateApplicationDto: UpdateApplicationDto,
  ): Promise<Application> {
    const application = await this.findById(id);
    if (!application) {
      throw new NotFoundException(`Application with ${id} not found`);
    }
    if (
      (application.applicationStatus !== 'accepted' &&
        updateApplicationDto.applicationStatus === 'accepted') ||
      (application.applicationStatus !== 'applied' &&
        updateApplicationDto.applicationStatus === 'applied')
    ) {
      const lead = await this.leadRepository.findOne({
        where: { id: application.lead.id },
      });
      if (!lead.applicationCountry) {
        if (updateApplicationDto.applicationStatus === 'accepted') {
          lead.applicationCountry = application.university.country;
          lead.subStage = 'offer-received';
        }
        if (updateApplicationDto.applicationStatus === 'applied') {
          lead.subStage = 'applied';
        }
        await this.leadRepository.save(lead);
      }
    }
    this.applicationRepository.merge(application, updateApplicationDto);
    if (updateApplicationDto.universityId) {
      const university = await this.universityService.findOne(
        updateApplicationDto.universityId,
      );
      if (!university) {
        throw new NotFoundException();
      }
      application.university = university;
    }
    return await this.applicationRepository.save(application);
  }

  async delete(id: number): Promise<Application> {
    const application = await this.findById(id);
    if (application) {
      await this.applicationRepository.remove(application);
      return application;
    } else return null;
  }
}
