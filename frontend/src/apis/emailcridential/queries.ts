import { useMutation } from '@tanstack/react-query';

import { createEmailcridential, sendEmail } from './apis';
import { CREATE_EMAILCRIDENTIAL, SEND_EMAIL } from './keys';

export const useCreateEmailcridential = () => {
  return useMutation({
    mutationKey: [CREATE_EMAILCRIDENTIAL],
    mutationFn: async (data: any) => await createEmailcridential(data),
  });
};

export const useSendEmail = () => {
  return useMutation({
    mutationKey: [SEND_EMAIL],
    mutationFn: async (data: any) => await sendEmail(data),
  });
};
