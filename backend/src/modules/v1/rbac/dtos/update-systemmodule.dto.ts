import { PartialType } from '@nestjs/swagger';
import { CreateSystemmoduleDto } from './create-systemmodule.dto';

export class UpdateSystemmoduleDto extends PartialType(CreateSystemmoduleDto) {}
