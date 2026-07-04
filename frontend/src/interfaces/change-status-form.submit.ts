export interface IDocument {
  docName: string;
  file: any;
  link: string;
}

export interface IApplication {
  cousreLabel: string;
  university: string;
  intakeMonth: string;
  intakeYear: string;
  courseDetails: string;
}
export interface ISubmittedData {
  id?: string;
  stage: string;
  subStage: string;
  remark: string;
  assignedTo: number;
  documents?: IDocument[];
  applications?: IApplication[];
}
