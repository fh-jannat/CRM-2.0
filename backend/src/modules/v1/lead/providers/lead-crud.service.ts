import {
  ConflictException,
  Inject,
  Injectable,
  NotFoundException,
  forwardRef,
} from '@nestjs/common';

import * as ExcelJS from 'exceljs';
import * as fs from 'fs';

import { InjectRepository } from '@nestjs/typeorm';
import { ILike, Repository } from 'typeorm';
import { Lead } from '../entity/lead.entity';
import { CreateLeadDto, UpdateLeadDto } from '../dtos';
import { DynamicDto } from '../dtos/dynamic.dto';
import { UserCurdService } from '../../user/providers';
import { LeadDocumentCrudService } from '../../leadDocument/providers';
import { CreateLeadDocumentDto } from '../dtos/create-lead-document.dto';
import { CreateLeadApplicationDto } from '../dtos/create-lead-application.dto';
import { ApplicationCrudService } from '../../application/providers';
import { EventTriggeredEvent } from '@/modules/shared/event/dtos/event-triggered.event';

import { Role } from '@/modules/enums/role.enum';
import { RemarkCrudService } from '../../remark/providers';
import { RealtimeService } from '@/modules/shared/realtime/realtime.service';
import { NotificationGeneralService } from '../../notification/providers';
import { User } from '../../user/entity';
import { StatusChangeService } from '../../status-change/providers';
import { EventHandlerService } from '@/modules/shared/event/event.service';
import { ACTIVITY } from '@/modules/enums/event.enum';
import { UpdateLeadStage } from '../dtos/update-lead-stage.dto';

export type WrapperType<T> = T;

@Injectable()
export class LeadCrudService {
  constructor(
    @InjectRepository(Lead)
    private readonly leadRepository: Repository<Lead>,
    @Inject(forwardRef(() => UserCurdService))
    private readonly userService: WrapperType<UserCurdService>,
    private readonly leadDocumentService: LeadDocumentCrudService,
    private readonly applicationService: ApplicationCrudService,
    private readonly remarkService: RemarkCrudService,
    private readonly realTimeService: RealtimeService,
    private readonly notificationService: NotificationGeneralService,
    private readonly statusChangeService: StatusChangeService,
    private readonly eventService: EventHandlerService,
  ) {}

  private async createDocuments(
    lead: Lead,
    createLeadDocumentDtos: CreateLeadDocumentDto[],
  ) {
    const documents = await Promise.all(
      createLeadDocumentDtos?.map(async (createLeadDocumentDto) => {
        if (createLeadDocumentDto.id)
          return await this.leadDocumentService.update(
            createLeadDocumentDto.id,
            createLeadDocumentDto,
          );
        else
          return await this.leadDocumentService.create(createLeadDocumentDto);
      }),
    );
    lead.leadDocs = documents;
    // await this.leadRepository.save(lead);
  }

  private async createApplications(
    lead: Lead,
    createApplicationDtos: CreateLeadApplicationDto[],
  ) {
    const applications = await Promise.all(
      createApplicationDtos?.map(async (createApplicationDto) => {
        if (createApplicationDto.id)
          return await this.applicationService.update(
            createApplicationDto.id,
            createApplicationDto,
          );
        else return await this.applicationService.create(createApplicationDto);
      }),
    );
    console.log(applications);
    lead.leadApplications = applications;
    // await this.leadRepository.save(lead);
  }

  async create(createLeadDto: CreateLeadDto, user): Promise<Lead> {
    const existingLead = await this.leadRepository.findOne({
      where: { email: createLeadDto.email },
    });
    if (existingLead) {
      throw new ConflictException('Lead with this email already exists.');
    }
    const lead = this.leadRepository.create(createLeadDto);
    await this.leadRepository.save(lead);
    if (!createLeadDto.stage) {
      lead.stage = 'lead';
    }
    if (!createLeadDto.subStage) {
      lead.subStage = 'new';
    }
    if (!createLeadDto.source) {
      lead.source = 'internal';
    }
    if (!createLeadDto.purpose) {
      lead.purpose = 'study-abroad';
    }
    if (!lead.assigned) {
      lead.assigned = user;
    }

    if (user?.role.includes(Role.ADMIN) || user?.role.includes(Role.MANAGER)) {
      const assigned = await this.userService.findById(
        createLeadDto.assignedTo,
      );
      lead.assigned = assigned;

      lead.branchName = assigned?.branchName;
    } else {
      lead.assigned = user;
      lead.branchName = user?.branchName;
    }

    if (createLeadDto.documents && createLeadDto.documents.length > 0) {
      await this.createDocuments(lead, createLeadDto.documents);
    }
    if (createLeadDto.applications && createLeadDto.applications.length > 0) {
      await this.createApplications(lead, createLeadDto.applications);
    }
    await this.leadRepository.save(lead);
    await this.remarkService.create({
      remark: `Lead created by ${user.fullName}`,
      lead,
      assigned: user,
      previousStep: '-',
      currentStep: 'start',
    });
    await this.statusChangeService.create({
      initialStatus: '-',
      finalStatus: 'new',
      branchName: user.branchName,
      initator: user,
      lead: lead,
    });
    this.eventService.createActivity(
      new EventTriggeredEvent(ACTIVITY.LEAD_CREATE, {
        user: user,
        branch: user.branchName,
        details: 'Lead created',
        role: user.role[0],
      }),
    );

    return lead;
  }

