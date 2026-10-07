import { useEffect, useState } from 'react';
import ManagementOverview, { type ManagementOverviewItem, type ManagementOverviewMetric } from '../components/management/ManagementOverview';
import { apiManagement } from '../api';
import type { DatabaseRowsResponse } from '../api';
import PageTemplate from './PageTemplate';

interface LeagueRow extends Record<string, unknown> {
  league_id: number;
  description: string;
  association_id: number;
  logo_path: string | null;
}

interface AssociationRow extends Record<string, unknown> {
  association_id: number;
  association: string;
}

function buildMeta(entries: Array<string | null | undefined | false>): string[] {
  return entries.filter(Boolean) as string[];
}

function LeagueManagementPage() {
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [metrics, setMetrics] = useState<ManagementOverviewMetric[]>([
    { label: 'Ligen gesamt', value: '-', detail: 'Alle angelegten Ligen im Ligamodul.' },
  ]);
  const [sections, setSections] = useState<Array<{ title: string; description: string; items: ManagementOverviewItem[]; emptyMessage: string }>>([]);

  useEffect(() => {
    let isMounted = true;

    async function loadLeagueOverview() {
      setLoading(true);
      setError(null);

      try {
        const [leagueRaw, associationsRaw] = await Promise.all([
          apiManagement.leagues.list({ limit: 100, sortBy: 'league_id' }),
          apiManagement.masterData.associations.list({ limit: 500, sortBy: 'association_id' }),
        ]);
        const leaguesResponse = leagueRaw as unknown as DatabaseRowsResponse<LeagueRow>;
        const associationsResponse = associationsRaw as unknown as DatabaseRowsResponse<AssociationRow>;

        const associationNameById = new Map<number, string>(
          associationsResponse.rows.map((row) => [Number(row.association_id), String(row.association)])
        );

        if (!isMounted) {
          return;
        }

        setMetrics([
          { label: 'Ligen gesamt', value: leaguesResponse.total, detail: 'Alle angelegten Ligen im Ligamodul.' },
        ]);

        setSections([
          {
            title: 'Alle Ligen',
            description: 'Wähle eine Liga aus, um Saisons, Teams, Spieltage und Details einzusehen.',
            emptyMessage: 'Keine Ligen gefunden.',
            items: leaguesResponse.rows.map((league) => ({
              id: league.league_id,
              title: league.description,
              subtitle: league.logo_path ? (
                <img
                  className="table_logo"
                  width={50}
                  height={50}
                  style={{objectFit:"contain"}}
                  src={league.logo_path}
                  alt={`Logo ${league.description}`}
                  loading="lazy"
                />
              ) : (
                <div style={{ width: 50, height: 50, backgroundColor: 'rgba(125, 125, 125, 0.2)', borderRadius: '50%' }} />
              ),
              meta: buildMeta([
                associationNameById.get(Number(league.association_id))
                  ? `Verband ${associationNameById.get(Number(league.association_id))}`
                  : `Verband-ID: ${league.association_id}`,
              ]),
            })),
          },
        ]);
      } catch (loadError) {
        if (!isMounted) {
          return;
        }

        setError(loadError instanceof Error ? loadError.message : 'Die Ligadaten konnten nicht geladen werden.');
      } finally {
        if (isMounted) {
          setLoading(false);
        }
      }
    }

    void loadLeagueOverview();

    return () => {
      isMounted = false;
    };
  }, []);

  return (
    <PageTemplate
      eyebrow="Ligen"
      title="Ligen verwalten"
      description="Alle Ligen auf einen Blick. Wähle eine Liga aus, um Saisons, Teams, Spieltage und Details einzusehen."
      primaryAction={{ label: 'Liga anlegen', to: '/ligen/anlegen' }}
    >
      <ManagementOverview loading={loading} error={error} metrics={metrics} sections={sections} />
    </PageTemplate>
  );
}

export default LeagueManagementPage;
