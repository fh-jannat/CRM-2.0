import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { LeadDocument } from '../entity';
import { CreateLeadDocumentDto, UpdateLeadDocumentDto } from '../dtos';

@Injectable()
export class LeadDocumentCrudService {
  constructor(
    @InjectRepository(LeadDocument)
    private readonly leadDocumentRepository: Repository<LeadDocument>,
  ) {}

  async create(application: CreateLeadDocumentDto): Promise<LeadDocument> {
    const leadDocument = this.leadDocumentRepository.create(application);
    return await this.leadDocumentRepository.save(leadDocument);
  }

  async findAll(): Promise<LeadDocument[]> {
    return await this.leadDocumentRepository.find({
      relations: {
        lead: true,
      },
      order: {
        createdAt: 'DESC',
      },
    });
  }

  async findById(id: number): Promise<LeadDocument> {
    const application = await this.leadDocumentRepository.findOne({
      where: { id },
      relations: {
        lead: true,
      },
    });
    if (!application) {
      throw new NotFoundException('application not found');
    }
    return application;
  }

  async update(
    id: number,
    updateApplicationDto: UpdateLeadDocumentDto,
  ): Promise<LeadDocument> {
    console.log(updateApplicationDto);
    return await this.findById(id);
  }

  async delete(id: number): Promise<LeadDocument> {
    const application = await this.findById(id);
    if (application) {
      await this.leadDocumentRepository.remove(application);
      return application;
    } else return null;
  }
}
