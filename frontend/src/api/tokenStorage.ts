import { AUTH_TOKEN_STORAGE_KEY, AUTH_USER_STORAGE_KEY } from './config';
import type { AuthUserProfile } from './types';

export function getAuthToken(): string | null {
  return localStorage.getItem(AUTH_TOKEN_STORAGE_KEY);
}

export function setAuthToken(token: string): void {
  localStorage.setItem(AUTH_TOKEN_STORAGE_KEY, token);
}

export function clearAuthToken(): void {
  localStorage.removeItem(AUTH_TOKEN_STORAGE_KEY);
}

export function getStoredAuthUser(): AuthUserProfile | null {
  const value = localStorage.getItem(AUTH_USER_STORAGE_KEY);
  if (!value) {
    return null;
  }

  try {
    return JSON.parse(value) as AuthUserProfile;
  } catch {
    return null;
  }
}

export function setStoredAuthUser(user: AuthUserProfile): void {
  localStorage.setItem(AUTH_USER_STORAGE_KEY, JSON.stringify(user));
}

export function clearStoredAuthUser(): void {
  localStorage.removeItem(AUTH_USER_STORAGE_KEY);
}
