import React, { createContext, useContext, useMemo, useState } from 'react';
import { apiManagement } from '../api';
import {
  clearAuthToken,
  clearStoredAuthUser,
  getAuthToken,
  getStoredAuthUser,
  setAuthToken,
  setStoredAuthUser,
} from '../api';
import type { AuthUserProfile, TestUserSummary } from '../api';

interface AuthContextValue {
  user: AuthUserProfile | null;
  token: string | null;
  isAuthenticated: boolean;
  login: (loginName: string, password: string) => Promise<void>;
  logout: () => void;
  listTestUsers: () => Promise<TestUserSummary[]>;
}

const AuthContext = createContext<AuthContextValue | undefined>(undefined);

export function AuthProvider({ children }: { children: React.ReactNode }) {
  const [user, setUser] = useState<AuthUserProfile | null>(() => getStoredAuthUser());
  const [token, setToken] = useState<string | null>(() => getAuthToken());

  const login = async (loginName: string, password: string) => {
    const response = await apiManagement.auth.login({ loginName, password });
    setAuthToken(response.token);
    setStoredAuthUser(response.user);
    setToken(response.token);
    setUser(response.user);
  };

  const logout = () => {
    clearAuthToken();
    clearStoredAuthUser();
    setToken(null);
    setUser(null);
    window.location.reload();
  };

  const listTestUsers = async () => {
    const response = await apiManagement.auth.listTestUsers();
    return response.users;
  };

  const value = useMemo<AuthContextValue>(
    () => ({
      user,
      token,
      isAuthenticated: Boolean(token && user),
      login,
      logout,
      listTestUsers,
    }),
    [token, user]
  );

  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
}

export function useAuth(): AuthContextValue {
  const context = useContext(AuthContext);
  if (!context) {
    throw new Error('useAuth muss innerhalb von AuthProvider verwendet werden.');
  }

  return context;
}
