'use client';

import { validatePhoneNumber } from '@/utils';
import PhoneInput, { PhoneInputProps } from 'react-phone-input-2';
import 'react-phone-input-2/lib/style.css';

type CustomPhoneInputProps = PhoneInputProps & {
  onChange?: (value: string) => void;
  value?: string;
};

export const CustomPhoneInput: React.FC<CustomPhoneInputProps> = ({
  onChange,
  value,
}) => {
  const handleChange = (inputValue: string) => {
    if (onChange) {
      onChange(`+${inputValue.toString()}`);
    }
  };

  return (
    <PhoneInput
      inputStyle={{ width: '100%', height: '40px' }}
      placeholder='Enter phone number'
      enableSearch={true}
      country={'bd'}
      autoFormat
      countryCodeEditable={false}
      disableSearchIcon
      value={value}
      onChange={handleChange}
      isValid={(inputValue) => {
        if (inputValue.length > 3) {
          return validatePhoneNumber(`+${inputValue}`);
        }
        return true;
      }}
    />
  );
};
