import { PartialType } from '@nestjs/swagger';
import { CreateStatusChangeDto } from './create-status-change.dto';

export class UpdateStatusChangeDto extends PartialType(CreateStatusChangeDto) {}
