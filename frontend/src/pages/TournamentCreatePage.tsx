import { useState } from 'react';
import { ApiError, apiManagement } from '../api';
import PageTemplate from './PageTemplate';
import '../template/css/Form.css';
import './CreateEntityPage.css';

interface TournamentFormState {
  description: string;
  start_date: string;
  end_date: string;
  max_no_teams: string;
  is_score_mode: boolean;
  is_extended_mode: boolean;
  is_public_visible: boolean;
  score_mode_calculation_code: string;
}

function generateHashValue(): string {
  if (typeof crypto !== 'undefined' && typeof crypto.getRandomValues === 'function') {
    const bytes = new Uint8Array(32);
    crypto.getRandomValues(bytes);
    return Array.from(bytes, (byte) => byte.toString(16).padStart(2, '0')).join('');
  }

  const chars = 'abcdef0123456789';
  let result = '';
  for (let index = 0; index < 64; index += 1) {
    result += chars[Math.floor(Math.random() * chars.length)];
  }
  return result;
}

function toSqlDateTime(dateValue: string, fallbackTime: '00:00:00' | '23:59:59' = '00:00:00'): string {
  return `${dateValue} ${fallbackTime}`;
}

function getTodayDateValue(): string {
  return new Date().toISOString().slice(0, 10);
}

function createInitialTournamentState(): TournamentFormState {
  const today = getTodayDateValue();
  return {
    description: '',
    start_date: today,
    end_date: today,
    max_no_teams: '8',
    is_score_mode: false,
    is_extended_mode: false,
    is_public_visible: false,
    score_mode_calculation_code: '0',
  };
}

