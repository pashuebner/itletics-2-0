import Cards from '../contents/Cards';
import Card from '../contents/Card';
import type { ReactNode } from 'react';

type MetricValue = string | number;

export interface ManagementOverviewMetric {
  label: string;
  value: MetricValue;
  detail: string;
}

export interface ManagementOverviewItem {
  id: string | number;
  title: string;
  subtitle?: ReactNode;
  meta?: string[];
}

interface ManagementOverviewSection {
  title: string;
  description: string;
  items: ManagementOverviewItem[];
  emptyMessage: string;
}

interface ManagementOverviewProps {
  loading: boolean;
  error: string | null;
  metrics: ManagementOverviewMetric[];
  sections: ManagementOverviewSection[];
}

function ManagementOverview({ loading, error, metrics, sections }: ManagementOverviewProps) {
  return (
    <div className="management-overview">
      <Cards columns="3">
        {metrics.map((metric) => (
          <Card key={metric.label}>
            <span className="page-template__metric-label">{metric.label}</span>
            <span className="page-template__metric-value">{metric.value}</span>
            <p>{metric.detail}</p>
          </Card>
        ))}
      </Cards>

      {loading ? <p className="page-template__status">Daten werden geladen...</p> : null}
      {error ? <p className="page-template__status page-template__status--error">{error}</p> : null}

      {!loading && !error ? (
        <div className="page-template__data-grid">
          {sections.map((section) => (
            <section key={section.title} className="page-template__panel-section">
              <div className="page-template__panel-header">
                <h2>{section.title}</h2>
                <p>{section.description}</p>
              </div>

              {section.items.length > 0 ? (
                <div className="page-template__table-wrap">
                  <table className="page-template__table">
                    <thead>
                      <tr>
                        <th scope="col">Name</th>
                        <th scope="col">Weitere Informationen</th>
                        <th scope="col"></th>
                      </tr>
                    </thead>
                    <tbody>
                      {section.items.map((item) => (
                        <tr key={item.id}>
                          <td>
                            <strong>{item.title}</strong>
                          </td>
                          <td>{item.subtitle ?? ' - '}</td>
                          <td>
                            {item.meta && item.meta.length > 0 ? (
                              <div className="page-template__meta-list">
                                {item.meta.map((metaEntry) => (
                                  <span key={metaEntry} className="page-template__meta-chip">
                                    {metaEntry}
                                  </span>
                                ))}
                              </div>
                            ) : ' - '}
                          </td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              ) : (
                <p className="page-template__empty">{section.emptyMessage}</p>
              )}
            </section>
          ))}
        </div>
      ) : null}
    </div>
  );
}

export default ManagementOverview;