import { API_BASE_URL } from './config';
import { getAuthToken } from './tokenStorage';
import { ApiError, type ApiErrorPayload, type RequestOptions } from './types';

function buildUrl(path: string): string {
  if (path.startsWith('http://') || path.startsWith('https://')) {
    return path;
  }

  const normalizedBase = API_BASE_URL.endsWith('/') ? API_BASE_URL.slice(0, -1) : API_BASE_URL;
  const normalizedPath = path.startsWith('/') ? path : `/${path}`;
  return `${normalizedBase}${normalizedPath}`;
}

async function parseJsonSafe<T>(response: Response): Promise<T | undefined> {
  const contentType = response.headers.get('content-type') ?? '';
  if (!contentType.includes('application/json')) {
    return undefined;
  }

  return (await response.json()) as T;
}

export async function apiRequest<TResponse, TBody = unknown>(
  path: string,
  options: RequestOptions<TBody> = {}
): Promise<TResponse> {
  const token = getAuthToken();
  const method = options.method ?? 'GET';

  const headers: Record<string, string> = {
    Accept: 'application/json',
    ...options.headers,
  };

  if (options.body !== undefined) {
    headers['Content-Type'] = 'application/json';
  }

  if (token && !headers.Authorization) {
    headers.Authorization = `Bearer ${token}`;
  }

  const response = await fetch(buildUrl(path), {
    method,
    headers,
    body: options.body !== undefined ? JSON.stringify(options.body) : undefined,
    signal: options.signal,
  });

  if (!response.ok) {
    const payload = await parseJsonSafe<ApiErrorPayload>(response);
    const fallbackMessage = `Request failed with status ${response.status}`;
    const message = payload?.message ?? payload?.error ?? fallbackMessage;
    throw new ApiError(message, response.status, payload);
  }

  if (response.status === 204) {
    return undefined as TResponse;
  }

  const data = await parseJsonSafe<TResponse>(response);
  return (data ?? (undefined as TResponse)) as TResponse;
}

export const httpClient = {
  get: <TResponse>(path: string, options?: Omit<RequestOptions, 'method' | 'body'>) =>
    apiRequest<TResponse>(path, { ...options, method: 'GET' }),

  post: <TResponse, TBody = unknown>(path: string, body?: TBody, options?: Omit<RequestOptions<TBody>, 'method' | 'body'>) =>
    apiRequest<TResponse, TBody>(path, { ...options, method: 'POST', body }),

  put: <TResponse, TBody = unknown>(path: string, body?: TBody, options?: Omit<RequestOptions<TBody>, 'method' | 'body'>) =>
    apiRequest<TResponse, TBody>(path, { ...options, method: 'PUT', body }),

  patch: <TResponse, TBody = unknown>(path: string, body?: TBody, options?: Omit<RequestOptions<TBody>, 'method' | 'body'>) =>
    apiRequest<TResponse, TBody>(path, { ...options, method: 'PATCH', body }),

  delete: <TResponse>(path: string, options?: Omit<RequestOptions, 'method' | 'body'>) =>
    apiRequest<TResponse>(path, { ...options, method: 'DELETE' }),
};
