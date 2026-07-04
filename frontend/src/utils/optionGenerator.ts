export const optionGenerator = (enumObj: any) => {
  return Object.values(enumObj).map((enumEach: any) => ({
    label: enumEach.charAt(0).toUpperCase() + enumEach.slice(1).toLowerCase(),
    value: enumEach,
  }));
};
