import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Coachingclass } from '../entity/coachingclass.entity';
import { CoachingclassCrudService } from './coachingclass-crud.service';

@Injectable()
export class CoachingclassGeneralService {
  constructor(
    @InjectRepository(Coachingclass)
    private readonly coachingclassRepository: Repository<Coachingclass>,
    private readonly coachingclassService: CoachingclassCrudService,
  ) {}
}