  async uploadCSV(files: Array<Express.Multer.File>, user) {
    try {
      const data = await this.convertCsvToJson('./' + files[0].path);

      const results = await Promise.allSettled(
        data.map((entry) => this.create(entry, user)),
      );

      const errors = results.filter((result) => {
        return result.status === 'rejected';
      });

      if (errors.length) {
        errors.forEach((error) => console.log(error.reason));
      }

      return {
        message: `File uploaded and data saved. ${errors.length ? 'Some entries might have failed.' : ''}`,
        statusCode: errors.length ? 'partial success' : 'success',
      };
    } catch (error) {
      // console.log(error);
      return {
        message: error.message,
        statusCode: 'error',
      };
    } finally {
      fs.unlinkSync('./' + files[0].path);
    }
  }

  private async detectDelimiter(filePath: string): Promise<string> {
    const fileContent = fs.readFileSync(filePath);
    return fileContent.includes('\t') ? '\t' : ',';
  }

  private async convertCsvToJson(filePath: string): Promise<any[]> {
    const workbook = new ExcelJS.Workbook();

    const delimiter = await this.detectDelimiter(filePath);
    console.log({ delimiter });

    await workbook.csv.readFile(filePath, {
      parserOptions: { delimiter },
    });

    const worksheet = workbook.worksheets[0];
    const data = [];

    worksheet.eachRow((row, rowNumber) => {
      if (rowNumber > 1) {
        const hasData = row?.getCell(2)?.value || row?.getCell(3)?.value;
        if (!hasData) return;
        const rowData = {
          fullName: row.getCell(1).value,
          email: row.getCell(2).value,
          phoneNo: row.getCell(3).value,
          country: row.getCell(4).value,
          state: row.getCell(5).value,
          addressDetails: row.getCell(6).value,
          stage: 'lead',
          subStage: 'new',
          source: 'internal',
          purpose: 'study-abroad',
        };
        data.push(rowData);
      }
    });

    return data;
  }

  async resendEmail(leadId: number) {
    const lead = await this.leadRepository.findOne({ where: { id: leadId } });
    if (!lead) {
      throw new NotFoundException('Lead not found');
    }
    try {
      await this.userService.resendAuthMail({
        fullName: lead.fullName,
        email: lead.email,
        role: [Role.STUDENT],
        branchName: lead.branchName,
      });
    } catch (error) {
      console.log(error);
    } finally {
      lead.hasAccount = true;
    }
    return lead;
  }

  async save(lead: Lead): Promise<Lead> {
    return await this.leadRepository.save(lead);
  }

  async count(queryParams: DynamicDto, user?: User): Promise<number> {
    const { where = {} } = queryParams?.query || {};
    const whereBuilder = {};
    for (const key in where) {
      if (key == 'fullName' && where['fullName'] !== '') {
        whereBuilder[key] = ILike(`%${where[key]}%`);
      }
      if (key == 'email' && where['email'] !== '') {
        whereBuilder[key] = ILike(`%${where[key]}%`);
      }
      if (key == 'phoneNo' && where['phoneNo'] !== '') {
        whereBuilder[key] = ILike(`%${where[key]}%`);
      }
      if (key == 'stage' && where['stage'] !== '') {
        whereBuilder[key] = where[key];
      }
      if (key == 'subStage' && where['subStage'] !== '') {
        whereBuilder[key] = where[key];
      }
      if (key == 'purpose' && where['purpose'] !== '') {
        whereBuilder[key] = where[key];
      }
      if (key == 'applicationCountry' && where['applicationCountry'] !== '') {
        whereBuilder[key] = where[key];
      }
      if (key == 'counsellor' && where['counsellor'] !== '') {
        whereBuilder['assigned'] = {};
        whereBuilder['assigned'].fullName = ILike(`%${where[key]}%`);
      }
    }
    if (user) {
      if (
        !user.role?.includes(Role.ADMIN) &&
        !user.role?.includes(Role.MANAGER)
      ) {
        whereBuilder['assigned'] = {};
        whereBuilder['assigned'].id = user.id;
      }
      if (
        user.role?.includes(Role.MANAGER) &&
        !user.role?.includes(Role.ADMIN)
      ) {
        whereBuilder['branchName'] = user.branchName;
      }
    }
    const count = await this.leadRepository.count({ where: whereBuilder });
    return count;
  }

