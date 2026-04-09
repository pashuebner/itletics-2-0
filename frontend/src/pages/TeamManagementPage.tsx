import { useEffect, useState } from 'react';
import ManagementOverview, { type ManagementOverviewItem, type ManagementOverviewMetric } from '../components/management/ManagementOverview';
import { apiManagement } from '../api';
import type { DatabaseRowsResponse } from '../api';
import PageTemplate from './PageTemplate';

interface TeamRow extends Record<string, unknown> {
  team_id: number;
  team: string;
  no_players: number;
  league_id: number | null;
  club_id: number;
}

interface TournamentTeamRow extends Record<string, unknown> {
  tournament_to_team_id: number;
  tournament_id: number;
  team_id: number;
}

function buildMeta(entries: Array<string | null | undefined | false>): string[] {
  return entries.filter(Boolean) as string[];
}

function TeamManagementPage() {
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [metrics, setMetrics] = useState<ManagementOverviewMetric[]>([
    { label: 'Teams gesamt', value: '-', detail: 'Anzahl der verwalteten Teams in der Datenbank.' },
  ]);
  const [sections, setSections] = useState<Array<{ title: string; description: string; items: ManagementOverviewItem[]; emptyMessage: string }>>([]);

  useEffect(() => {
    let isMounted = true;

    async function loadTeamOverview() {
      setLoading(true);
      setError(null);

      try {
        const [rawTeamsResponse, rawTournamentTeamsResponse] = await Promise.all([
          apiManagement.teams.list({ limit: 100, sortBy: 'team_id' }),
          apiManagement.tournaments.teams.list({ limit: 500, sortBy: 'team_id' }),
        ]);

        const teamsResponse = rawTeamsResponse as unknown as DatabaseRowsResponse<TeamRow>;
        const tournamentTeamsResponse = rawTournamentTeamsResponse as unknown as DatabaseRowsResponse<TournamentTeamRow>;

        if (!isMounted) {
          return;
        }

        const tournamentCountByTeamId = new Map<number, number>();
        for (const tt of tournamentTeamsResponse.rows) {
          tournamentCountByTeamId.set(tt.team_id, (tournamentCountByTeamId.get(tt.team_id) ?? 0) + 1);
        }

        const withLeague = teamsResponse.rows.filter((t) => t.league_id != null).length;
        const withTournament = teamsResponse.rows.filter((t) => (tournamentCountByTeamId.get(t.team_id) ?? 0) > 0).length;

        const dynamicMetrics: ManagementOverviewMetric[] = [
          { label: 'Teams gesamt', value: teamsResponse.total, detail: 'Anzahl der verwalteten Teams in der Datenbank.' },
        ];
        if (withLeague > 0) {
          dynamicMetrics.push({ label: 'In Liga', value: withLeague, detail: 'Teams, die einer Liga zugeordnet sind.' });
        }
        if (withTournament > 0) {
          dynamicMetrics.push({ label: 'In Turnier', value: withTournament, detail: 'Teams, die aktuell einem Turnier zugeordnet sind.' });
        }
        setMetrics(dynamicMetrics);

        setSections([
          {
            title: 'Alle Teams',
            description: 'Klicke ein Team an, um Mitglieder, Rollen und Details einzusehen.',
            emptyMessage: 'Keine Teams gefunden.',
            items: teamsResponse.rows.map((team) => {
              const numTournaments = tournamentCountByTeamId.get(team.team_id) ?? 0;
              return {
                id: team.team_id,
                title: team.team,
                subtitle: team.league_id ? `Liga ${team.league_id}` : 'Keine Liga zugeordnet',
                meta: buildMeta([
                  `${team.no_players} Spieler`,
                  `Club ${team.club_id}`,
                  numTournaments > 0 ? `${numTournaments} Turnier${numTournaments > 1 ? 'e' : ''}` : false,
                ]),
              };
            }),
          },
        ]);
      } catch (loadError) {
        if (!isMounted) {
          return;
        }

        setError(loadError instanceof Error ? loadError.message : 'Die Teamdaten konnten nicht geladen werden.');
      } finally {
        if (isMounted) {
          setLoading(false);
        }
      }
    }

    void loadTeamOverview();

    return () => {
      isMounted = false;
    };
  }, []);

  return (
    <PageTemplate
      eyebrow="Teams"
      title="Teams verwalten"
      description="Alle Teams auf einen Blick. Wähle ein Team aus, um Mitglieder, Rollen und Details einzusehen."
      primaryAction={{ label: 'Neues Team anlegen', to: '/teams/anlegen' }}
    >
      <ManagementOverview loading={loading} error={error} metrics={metrics} sections={sections} />
    </PageTemplate>
  );
}

export default TeamManagementPage;
