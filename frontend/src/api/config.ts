export const API_BASE_URL = import.meta.env.VITE_API_BASE_URL ?? '/api';

// Storage keys are centralized so auth handling stays consistent.
export const AUTH_TOKEN_STORAGE_KEY = 'itletics.auth.token';
export const AUTH_USER_STORAGE_KEY = 'itletics.auth.user';
