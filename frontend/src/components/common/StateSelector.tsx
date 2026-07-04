import { State } from '@/types';
import { Select, SelectProps } from 'antd';
import React, { useEffect } from 'react';

type StateSelectorProps = SelectProps & {
  countryId: number;
};
const StateSelector: React.FC<StateSelectorProps> = (props) => {
  const [allStates, setAllStates] = React.useState<State[]>([]);
  const [filteredStates, setFilteredStates] = React.useState<State[]>([]);

  const handleOnSearch = (searchText: string) => {
    const tempStates = allStates.filter((state: any) =>
      state.name.toLowerCase().includes(searchText.toLowerCase())
    );
    setFilteredStates(tempStates);
  };

  useEffect(() => {
    const fetchCountries = async () => {
      const response = await fetch(
        'https://venkatmcajj.github.io/react-country-state-city/data/statesminified.json'
      );
      const data = await response.json();
      const statesByCountryId: State[] = data.find(
        (state: any) => state.id === props.countryId
      )?.states;
      setAllStates(statesByCountryId);
      setFilteredStates(statesByCountryId);
    };
    fetchCountries();
  }, [props.countryId]);

  return (
    <Select showSearch onSearch={handleOnSearch} {...props}>
      {filteredStates?.map((state: any) => (
        <Select.Option key={state.name} value={state.name}>
          {state.emoji} {state.name}
        </Select.Option>
      ))}
    </Select>
  );
};

export default StateSelector;
