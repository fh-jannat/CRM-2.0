import { dummyApplication } from '@/dummyData/dummyApplication';

export const getAllApplications = async (values: any) => {
  console.log('getAllApplication', values);

  // Uncomment this code when the API is ready
  // const response = await axios.get(GET_ALL_LEADS, values);
  // return response.data;

  // Simulate API call delay using setTimeout
  return new Promise((resolve) => {
    setTimeout(() => {
      // Simulated response
      const response = {
        items: dummyApplication,
        total: 100,
        pageNo: 1,
        pageSize: 10,
      };
      resolve(response);
    }, 2000); // 2 second delay
  });
};