  async findAll(queryParams: DynamicDto, user: User): Promise<Lead[]> {
    // const { pageNo = 1, pageSize = 10, where = {} } = queryParams?.query || {};
    const {
      where = {},
      relations = {},
      page = 1,
      limit = 10,
    } = queryParams?.query || {};
    const skip = ((page > 1 ? page : 1) - 1) * (limit > 0 ? limit : 1);
    const whereBuilder = {};
    for (const key in where) {
      if (key == 'fullName' && where['fullName'] !== '') {
        whereBuilder[key] = ILike(`%${where[key]}%`);
      }
      if (key == 'email' && where['email'] !== '') {
        whereBuilder[key] = ILike(`%${where[key]}%`);
      }
      if (key == 'phoneNo' && where['phoneNo'] !== '') {
        whereBuilder[key] = ILike(`%${where[key]}%`);
      }
      if (key == 'stage' && where['stage'] !== '') {
        whereBuilder[key] = where[key];
      }
      if (key == 'subStage' && where['subStage'] !== '') {
        whereBuilder[key] = where[key];
      }
      if (key == 'purpose' && where['purpose'] !== '') {
        whereBuilder[key] = where[key];
      }
      if (key == 'applicationCountry' && where['applicationCountry'] !== '') {
        whereBuilder[key] = where[key];
      }
      if (key == 'interestedCountry' && where['interestedCountry'] !== '') {
        whereBuilder[key] = where[key];
      }
      if (key == 'counsellor' && where['counsellor'] !== '') {
        whereBuilder['assigned'] = {};
        whereBuilder['assigned'].fullName = ILike(`%${where[key]}%`);
      }
    }
    if (user) {
      if (
        !user.role?.includes(Role.ADMIN) &&
        !user.role?.includes(Role.MANAGER)
      ) {
        whereBuilder['assigned'] = {};
        whereBuilder['assigned'].id = user.id;
      }
      if (
        user.role?.includes(Role.MANAGER) &&
        !user.role?.includes(Role.ADMIN)
      ) {
        whereBuilder['branchName'] = user.branchName;
      }
    }
    const leads = await this.leadRepository.find({
      where: whereBuilder,
      relations: {
        leadApplications: true,
        assigned: true,
        leadDocs: true,
        ...relations,
      },
      skip: skip,
      take: limit,
      order: {
        createdAt: 'DESC',
      },
    });
    return leads;
  }

  async findById(id: number, queryParams?: DynamicDto): Promise<Lead> {
    const {
      select = {},
      where = {},
      relations = {},
    } = queryParams?.query || {};
    const lead = await this.leadRepository.findOne({
      select: select,
      where: { id: id, ...where },
      relations: relations,
    });
    if (!lead) {
      throw new NotFoundException('lead not found');
    }
    return lead;
  }

  async leadDetailsForStudent(user?: User): Promise<Lead> {
    const lead = await this.leadRepository.findOne({
      where: { email: user.email },
      relations: {
        leadApplications: {
          university: true,
        },
        assigned: true,
        leadDocs: true,
        remarks: true,
      },
    });
    if (!lead) {
      throw new NotFoundException('lead not found');
    }
    return lead;
  }

  async updateStageSubstage(id: number, updateStageDto: UpdateLeadStage) {
    const lead = await this.leadRepository.findOne({
      where: { id: id },
    });
    if (!lead) {
      throw new NotFoundException('Lead not found');
    }
    if (updateStageDto.stage) {
      lead.stage = updateStageDto.stage;
    }
    if (updateStageDto.subStage) {
      lead.subStage = updateStageDto.subStage;
    }
    await this.leadRepository.save(lead);
    return lead;
  }

