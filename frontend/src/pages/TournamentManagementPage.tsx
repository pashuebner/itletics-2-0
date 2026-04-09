import { useEffect, useState } from 'react';
import ManagementOverview, { type ManagementOverviewItem, type ManagementOverviewMetric } from '../components/management/ManagementOverview';
import { apiManagement } from '../api';
import type { DatabaseRowsResponse } from '../api';
import PageTemplate from './PageTemplate';

interface TournamentRow extends Record<string, unknown> {
  tournament_id: number;
  description: string;
  start_date: string;
  end_date: string;
  max_no_teams: number;
  is_public_visible: number;
}

function buildMeta(entries: Array<string | null | undefined | false>): string[] {
  return entries.filter(Boolean) as string[];
}

function formatDateRange(startDate: string, endDate: string): string {
  const start = startDate ? new Date(startDate).toLocaleDateString('de-DE') : 'offen';
  const end = endDate ? new Date(endDate).toLocaleDateString('de-DE') : 'offen';
  return `${start} – ${end}`;
}

function TournamentManagementPage() {
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [metrics, setMetrics] = useState<ManagementOverviewMetric[]>([
    { label: 'Turniere gesamt', value: '-', detail: 'Alle angelegten Turniere in der Datenbank.' },
  ]);
  const [sections, setSections] = useState<Array<{ title: string; description: string; items: ManagementOverviewItem[]; emptyMessage: string }>>([]);

  useEffect(() => {
    let isMounted = true;

    async function loadTournamentOverview() {
      setLoading(true);
      setError(null);

      try {
        const raw = await apiManagement.tournaments.list({ limit: 100, sortBy: 'tournament_id' });
        const tournamentsResponse = raw as unknown as DatabaseRowsResponse<TournamentRow>;

        if (!isMounted) {
          return;
        }

        const publicCount = tournamentsResponse.rows.filter((t) => t.is_public_visible === 1).length;

        const dynamicMetrics: ManagementOverviewMetric[] = [
          { label: 'Turniere gesamt', value: tournamentsResponse.total, detail: 'Alle angelegten Turniere in der Datenbank.' },
        ];
        if (publicCount > 0) {
          dynamicMetrics.push({ label: 'Öffentlich', value: publicCount, detail: 'Turniere, die öffentlich sichtbar sind.' });
        }
        setMetrics(dynamicMetrics);

        setSections([
          {
            title: 'Alle Turniere',
            description: 'Wähle ein Turnier aus, um Stufen, Teams und Details einzusehen.',
            emptyMessage: 'Keine Turniere gefunden.',
            items: tournamentsResponse.rows.map((tournament) => ({
              id: tournament.tournament_id,
              title: tournament.description,
              subtitle: formatDateRange(tournament.start_date, tournament.end_date),
              meta: buildMeta([
                `Max. ${tournament.max_no_teams} Teams`,
                tournament.is_public_visible === 1 ? 'Öffentlich' : 'Nicht öffentlich',
              ]),
            })),
          },
        ]);
      } catch (loadError) {
        if (!isMounted) {
          return;
        }

        setError(loadError instanceof Error ? loadError.message : 'Die Turnierdaten konnten nicht geladen werden.');
      } finally {
        if (isMounted) {
          setLoading(false);
        }
      }
    }

    void loadTournamentOverview();

    return () => {
      isMounted = false;
    };
  }, []);

  return (
    <PageTemplate
      eyebrow="Turniere"
      title="Turniere verwalten"
      description="Alle Turniere auf einen Blick. Wähle ein Turnier aus, um Stufen, Teilnehmerteams und Details einzusehen."
      primaryAction={{ label: 'Turnier anlegen', to: '/turniere/anlegen' }}
    >
      <ManagementOverview loading={loading} error={error} metrics={metrics} sections={sections} />
    </PageTemplate>
  );
}

export default TournamentManagementPage;