function TournamentCreatePage() {
  const [formState, setFormState] = useState<TournamentFormState>(() => createInitialTournamentState());
  const [submitting, setSubmitting] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [success, setSuccess] = useState<string | null>(null);

  const canSubmit = Boolean(
    !submitting
    && formState.description.trim()
    && formState.start_date
    && formState.end_date
    && Number(formState.max_no_teams) > 0
    && formState.score_mode_calculation_code !== ''
  );

  const updateField = <K extends keyof TournamentFormState>(field: K, value: TournamentFormState[K]) => {
    setFormState((previous) => ({ ...previous, [field]: value }));
  };

  const handleSubmit = async (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    setSubmitting(true);
    setError(null);
    setSuccess(null);

    try {
      const response = await apiManagement.tournaments.create({
        description: formState.description.trim(),
        start_date: toSqlDateTime(formState.start_date, '00:00:00'),
        end_date: toSqlDateTime(formState.end_date, '23:59:59'),
        max_no_teams: Number(formState.max_no_teams),
        is_score_mode: formState.is_score_mode ? 1 : 0,
        is_extended_mode: formState.is_extended_mode ? 1 : 0,
        is_public_visible: formState.is_public_visible ? 1 : 0,
        score_mode_calculation_code: Number(formState.score_mode_calculation_code),
        tournament_hash_value: generateHashValue(),
      });

      setSuccess(
        response.row?.tournament_id
          ? `Turnier erfolgreich angelegt (ID: ${String(response.row.tournament_id)}).`
          : 'Turnier erfolgreich angelegt.'
      );
      setFormState(createInitialTournamentState());
    } catch (submitError) {
      if (submitError instanceof ApiError) {
        setError(submitError.message);
      } else {
        setError(submitError instanceof Error ? submitError.message : 'Turnier konnte nicht angelegt werden.');
      }
    } finally {
      setSubmitting(false);
    }
  };

  return (
      <PageTemplate
        eyebrow="Turniere"
        title="Turnier anlegen"
        description="Erfasst die Kerndaten der Tabelle tournament."
        primaryAction={{ label: 'Turniere verwalten', to: '/turniere/verwalten' }}
      >
        <form className="ui-form entity-create-form" onSubmit={handleSubmit}>
          <h2>Turnier anlegen</h2>

          {error ? <p className="entity-create-form__message entity-create-form__message--error">{error}</p> : null}
          {success ? <p className="entity-create-form__message entity-create-form__message--success">{success}</p> : null}

          <div className="ui-form__row">
            <div className="ui-form__col ui-field">
              <label className="ui-field__label" htmlFor="tournament-name">Name *</label>
              <input
                className="ui-control"
                type="text"
                id="tournament-name"
                value={formState.description}
                onChange={(event) => updateField('description', event.target.value)}
                placeholder="z.B. Sommerturnier 2026"
                required
              />
            </div>
          </div>

          <div className="ui-form__row">
            <div className="ui-form__col ui-form__col--6 ui-field">
              <label className="ui-field__label" htmlFor="tournament-start-date">Startdatum *</label>
              <input
                className="ui-control"
                type="date"
                id="tournament-start-date"
                value={formState.start_date}
                onChange={(event) => updateField('start_date', event.target.value)}
                required
              />
            </div>

            <div className="ui-form__col ui-form__col--6 ui-field">
              <label className="ui-field__label" htmlFor="tournament-end-date">Enddatum *</label>
              <input
                className="ui-control"
                type="date"
                id="tournament-end-date"
                value={formState.end_date}
                onChange={(event) => updateField('end_date', event.target.value)}
                required
              />
            </div>
          </div>

          <div className="ui-form__row">
            <div className="ui-form__col ui-form__col--6 ui-field">
              <label className="ui-field__label" htmlFor="tournament-max-teams">Max. Anzahl an Teams *</label>
              <input
                className="ui-control"
                type="number"
                min={2}
                id="tournament-max-teams"
                value={formState.max_no_teams}
                onChange={(event) => updateField('max_no_teams', event.target.value)}
                required
              />
            </div>

            <div className="ui-form__col ui-form__col--6 ui-field">
              <label className="ui-field__label" htmlFor="tournament-score-code">Tabellenvergleich *</label>
              <select
                className="ui-control"
                id="tournament-score-code"
                value={formState.score_mode_calculation_code}
                onChange={(event) => updateField('score_mode_calculation_code', event.target.value)}
                required
              >
                <option value="0">Direkter Vergleich</option>
              </select>
              <span className="ui-field__hint">In der Datenbank ist das nur ein smallint. Der Seed nutzt aktuell den Wert 0, daher behandle ich 0 hier als Direkter Vergleich.</span>
            </div>
          </div>

          <fieldset>
            <legend>Optionen</legend>
            <div className="ui-checkgroup">
              <label className="ui-check" htmlFor="tournament-score-mode">
                <input
                  id="tournament-score-mode"
                  type="checkbox"
                  checked={formState.is_score_mode}
                  onChange={(event) => updateField('is_score_mode', event.target.checked)}
                />
                <span>3-Punkte Modus</span>
              </label>

              <label className="ui-check" htmlFor="tournament-public-visible">
                <input
                  id="tournament-public-visible"
                  type="checkbox"
                  checked={formState.is_public_visible}
                  onChange={(event) => updateField('is_public_visible', event.target.checked)}
                />
                <span>Öffentlich?</span>
              </label>

              <label className="ui-check" htmlFor="tournament-extended-mode">
                <input
                  id="tournament-extended-mode"
                  type="checkbox"
                  checked={formState.is_extended_mode}
                  onChange={(event) => updateField('is_extended_mode', event.target.checked)}
                />
                <span>Spielerkreuzung erlauben?</span>
              </label>
            </div>
          </fieldset>

          <div className="ui-form__actions">
            <button type="submit" disabled={!canSubmit}>
              <a>
              {submitting ? 'Wird erstellt...' : 'Turnier erstellen'}
              </a>
            </button>
          </div>
        </form>
      </PageTemplate>
  );
}

export default TournamentCreatePage;
