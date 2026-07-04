import { Injectable } from '@nestjs/common';
import { CreateStatusChangeDto } from '../dtos/create-status-change.dto';

import { InjectRepository } from '@nestjs/typeorm';
import { Repository, DataSource, In, MoreThanOrEqual } from 'typeorm';
import { StatusChange } from '../entity';
import { E_STAGE } from '@/common/enums/stage.enum';
import { SUB_STAGE_MAPPING } from '../status-mapping';
import { Lead } from '@/entities';

type SubStageInfo = {
  count: string;
  finalStatus: string;
};

type StageResult = {
  stage: E_STAGE;
  subStageInfo: SubStageInfo[];
};
@Injectable()
export class StatusChangeService {
  constructor(
    @InjectRepository(StatusChange)
    private readonly statusChangeRepo: Repository<StatusChange>,
    private dataSource: DataSource,
  ) {}
  async create(createStatusChangeDto: CreateStatusChangeDto) {
    const createdStatusChange = await this.statusChangeRepo.create({
      initialStatus: createStatusChangeDto.initialStatus,
      finalStatus: createStatusChangeDto.finalStatus,
      branchName: createStatusChangeDto.branchName,
      initiator: createStatusChangeDto.initator,
      lead: createStatusChangeDto.lead,
    });
    return await this.statusChangeRepo.save(createdStatusChange);
  }
  async count(queryParamLany: any) {
    const whereBuilder: any = {};
    let queryBuilder = this.statusChangeRepo
      .createQueryBuilder('sc')
      .select('COUNT(DISTINCT sc.leadId)', 'count');

    if (queryParamLany) {
      const { branch, dayInterval, finalStatus } = queryParamLany;

      // Build the whereBuilder object based on provided parameters
      if (branch) {
        queryBuilder = queryBuilder.where('sc.branch_name= :var1', {
          var1: branch,
        });
      }
      if (dayInterval) {
        const startDate = new Date();
        startDate.setDate(startDate.getDate() - parseInt(dayInterval, 10));
        whereBuilder['updatedAt'] = MoreThanOrEqual(startDate);
        queryBuilder = queryBuilder.andWhere('sc.updated_at >= :var2', {
          var2: startDate,
        });
      }
      if (finalStatus) {
        whereBuilder['final_status'] = In(finalStatus); // Adjust according to ORM used
        queryBuilder = queryBuilder.andWhere('sc.finalStatus IN (:...var3)', {
          var3: finalStatus,
        });
      }
    }

    const res = await queryBuilder.getRawOne();
    return res.count;
  }

  async findAll() {
    return this.statusChangeRepo.find({ order: { createdAt: 'DESC' } });
  }

  async findOne(id: number) {
    return this.statusChangeRepo.findOne({
      where: {
        id: id,
      },
    });
  }

  mapResultsToStages(results: SubStageInfo[]): StageResult[] {
    const stageMap: { [key in E_STAGE]?: SubStageInfo[] } = {};

    results.forEach((result) => {
      const stage = SUB_STAGE_MAPPING[result.finalStatus];
      if (stage) {
        if (!stageMap[stage]) {
          stageMap[stage] = [];
        }
        stageMap[stage]?.push(result);
      }
    });

    return Object.keys(stageMap).map((stage) => ({
      stage: stage as E_STAGE,
      subStageInfo: stageMap[stage as E_STAGE] || [],
    }));
  }

  async getSuccessCounts(queryParams: any) {
    queryParams = queryParams.query;
    const initiatorId = queryParams?.initiatorId;
    const startDate = queryParams?.startDate;
    const endDate = queryParams?.endDate;

    const query = this.statusChangeRepo
      .createQueryBuilder('sc')
      .leftJoin(Lead, 'lead', 'lead.id = sc.initiatorId')
      .where('lead.stage = :stage', { stage: 'admission' });

    if (initiatorId) {
      query.andWhere('sc.initiatorId = :initiatorId', { initiatorId });
    }

    if (startDate) {
      query.andWhere('sc.updatedAt >= :startDate', { startDate });
    }

    if (endDate) {
      query.andWhere('sc.updatedAt <= :endDate', { endDate });
    }

    query
      .groupBy('sc.initiatorId')
      .select('sc.initiatorId', 'initiatorId')
      .addSelect('COUNT(sc.initiatorId)', 'count');

    const result = await query.getRawMany();
    console.log(result);
    return result;
  }
  async getLastOccurringLeadId(queryParams: any) {
    queryParams = queryParams.query;
    console.log(queryParams);
    let startDate = queryParams?.startDate
      ? queryParams?.startDate
      : new Date('1990-01-01');
    let endDate = queryParams?.endDate ? queryParams?.endDate : new Date();
    console.log(startDate);
    console.log(endDate);
    const branchName = queryParams?.branchName;
    startDate = new Date(startDate);
    endDate = new Date(endDate);
    endDate.setDate(endDate.getDate() + 1);
    const initiatorId = queryParams?.initiatorId;

    const queryBuilder = this.dataSource.createQueryBuilder();
    let subQuery: any = '';
    subQuery = queryBuilder
      .subQuery()
      .select([
        'sc.*',
        'ROW_NUMBER() OVER (PARTITION BY sc."leadId" ORDER BY "sc"."updated_at" DESC) AS rn',
      ])
      .from('status_change', 'sc')
      .where('"sc"."deleted_at" IS NULL');

    if (initiatorId) {
      subQuery.andWhere('sc."initiatorId"=:initiatorId', {
        initiatorId,
      });
    }
    subQuery.andWhere('sc.updated_at BETWEEN :startDate AND :endDate', {
      startDate,
      endDate,
    });

    if (branchName) {
      subQuery.andWhere('sc.branch_name = :branchName', { branchName });
    }

    const finalQuery = queryBuilder
      .select([
        'Count(id)',
        // "*",
        '"finalStatus"',
      ])
      .addFrom(`${subQuery.getQuery()}`, 't')
      .where('t."rn"= 1');

    finalQuery
      .addGroupBy('t."finalStatus"')
      .setParameters(subQuery.getParameters());
    const result = await finalQuery.getRawMany();
    console.log(result);

    const mappedResults = this.mapResultsToStages(result);
    console.log(mappedResults);
    return mappedResults;
  }
}
