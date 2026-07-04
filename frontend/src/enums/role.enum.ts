export enum Role {
  ADMIN = 'admin',
  COUNSELLOR = 'counsellor',
  APPLICATION = 'application',
  COMPLIANCE = 'compliance',
  MANAGER = 'manager',
  STUDENT = 'student',
  TEACHER = 'teacher',
  // USER = 'user',
}

export const roleOption = [
  { label: 'Counsellor', value: Role.COUNSELLOR },
  { label: 'Application', value: Role.APPLICATION },
  { label: 'Compliance', value: Role.COMPLIANCE },
  { label: 'Manager', value: Role.MANAGER },
  { label: 'Teacher', value: Role.TEACHER },
];
