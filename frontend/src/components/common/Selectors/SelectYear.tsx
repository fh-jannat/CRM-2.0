'use client';
import { Select, SelectProps } from 'antd';
import React, { useState } from 'react';

type SelectYearProps = SelectProps;

const SelectYear: React.FC<SelectYearProps> = (props) => {
  const currentYear = new Date().getFullYear();
  const startYear = currentYear;
  const endYear = 2101;

  const [filteredOptions, setFilteredOptions] = useState(
    Array.from({ length: endYear - startYear }, (_, index) => {
      const year = startYear + index;
      return { label: year.toString(), value: year.toString() };
    })
  );
  const yearOptions = Array.from(
    { length: endYear - startYear },
    (_, index) => {
      const year = startYear + index;
      return { label: year.toString(), value: year.toString() };
    }
  );

  const handleOnYearSearch = (value: string) => {
    const filteredOptions = yearOptions.filter((option) =>
      option.label.includes(value)
    );
    setFilteredOptions(filteredOptions);
  };

  return (
    <Select
      {...props}
      options={filteredOptions}
      showSearch
      onSearch={handleOnYearSearch}
    />
  );
};

export default SelectYear;
