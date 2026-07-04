import { InjectRepository } from '@nestjs/typeorm';
import { Lead } from '../entity';
import { Repository } from 'typeorm';
import { startOfMonth, subMonths, format, eachMonthOfInterval } from 'date-fns';

export class LeadGeneralService {
  constructor(
    @InjectRepository(Lead)
    private readonly leadReposotiory: Repository<Lead>,
  ) {}

  private async getLast12Months(): Promise<Date[]> {
    const endDate = startOfMonth(new Date());
    const startDate = subMonths(endDate, 12);
    return eachMonthOfInterval({ start: startDate, end: endDate });
  }

  async groupLeadGenerationByLast12Months(branch?: string): Promise<any> {
    // Calculate the start of the period we want to group by
    const startDate = startOfMonth(subMonths(new Date(), 12));
    const queryBuilder = this.leadReposotiory.createQueryBuilder();
    const months = await this.getLast12Months();

    // Use query builder to group by month
    let query = queryBuilder
      .select("DATE_TRUNC('month', Lead.created_at)", 'month') // Adjust for PostgreSQL, or use appropriate function for other databases
      .addSelect('COUNT(*)', 'count')
      .where('Lead.created_at >= :startDate', { startDate });

    if (branch) {
      query = query.andWhere('Lead.branch_name = :branch', { branch });
    }

    query = query
      .groupBy("DATE_TRUNC('month', Lead.created_at)")
      .orderBy("DATE_TRUNC('month', Lead.created_at)", 'ASC');

    const groupedLeads = await query.getRawMany();
    // Map query results to a month count map
    const leadCounts = groupedLeads.reduce(
      (acc, row) => {
        acc[format(row.month, 'yyyy-MM-dd')] = parseInt(row.count, 10);
        return acc;
      },
      {} as Record<string, number>,
    );

    // Fill missing months with zero count
    const result = months.map((month) => {
      const monthStr = format(month, 'yyyy-MM-dd');
      return {
        month: format(month, 'yyyy-MM'),
        count: leadCounts[monthStr] || 0,
      };
    });

    return result;
  }

  async groupLeadSpecificStatusByLast12Months(
    sub_stage: string,
    branch?: string,
  ): Promise<any> {
    // Calculate the start of the period we want to group by
    const startDate = startOfMonth(subMonths(new Date(), 12));
    const queryBuilder = this.leadReposotiory.createQueryBuilder();
    const months = await this.getLast12Months();

    // Use query builder to group by month
    let query = queryBuilder
      .select("DATE_TRUNC('month', Lead.updated_at)", 'month') // Adjust for PostgreSQL, or use appropriate function for other databases
      .addSelect('COUNT(*)', 'count')
      .where('Lead.updated_at >= :startDate', { startDate })
      .where('Lead.sub_stage =:var', { var: sub_stage });

    if (branch) {
      query = query.andWhere('Lead.branch_name = :branch', { branch });
    }
    query = query
      .groupBy("DATE_TRUNC('month', Lead.updated_at)")
      .orderBy("DATE_TRUNC('month', Lead.updated_at)", 'ASC');

    const groupedLeads = await query.getRawMany();
    // Map query results to a month count map
    const leadCounts = groupedLeads.reduce(
      (acc, row) => {
        acc[format(row.month, 'yyyy-MM-dd')] = parseInt(row.count, 10);
        return acc;
      },
      {} as Record<string, number>,
    );

    // Fill missing months with zero count
    const result = months.map((month) => {
      const monthStr = format(month, 'yyyy-MM-dd');
      return {
        month: format(month, 'yyyy-MM'),
        count: leadCounts[monthStr] || 0,
      };
    });

    return result;
  }
}
