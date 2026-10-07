// Keep raw endpoint paths centralized. Higher-level API usage belongs in apiManagement.ts.
export const endpoints = {
  health: '/health',
  database: {
    tables: '/db/tables',
    tableRows: (tableName: string) => `/db/tables/${encodeURIComponent(tableName)}/rows`,
    tableRow: (tableName: string, rowId: string | number) =>
      `/db/tables/${encodeURIComponent(tableName)}/rows/${encodeURIComponent(String(rowId))}`,
  },
  auth: {
    login: '/auth/login',
    testUsers: '/auth/test-users',
    // refresh: '/auth/refresh',
    // logout: '/auth/logout',
  },
  upload: {
    logo: '/upload/logo',
  },
  users: {
    // me: '/users/me',
  },
  tournaments: {
    // list: '/tournaments',
  },
  leagues: {
    // list: '/leagues',
  },
  teams: {
    // list: '/teams',
  },
} as const;
