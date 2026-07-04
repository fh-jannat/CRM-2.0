import { Avatar } from 'antd';

type Props = {
  name: string;
  iconUrl: string;
  fontColor?: string;
  iconSize?: number;
  shape?: 'circle' | 'square';
};

function UsernameWithIcon({
  name,
  iconUrl,
  fontColor,
  iconSize = 20,
  shape = 'circle',
}: Props) {
  return (
    <div className='flex items-center gap-1'>
      <Avatar
        shape={shape}
        size={iconSize}
        src={iconUrl}
        style={{ marginRight: '2px', backgroundColor: '' }}
      >
        {name?.charAt(0).toUpperCase()}
      </Avatar>
      <div
        style={{ color: fontColor ?? '#22222B' }}
        className='text-[14px] font-semibold leading-[20px]'
      >
        {name}
      </div>
    </div>
  );
}

export default UsernameWithIcon;
