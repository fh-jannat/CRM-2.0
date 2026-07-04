import axios from './axios';

export const uploadFile = async (file: any) => {
  const formData = new FormData();
  formData.append('file', file);
  console.log(formData);
  console.log(file);
  const res = await axios.post('/image/upload', formData, {
    headers: {
      'Content-Type': 'multipart/form-data',
    },
  });
  return res.data;
};
