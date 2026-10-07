import { randomUUID } from 'node:crypto';
import { Router } from 'express';
import bcrypt from 'bcryptjs';
import { selectRows } from '../db';

interface LoginUserRow {
  user_id: number;
  login_name: string;
  password: string;
  email: string;
  first_name: string;
  last_name: string;
  is_verified: number;
}

interface RoleRow {
  role_id: number;
  role: string;
}

interface PermissionRow {
  permission_id: number;
  permission: string;
}

function asString(value: unknown): string {
  return value == null ? '' : String(value);
}

function asNumber(value: unknown): number {
  const parsed = Number(value);
  return Number.isFinite(parsed) ? parsed : 0;
}

function mapUserRow(row: Record<string, unknown>): LoginUserRow {
  return {
    user_id: asNumber(row.user_id),
    login_name: asString(row.login_name),
    password: asString(row.password),
    email: asString(row.email),
    first_name: asString(row.first_name),
    last_name: asString(row.last_name),
    is_verified: asNumber(row.is_verified),
  };
}

function mapRoleRow(row: Record<string, unknown>): RoleRow {
  return {
    role_id: asNumber(row.role_id),
    role: asString(row.role),
  };
}

function mapPermissionRow(row: Record<string, unknown>): PermissionRow {
  return {
    permission_id: asNumber(row.permission_id),
    permission: asString(row.permission),
  };
}

async function verifyPassword(plainPassword: string, storedPassword: string): Promise<boolean> {
  if (!storedPassword) {
    return false;
  }

  // Dev fallback: allow direct match when UI uses the stored value from /test-users.
  if (plainPassword === storedPassword) {
    return true;
  }

  if (storedPassword.startsWith('$2y$') || storedPassword.startsWith('$2a$') || storedPassword.startsWith('$2b$')) {
    const normalizedHash = storedPassword.startsWith('$2y$')
      ? `$2a$${storedPassword.slice(4)}`
      : storedPassword;

    try {
      return await bcrypt.compare(plainPassword, normalizedHash);
    } catch {
      return false;
    }
  }

  return plainPassword === storedPassword;
}

async function loadUserRoles(userId: number): Promise<RoleRow[]> {
  const rows = await selectRows(
    `
      SELECT DISTINCT r.role_id, r.role
      FROM user_to_role ur
      INNER JOIN md_role r ON r.role_id = ur.role_id
      WHERE ur.user_id = ?
      ORDER BY r.role ASC;
    `,
    [userId]
  );

  return rows.map(mapRoleRow);
}

async function loadUserPermissions(userId: number): Promise<PermissionRow[]> {
  const rows = await selectRows(
    `
      SELECT DISTINCT p.permission_id, p.permission
      FROM user_to_role ur
      INNER JOIN role_to_permission rp ON rp.role_id = ur.role_id
      INNER JOIN permission p ON p.permission_id = rp.permission_id
      WHERE ur.user_id = ?
      ORDER BY p.permission ASC;
    `,
    [userId]
  );

  return rows.map(mapPermissionRow);
}

const authRouter = Router();

authRouter.get('/test-users', async (_req, res, next) => {
  try {
    const usersRaw = await selectRows(
      `
        SELECT user_id, login_name, password, email, first_name, last_name, is_verified
        FROM md_user
        ORDER BY user_id ASC;
      `
    );

    const users = await Promise.all(usersRaw.map(async (row) => {
      const userId = asNumber(row.user_id);
      const roles = await loadUserRoles(userId);
      const permissions = await loadUserPermissions(userId);

      return {
        id: userId,
        loginName: asString(row.login_name),
        testPassword: asString(row.password),
        email: asString(row.email),
        firstName: asString(row.first_name),
        lastName: asString(row.last_name),
        isVerified: asNumber(row.is_verified) === 1,
        roleCount: roles.length,
        permissionCount: permissions.length,
        roles,
      };
    }));

    res.json({ users });
  } catch (error) {
    next(error);
  }
});

authRouter.post('/login', async (req, res, next) => {
  try {
    const loginName = typeof req.body?.loginName === 'string' ? req.body.loginName.trim() : '';
    const password = typeof req.body?.password === 'string' ? req.body.password : '';

    if (!loginName || !password) {
      res.status(400).json({ error: 'loginName und password sind erforderlich.' });
      return;
    }

    const userRows = await selectRows(
      `
        SELECT user_id, login_name, password, email, first_name, last_name, is_verified
        FROM md_user
        WHERE LOWER(login_name) = LOWER(?)
        LIMIT 1;
      `,
      [loginName]
    );

    const userRow = userRows[0];
    if (!userRow) {
      res.status(401).json({ error: 'Ungueltige Anmeldedaten.' });
      return;
    }

    const user = mapUserRow(userRow);
    const isPasswordValid = await verifyPassword(password, user.password);

    if (!isPasswordValid) {
      res.status(401).json({ error: 'Ungueltige Anmeldedaten.' });
      return;
    }

    const roles = await loadUserRoles(user.user_id);
    const permissions = await loadUserPermissions(user.user_id);

    const token = `dev.${user.user_id}.${randomUUID()}`;

    res.json({
      token,
      user: {
        id: user.user_id,
        loginName: user.login_name,
        firstName: user.first_name,
        lastName: user.last_name,
        email: user.email,
        isVerified: user.is_verified === 1,
        roles,
        permissions,
      },
    });
  } catch (error) {
    next(error);
  }
});

export default authRouter;
