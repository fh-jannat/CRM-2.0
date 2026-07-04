import { toast } from 'react-toastify';

export const handleErrorToast = (
  error: any,
  signOutUser?: (() => void) | null | undefined
) => {
  if (error?.response?.status === 498) {
    if (signOutUser) {
      signOutUser();
      toast.error('Session expired. Please log in again.');
    }
  } else {
    toast.error(
      error?.response?.data?.message ||
        error?.response?.message ||
        error?.message ||
        'An error occurred, please try again later'
    );
  }
};
