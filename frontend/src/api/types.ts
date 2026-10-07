export type ApiMethod = 'GET' | 'POST' | 'PUT' | 'PATCH' | 'DELETE';

export interface DatabaseColumn {
  name: string;
  type: string;
  notNull: boolean;
  defaultValue: string | null;
  isPrimaryKey: boolean;
}

export interface DatabaseTable {
  name: string;
  columns: DatabaseColumn[];
  primaryKey: string | null;
}

export interface DatabaseTablesResponse {
  tables: DatabaseTable[];
}

export interface DatabaseRowsResponse<TRecord extends Record<string, unknown> = Record<string, unknown>> {
  rows: TRecord[];
  total: number;
}

export interface DatabaseRowResponse<TRecord extends Record<string, unknown> = Record<string, unknown>> {
  row: TRecord | null;
}

export interface DatabaseQueryOptions {
  limit?: number;
  offset?: number;
  sortBy?: string;
  sortOrder?: 'asc' | 'desc';
}

export interface ApiErrorPayload {
  error?: string;
  message?: string;
  [key: string]: unknown;
}

export class ApiError extends Error {
  public readonly status: number;
  public readonly payload?: ApiErrorPayload;

  constructor(message: string, status: number, payload?: ApiErrorPayload) {
    super(message);
    this.name = 'ApiError';
    this.status = status;
    this.payload = payload;
  }
}

export interface RequestOptions<TBody = unknown> {
  method?: ApiMethod;
  body?: TBody;
  headers?: Record<string, string>;
  signal?: AbortSignal;
}

export interface AuthRole {
  role_id: number;
  role: string;
}

export interface AuthPermission {
  permission_id: number;
  permission: string;
}

export interface AuthUserProfile {
  id: number;
  loginName: string;
  firstName: string;
  lastName: string;
  email: string;
  isVerified: boolean;
  roles: AuthRole[];
  permissions: AuthPermission[];
}

export interface LoginRequest {
  loginName: string;
  password: string;
}

export interface LoginResponse {
  token: string;
  user: AuthUserProfile;
}

export interface TestUserSummary {
  id: number;
  loginName: string;
  testPassword: string;
  email: string;
  firstName: string;
  lastName: string;
  isVerified: boolean;
  roleCount: number;
  permissionCount: number;
  roles: AuthRole[];
}

export interface TestUsersResponse {
  users: TestUserSummary[];
}

export interface UploadResponse {
  success: boolean;
  filename: string;
  path: string;
  size: number;
  mimetype: string;
}
