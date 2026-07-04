import React from 'react';
import { Tag, TagProps } from 'antd';

interface ColoredTagProps extends TagProps {
  text: string;
}

const tagColors: { [key: string]: string } = {
  A: 'success',
  B: 'blue-inverse',
  C: 'cyan',
  D: 'error',
  E: 'purple-inverse',
  F: 'geekblue',
  G: 'geekblue-inverse',
  H: 'gold',
  I: 'red',
  J: 'gold-inverse',
  K: 'green',
  L: 'green-inverse',
  M: 'cyan-inverse',
  N: 'red',
  O: 'magenta',
  P: 'blue',
  Q: 'purple',
  R: 'orange',
  S: 'geekblue',
  T: '#d7d7d7',
  U: 'magenta',
  V: '#ababab',
  W: '#909090',
  X: '#757575',
  Y: '#2db7f5',
  Z: '#3f3f3f',
};

const ColoredTag: React.FC<ColoredTagProps> = ({ text, ...restProps }) => {
  const firstChar = text?.charAt(0)?.toUpperCase();
  const tagColor = tagColors[firstChar ?? 'A'];
  return (
    <Tag
      className='!flex !w-fit !items-center !justify-center'
      style={{ minWidth: '80px' }}
      color={tagColor}
      {...restProps}
    >
      {text?.toUpperCase()}
    </Tag>
  );
};

export default ColoredTag;
