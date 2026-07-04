import { dummyUniversities } from '@/dummyData/dummyUniversities';

export const getAllUniversities = async (values: any) => {
  console.log('getAllApplication', values);

  // Uncomment this code when the API is ready
  // const response = await axios.get(GET_ALL_LEADS, values);
  // return response.data;

  // Simulate API call delay using setTimeout
  return new Promise((resolve) => {
    setTimeout(() => {
      // Simulated response
      const response = {
        items: dummyUniversities,
        total: 100,
        pageNo: 1,
        pageSize: 10,
      };
      resolve(response);
    }, 2000); // 2 second delay
  });
};

export const createUniversity = async (values: any) => {
  console.log('createLead', values);
  // Uncomment this code when the API is ready
  // const response = await axios.post(CREATE_LEAD, values);
  // return response.data;
  return new Promise((resolve) => {
    setTimeout(() => {
      // Simulated response
      resolve(values);
    }, 2000); // 2 second delay
  });
};
