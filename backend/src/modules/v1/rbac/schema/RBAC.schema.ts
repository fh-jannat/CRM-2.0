import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { HydratedDocument } from 'mongoose';

export type RBACDocument = HydratedDocument<RBAC>;

@Schema({
  timestamps: true,
})
export class RBAC {
  @Prop({ required: true })
  name: string;

  @Prop({ required: true, unique: true })
  email: string;
}

export const RBACSchema = SchemaFactory.createForClass(RBAC);

RBACSchema.virtual('id').get(function () {
  return this._id.toHexString();
});

RBACSchema.set('toJSON', {
  virtuals: true, // Ensure virtuals are included when converting to JSON
  transform: function (doc, ret) {
    delete ret._id; // Remove the default _id field
    delete ret.__v; // Remove the version property
    delete (ret as any).updatedAt; // Remove the updatedAt property
    return ret;
  },
});
