import Button from '../components/contents/Button';
import Card from '../components/contents/Card';
import Cards from '../components/contents/Cards';
import './PageTemplate.css';

interface PageTemplateProps {
  eyebrow: string;
  title: string;
  description: string;
  children?: React.ReactNode;
  primaryAction?: {
    label: string;
    to: string;
  };
  secondaryAction?: {
    label: string;
    to: string;
  };
  metrics?: Array<{
    label: string;
    value: string;
    detail: string;
  }>;
}

function PageTemplate({
  eyebrow,
  title,
  description,
  children,
  primaryAction,
  secondaryAction,
  metrics,
}: PageTemplateProps) {
  return (
    <div className="page-template">
      <section className="page-template__hero">
        <p className="page-template__eyebrow">{eyebrow}</p>
        <h1>{title}</h1>
        <p>{description}</p>
        <div className="page-template__actions">
          {primaryAction ? (
            <Button aLink={primaryAction.to} buttonClass="primary">
              {primaryAction.label}
            </Button>
          ) : null}
          {secondaryAction ? (
            <Button aLink={secondaryAction.to} buttonClass="secondary">
              {secondaryAction.label}
            </Button>
          ) : null}
        </div>
      </section>

      {metrics && (
        <Cards columns="3">
          {metrics.map((metric) => (
            <Card key={metric.label}>
              <span className="page-template__metric-label">{metric.label}</span>
              <span className="page-template__metric-value">{metric.value}</span>
              <p>{metric.detail}</p>
            </Card>
          ))}
        </Cards>
      )}

      {children}
    </div>
  );
}

export default PageTemplate;