import { ThemeConfig } from 'antd';

export const antdTheme: ThemeConfig = {
  token: {
    colorPrimary: '#518581',
    borderRadius: 2,
    fontFamily: 'Inter, sans-serif',
    fontSize: 13,
  },
  components: {
    Card: {
      actionsBg: 'rgb(22, 119, 255)',
      colorBgContainer: 'rgba(22, 119, 255, 0.1)',
      colorText: 'rgb(0, 0, 0)',
    },
    Table: {
      headerColor: '#7A828E',
      headerBg: '#F9F9FB',
      fontSize: 11,
      fontWeightStrong: 500,
      fontFamily: 'Inter, sans-serif',
      colorBgContainer: '#F9F9FB',
      cellFontSize: 12,
      colorText: '#7A828E',
      borderColor: '#DDE2EA',
      rowSelectedBg: '#EDF1F7',
      rowSelectedHoverBg: 'white',
      headerSplitColor: '#DDE2EA',
      rowHoverBg: 'white',
    },
    Pagination: {
      itemActiveBg: '#054F9F',
      colorText: '#7A828E',
      colorPrimary: 'white',
    },
    Menu: {
      // itemColor: '#7A828E',
      // itemSelectedColor: '#c86af7',
      // itemHoverBg: '#a5c2f2',
      itemBorderRadius: 8,
      // itemSelectedBg: '#054F9F',
      // itemHoverColor: '#054F9F',
      groupTitleColor: '#9BA5B7',
      groupTitleFontSize: 12,
      itemActiveBg: '#054F9F',
    },
    Tabs: {
      itemColor: '#9BA5B7',
      titleFontSize: 11,
    },
    Modal: {
      titleColor: '#518581',
      titleFontSize: 24,
      contentBg: '#EDF1F7',
      headerBg: '#EDF1F7',
      titleLineHeight: 2,
      borderRadius: 8,
      fontFamily: 'Inter, sans-serif',
    },
    Collapse: {
      colorTextHeading: '#518581',
      fontSize: 16,
    },
  },
};
