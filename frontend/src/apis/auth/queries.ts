import { useQuery } from '@tanstack/react-query';
import { GET_ROLE_KEY, GET_USER_KEY, IS_LOGGEDIN_KEY } from './keys';
import { getRoles, getUser, isLoggedIn } from './apis';

export const useIsLoggedInQuery = () => {
  return useQuery({
    queryKey: [IS_LOGGEDIN_KEY],
    queryFn: async () => await isLoggedIn(),
    staleTime: Infinity,
  });
};

export const useGetRolesQuery = () => {
  return useQuery({
    queryKey: [GET_ROLE_KEY],
    queryFn: async () => await getRoles(),
    staleTime: Infinity,
  });
};

export const useGetUser = () => {
  return useQuery({
    queryKey: [GET_USER_KEY],
    queryFn: async () => await getUser(),
    staleTime: Infinity,
  });
};
