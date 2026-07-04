import { Country } from '@/types';
import { Select, SelectProps } from 'antd';
import React, { useEffect } from 'react';

type CountrySelectorProps = SelectProps & {
  setSelectCountryId?: (id: number) => void;
  onChange?: (value: string) => void;
};
const CountrySelector: React.FC<CountrySelectorProps> = (props) => {
  const [allCountries, setAllCountries] = React.useState<Country[]>([]);
  const [filteredCountryOptions, setFilteredCountryOptions] = React.useState<
    Country[]
  >([]);

  const handleOnSearch = (searchText: string) => {
    const filteredCountries = allCountries.filter((country: any) =>
      country.name.toLowerCase().includes(searchText.toLowerCase())
    );
    setFilteredCountryOptions(filteredCountries);
  };

  useEffect(() => {
    const fetchCountries = async () => {
      const response = await fetch(
        'https://venkatmcajj.github.io/react-country-state-city/data/countriesminified.json'
      );
      const data = await response.json();
      setAllCountries(data);
      setFilteredCountryOptions(data);
    };
    fetchCountries();
  }, []);

  const handleOnChange = (value: string) => {
    props.onChange && props.onChange(value);
    const selectedCountry = allCountries?.find(
      (country: any) => country?.name === value
    );
    props.setSelectCountryId &&
      props.setSelectCountryId(selectedCountry?.id || -1);
  };

  return (
    <Select
      showSearch
      onSearch={handleOnSearch}
      {...props}
      onChange={handleOnChange}
    >
      {filteredCountryOptions.map((country: any, index: any) => (
        <Select.Option key={index} value={country.name}>
          {country.emoji} {country.name}
        </Select.Option>
      ))}
    </Select>
  );
};

export default CountrySelector;
