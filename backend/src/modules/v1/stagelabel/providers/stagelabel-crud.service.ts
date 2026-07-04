import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { SubStagelabel } from '../entities/substagelabel.entity';
import { UpdateStagelabelDto } from '../dtos';

@Injectable()
export class StagelabelCrudService {
  constructor(
    @InjectRepository(SubStagelabel)
    private stagelabelRepository: Repository<SubStagelabel>,
  ) {}

  async seed() {
    const subStageLabels = [
      { stage: 'lead', substage: 'all', substageLabel: 'all' },
      { stage: 'lead', substage: 'new', substageLabel: 'new' },
      { stage: 'lead', substage: 'first', substageLabel: 'first' },
      { stage: 'lead', substage: 'second', substageLabel: 'second' },
      { stage: 'lead', substage: 'third', substageLabel: 'third' },
      { stage: 'lead', substage: 'final-call', substageLabel: 'final-call' },
      { stage: 'lead', substage: 'unreachable', substageLabel: 'unreachable' },
      {
        stage: 'lead',
        substage: 'future-interest',
        substageLabel: 'future-interest',
      },
      {
        stage: 'lead',
        substage: 'not-interested',
        substageLabel: 'not-interested',
      },
      { stage: 'potential', substage: 'all', substageLabel: 'all' },
      {
        stage: 'potential',
        substage: 'appointment-book',
        substageLabel: 'appointment-book',
      },
      {
        stage: 'potential',
        substage: 'postponed',
        substageLabel: 'postponed',
      },
      {
        stage: 'potential',
        substage: 'cancel',
        substageLabel: 'cancel',
      },
      {
        stage: 'potential',
        substage: 'waiting-for-document',
        substageLabel: 'waiting-for-document',
      },
      { stage: 'admission', substage: 'all', substageLabel: 'all' },
      {
        stage: 'admission',
        substage: 'start-application',
        substageLabel: 'start-application',
      },
      { stage: 'admission', substage: 'applied', substageLabel: 'applied' },
      {
        stage: 'admission',
        substage: 'offer-received',
        substageLabel: 'offer-received',
      },
      { stage: 'admission', substage: 'offer', substageLabel: 'offer' },
      {
        stage: 'admission',
        substage: 'first-interview',
        substageLabel: 'first-interview',
      },
      {
        stage: 'admission',
        substage: 'unconditional-offer',
        substageLabel: 'unconditional-offer',
      },
      {
        stage: 'admission',
        substage: 'first-payment',
        substageLabel: 'first-payment',
      },
      {
        stage: 'admission',
        substage: 'end-application',
        substageLabel: 'end-application',
      },
      { stage: 'compliance', substage: 'all', substageLabel: 'all' },
      {
        stage: 'compliance',
        substage: 'final-choice',
        substageLabel: 'final-choice',
      },
      {
        stage: 'compliance',
        substage: 'visa-application',
        substageLabel: 'visa-application',
      },
      {
        stage: 'compliance',
        substage: 'visa-interview',
        substageLabel: 'visa-interview',
      },
      { stage: 'compliance', substage: 'visa', substageLabel: 'visa' },
      { stage: 'compliance', substage: 'refused', substageLabel: 'refused' },
      {
        stage: 'compliance',
        substage: 'final-payment',
        substageLabel: 'final-payment',
      },
      { stage: 'compliance', substage: 'enrolled', substageLabel: 'enrolled' },
      {
        stage: 'compliance',
        substage: 'not-enrolled',
        substageLabel: 'not-enrolled',
      },
    ];

    for (const subStageLabel of subStageLabels) {
      const existing = await this.stagelabelRepository.findOne({
        where: { stage: subStageLabel.stage, substage: subStageLabel.substage },
      });

      if (!existing) {
        await this.stagelabelRepository.save(subStageLabel);
      }
    }
  }

  async getAll() {
    return await this.stagelabelRepository.find({
      order: { createdAt: 'asc' },
    });
  }

  async getsubStageLabel(stage: string, substage: string) {
    return await this.stagelabelRepository.findOne({
      where: { stage, substage },
    });
  }

  async getSubStage(label: string, stage: string) {
    return await this.stagelabelRepository.findOne({
      where: { substageLabel: label, stage },
    });
  }

  async updateSubStage(updateStagelabelDto: UpdateStagelabelDto) {
    const subStageLabel = await this.getsubStageLabel(
      updateStagelabelDto.stage,
      updateStagelabelDto.substage,
    );
    if (!subStageLabel) {
      throw new NotFoundException('Substage label not found');
    }
    subStageLabel.substageLabel = updateStagelabelDto.substagelabel;
    return await this.stagelabelRepository.save(subStageLabel);
  }

  async buildMenu(stage: string) {
    const subStages = await this.stagelabelRepository.find({
      where: { stage },
      order: { createdAt: 'asc' },
    });
    const menu = [];
    for (const subStage of subStages) {
      menu.push({
        label: this.getMenuLabel(subStage.substageLabel),
        key: `${stage}/${subStage.substageLabel}`,
      });
    }
    return menu;
  }

  async buildOption(stage: string) {
    const subStages = await this.stagelabelRepository.find({
      where: { stage },
      order: { createdAt: 'asc' },
    });
    const options = [];
    for (const subStage of subStages) {
      options.push({
        label: this.getMenuLabel(subStage.substageLabel),
        value: `${subStage.substageLabel}`,
      });
    }
    return options;
  }

  getMenuLabel(inputString) {
    const cleanedString = inputString.replace('-', ' ');
    const words = cleanedString
      .split(' ')
      .map(
        (word) => word.charAt(0).toUpperCase() + word.slice(1).toLowerCase(),
      );
    return words.join(' ');
  }
}
