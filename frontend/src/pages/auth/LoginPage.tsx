import { useEffect, useState } from 'react';
import { ApiError } from '../../api';
import type { TestUserSummary } from '../../api';
import { useAuth } from '../../auth/AuthContext';
import './LoginPage.css';

function LoginPage() {
  const { login, listTestUsers } = useAuth();
  const [loginName, setLoginName] = useState('');
  const [password, setPassword] = useState('');
  const [testUsers, setTestUsers] = useState<TestUserSummary[]>([]);
  const [loadingUsers, setLoadingUsers] = useState(true);
  const [submitting, setSubmitting] = useState(false);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    let isMounted = true;

    async function loadUsers() {
      setLoadingUsers(true);
      try {
        const users = await listTestUsers();
        if (!isMounted) {
          return;
        }

        setTestUsers(users);
      } catch (loadError) {
        if (!isMounted) {
          return;
        }

        setError(loadError instanceof Error ? loadError.message : 'Testuser konnten nicht geladen werden.');
      } finally {
        if (isMounted) {
          setLoadingUsers(false);
        }
      }
    }

    void loadUsers();

    return () => {
      isMounted = false;
    };
  }, [listTestUsers]);

  const selectedUser = testUsers.find((user) => user.loginName === loginName) ?? null;

  const handleSubmit = async (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    setSubmitting(true);
    setError(null);

    try {
      await login(loginName, password);
    } catch (submitError) {
      if (submitError instanceof ApiError) {
        setError(submitError.message);
      } else {
        setError(submitError instanceof Error ? submitError.message : 'Anmeldung fehlgeschlagen.');
      }
    } finally {
      setSubmitting(false);
      // App refreshen
        window.location.reload();
    }
  };

  return (
    <div className="login-shell">
      <div className="login-card">
        <div className="login-card__intro">
          <p className="login-eyebrow">Itletics 2.0</p>
          <h1>Anmelden</h1>
          <p className="login-description">
            Melde dich mit einem vorhandenen Testuser an. Nach der Anmeldung stehen Rollen und Berechtigungen
            im Profilkontext der App zur Verfügung.
          </p>
        </div>

        <form className="login-form" onSubmit={handleSubmit}>
          <label htmlFor="loginName">Loginname</label>
          <input
            id="loginName"
            value={loginName}
            onChange={(event) => setLoginName(event.target.value)}
            placeholder="z.B. stefan"
            autoComplete="username"
            required
          />

          <label htmlFor="password">Passwort</label>
          <input
            id="password"
            type="password"
            value={password}
            onChange={(event) => setPassword(event.target.value)}
            placeholder="Passwort"
            autoComplete="current-password"
            required
          />

          <button type="submit" disabled={submitting || !loginName || !password}>
            {submitting ? 'Anmeldung läuft...' : 'Einloggen'}
          </button>
        </form>

        {error ? <p className="login-error">{error}</p> : null}

        <div className="login-test-users">
          <div className="login-test-users__header">
            <h2>Vorhandene Testuser</h2>
            {loadingUsers ? <span>Lade...</span> : <span>{testUsers.length} gefunden</span>}
          </div>

          <ul>
            {testUsers.map((user) => {
              const isSelected = user.loginName === selectedUser?.loginName;
              return (
                <li key={user.id}>
                  <button
                    type="button"
                    onClick={() => setLoginName(user.loginName)}
                    className={isSelected ? 'selected' : ''}
                  >
                    <span>{user.firstName} {user.lastName}</span>
                    <small>@{user.loginName} | {user.roleCount} Rollen | {user.permissionCount} Rechte</small>
                  </button>
                </li>
              );
            })}
          </ul>
        </div>
      </div>
    </div>
  );
}

export default LoginPage;
