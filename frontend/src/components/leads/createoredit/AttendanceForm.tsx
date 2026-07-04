import { useLeadContext } from '@/contexts/AddNewLeadContext';
import { MinusOutlined, PlusOutlined } from '@ant-design/icons';
import { Button, Checkbox, Form, Tooltip } from 'antd';

const AttendanceForm = () => {
  const { form, isClass, classes, exams } = useLeadContext();
  const initialValues = isClass ? classes : exams;
  form.setFieldValue('classes', classes);
  form.setFieldValue('exams', exams);

  return (
    <div className='flex flex-wrap rounded-[10px] border-[1px] p-[20px]'>
      <Form.List name={isClass ? 'classes' : 'exams'}>
        {(fields, { add, remove }) => (
          <div className='flex flex-col gap-3'>
            <div className='flex flex-row gap-2'>
              <span className='text-[16px] text-primaryColor'>
                {isClass ? 'Class Attendance' : 'Exam Attendance'}
              </span>
              <Tooltip title={`Add ${isClass ? 'Class' : 'Exam'}`}>
                <Button
                  type='primary'
                  size='small'
                  style={{ borderRadius: '50%' }}
                  icon={<PlusOutlined />}
                  onClick={() => add()}
                />
              </Tooltip>
              {fields.length > 0 && (
                <Tooltip title={`Remove ${isClass ? 'Class' : 'Exam'}`}>
                  <Button
                    size='small'
                    style={{ borderRadius: '50%' }}
                    icon={<MinusOutlined style={{ color: 'red' }} />}
                    onClick={() => remove(fields.length - 1)}
                  />
                </Tooltip>
              )}
            </div>
            <div className='flex flex-wrap gap-2'>
              {fields.map((field, index) => (
                <Form.Item
                  key={field.key}
                  name={[field.name]}
                  className='py-[5px]'
                  valuePropName='checked'
                  initialValue={initialValues && initialValues[index]}
                >
                  <Checkbox
                    defaultChecked={initialValues && initialValues[index]}
                  >
                    {`${isClass ? 'Class' : 'Exam'}-${index + 1}`}
                  </Checkbox>
                </Form.Item>
              ))}
            </div>
          </div>
        )}
      </Form.List>
    </div>
  );
};

export default AttendanceForm;

// import { MinusOutlined, PlusOutlined } from '@ant-design/icons';
// import { Button, Checkbox, Form, FormInstance, Tooltip } from 'antd';
// import React, { useEffect, useState } from 'react';

// type OtherInfoFormProps = {
//   form: FormInstance;
//   subStage: string;
// };

// const AttendanceForm: React.FC<OtherInfoFormProps> = ({ form, subStage }) => {
//   const [classAttendance, setClassAttendance] = useState<boolean[]>([]);
//   const [examAttendance, setExamAttendance] = useState<boolean[]>([]);

//   useEffect(() => {
//     form.resetFields(['classes', 'exams']);
//     setClassAttendance([]);
//     setExamAttendance([]);
//     // eslint-disable-next-line
//   }, [subStage]);

//   const handleClassCheckboxChange = (index: number) => {
//     const updatedAttendance = [...classAttendance];
//     updatedAttendance[index] = !updatedAttendance[index];
//     setClassAttendance(updatedAttendance);
//   };

//   const handleExamCheckboxChange = (index: number) => {
//     const updatedAttendance = [...examAttendance];
//     updatedAttendance[index] = !updatedAttendance[index];
//     setExamAttendance(updatedAttendance);
//   };

//   const getClassOptions = () => {
//     return classAttendance.map((attendance, index) => ({
//       label: `Class-${index + 1}`,
//       value: index + 1,
//       checked: attendance,
//     }));
//   };

//   const getExamOptions = () => {
//     return examAttendance.map((attendance, index) => ({
//       label: `Exam-${index + 1}`,
//       value: index + 1,
//       checked: attendance,
//     }));
//   };

//   return (
//     <div className='flex flex-wrap rounded-[10px] border-[1px] p-[20px]'>
//       {(subStage === 'general' ||
//         subStage === 'first-track' ||
//         subStage === 'extended') && (
//         <div className='flex w-full flex-col'>
//           <Form.Item
//             label={
//               <div className='flex flex-row gap-2'>
//                 <span className='text-[16px] text-primaryColor'>
//                   Class Attendance
//                 </span>
//                 <Tooltip title='Add Option'>
//                   <Button
//                     type='primary'
//                     size='small'
//                     style={{ borderRadius: '50%' }}
//                     icon={<PlusOutlined />}
//                     onClick={() =>
//                       setClassAttendance([...classAttendance, false])
//                     }
//                   />
//                 </Tooltip>
//                 <Tooltip title='Remove Option'>
//                   <Button
//                     size='small'
//                     style={{ borderRadius: '50%' }}
//                     icon={<MinusOutlined style={{ color: 'red' }} />}
//                     onClick={() =>
//                       classAttendance.length > 0 &&
//                       setClassAttendance(
//                         classAttendance.slice(0, -1) // Remove the last element
//                       )
//                     }
//                   />
//                 </Tooltip>
//               </div>
//             }
//             name={'classes'}
//           >
//             <Checkbox.Group
//               options={getClassOptions()}
//               onChange={(values) => {
//                 const newAttendance = Array.from({ length: classAttendance.length }, (_, index) => values.includes(index + 1));
//                 setClassAttendance(newAttendance);
//               }}
//             />
//           </Form.Item>
//         </div>
//       )}
//       {subStage === 'mock' && (
//         <div className='flex w-full flex-col'>
//           <Form.Item
//             label={
//               <div className='flex flex-row gap-2'>
//                 <span className='text-[16px] text-primaryColor'>
//                   Exam Attendance
//                 </span>
//                 <Tooltip title='Add Option'>
//                   <Button
//                     type='primary'
//                     size='small'
//                     style={{ borderRadius: '50%' }}
//                     icon={<PlusOutlined />}
//                     onClick={() => setExamAttendance([...examAttendance, false])}
//                   />
//                 </Tooltip>
//                 <Tooltip title='Remove Option'>
//                   <Button
//                     size='small'
//                     style={{ borderRadius: '50%' }}
//                     icon={<MinusOutlined style={{ color: 'red' }} />}
//                     onClick={() =>
//                       examAttendance.length > 0 &&
//                       setExamAttendance(
//                         examAttendance.slice(0, -1) // Remove the last element
//                       )
//                     }
//                   />
//                 </Tooltip>
//               </div>
//             }
//             name={'exams'}
//           >
//             <Checkbox.Group
//               options={getExamOptions()}
//               onChange={(values) => {
//                 const newAttendance = Array.from({ length: examAttendance.length }, (_, index) => values.includes(index + 1));
//                 setExamAttendance(newAttendance);
//               }}
//             />
//           </Form.Item>
//         </div>
//       )}
//     </div>
//   );
// };

// export default AttendanceForm;