  async update(
    id: number,
    updateLeadDto: UpdateLeadDto,
    user: any,
  ): Promise<Lead> {
    const lead = await this.findById(id, {
      query: { relations: { assigned: true } },
    });
    if (updateLeadDto.email && updateLeadDto.email !== lead.email) {
      const existingEmailLead = await this.leadRepository.findOne({
        where: { email: updateLeadDto.email },
      });
      if (existingEmailLead)
        throw new ConflictException('Email already exists');
    }
    if (updateLeadDto.assignedTo) {
      if (lead.assigned.id === updateLeadDto.assignedTo) {
      } else {
        const assignedUser = await this.userService.findById(
          updateLeadDto.assignedTo,
        );
        lead.branchName = assignedUser.branchName;
        lead.assigned = assignedUser;
        const notificationUrl =
          lead.stage === 'lead'
            ? `lead-create/${lead.id}`
            : `lead-details/${lead.id}`;
        await this.notificationService.createNotification(
          assignedUser.id,
          `${user.fullName} assigned you a new lead`,
          notificationUrl,
        );
        this.eventService.createActivity(
          new EventTriggeredEvent(ACTIVITY.LEAD_ASSIGN, {
            user: user,
            branch: user.branchName,
            details: `Lead ${lead.id} assigned to ${assignedUser.fullName}`,
            role: user.role[0],
          }),
        );
        await this.realTimeService.sendMessage(
          assignedUser.id,
          'Assigned to new lead',
        );
      }
    }
    if (updateLeadDto.documents && updateLeadDto.documents.length > 0) {
      await this.createDocuments(lead, updateLeadDto.documents);
    }
    if (updateLeadDto.applications && updateLeadDto.applications.length > 0) {
      await this.createApplications(lead, updateLeadDto.applications);
    }
    if (updateLeadDto.subStage === 'appointment-book') {
      updateLeadDto.stage = 'potential';
    }
    if (updateLeadDto.subStage === 'document-received') {
      updateLeadDto.stage = 'admission';
      updateLeadDto.subStage = 'start-application';
      // updateLeadDto.stage = 'potential';
      // updateLeadDto.subStage = 'waiting-for-document';
      try {
        await this.userService.create({
          fullName: lead.fullName,
          email: lead.email,
          role: [Role.STUDENT],
          branchName: lead.branchName,
        });
      } catch (error) {
        console.log(error);
      } finally {
        lead.hasAccount = true;
      }
    }
    const updatedLeadDto = { ...lead, ...updateLeadDto };
    delete updatedLeadDto.assignedTo;
    const remark = await this.remarkService.create({
      remark: updateLeadDto.remark || `Lead updated by ${user.fullName}`,
      lead,
      assigned: user,
      previousStep: lead.subStage,
      currentStep: updateLeadDto.subStage || lead.subStage,
    });
    updatedLeadDto.lastRemark = remark.remark;
    this.eventService.createActivity(
      new EventTriggeredEvent(ACTIVITY.REMARK, {
        user: user,
        branch: user.branchName,
        details:
          'remark : ' +
          (updateLeadDto.remark ||
            `Lead ${lead.id} updated by ${user.fullName}`),
        role: user.role[0],
      }),
    );
    if (lead.subStage != updatedLeadDto.subStage) {
      await this.statusChangeService.create({
        initialStatus: lead.subStage,
        finalStatus: updatedLeadDto.subStage,
        branchName: user.branchName,
        initator: user,
        lead: lead,
      });
      this.eventService.createActivity(
        new EventTriggeredEvent(ACTIVITY.STATUS_CHANGE, {
          user: user,
          branch: user.branchName,
          details:
            'Status changed ' +
            `from ${lead.subStage} to ${updatedLeadDto.subStage} of lead ${lead.id} by ${user.fullName}`,
          role: user.role[0],
        }),
      );
    }

    await this.leadRepository.save(updatedLeadDto);

    return lead;
  }

  async delete(id: number): Promise<Lead> {
    const lead = await this.findById(id);
    if (lead) {
      await this.leadRepository.softDelete(id);
      return lead;
    } else return null;
  }

  async getLeadGraph() {
    const res = await this.leadRepository
      .createQueryBuilder('lead')
      .select('lead.sub_stage')
      .addSelect('COUNT(lead.id)')
      .groupBy('lead.sub_stage')
      .getRawMany();
    return res;
  }

  async getAdmissionData() {
    const res = await this.leadRepository
      .createQueryBuilder('lead')
      .select('lead.sub_stage')
      .addSelect('COUNT(lead.id)')
      .where('lead.stage = :status', { status: 'admission' })
      .groupBy('lead.sub_stage')
      .getRawMany();
    return res;
  }

  async getStudentData() {
    const res = await this.leadRepository
      .createQueryBuilder('lead')
      .select('lead.sub_stage')
      .addSelect('COUNT(lead.id)')
      .where('lead.sub_stage = :var1', { var1: 'waiting-for-document' })
      .orWhere('lead.sub_stage = :var2', { var2: 'document-received' })
      .groupBy('lead.sub_stage')
      .getRawMany();
    return res;
  }
}
