import Cards from '../contents/Cards';
import Card from '../contents/Card';

type MetricValue = string | number;

export interface ManagementOverviewMetric {
  label: string;
  value: MetricValue;
  detail: string;
}

export interface ManagementOverviewItem {
  id: string | number;
  title: string;
  subtitle?: string;
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
            <section key={section.title} className="page-template__panel">
              <div className="page-template__panel-header">
                <h2>{section.title}</h2>
                <p>{section.description}</p>
              </div>

              {section.items.length > 0 ? (
                <div className="page-template__list">
                  {section.items.map((item) => (
                    <article key={item.id} className="page-template__list-item">
                      <div>
                        <h3>{item.title}</h3>
                        {item.subtitle ? <p>{item.subtitle}</p> : null}
                      </div>
                      {item.meta && item.meta.length > 0 ? (
                        <div className="page-template__meta-list">
                          {item.meta.map((metaEntry) => (
                            <span key={metaEntry} className="page-template__meta-chip">
                              {metaEntry}
                            </span>
                          ))}
                        </div>
                      ) : null}
                    </article>
                  ))}
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