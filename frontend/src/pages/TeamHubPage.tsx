import PageTemplate from './PageTemplate';

function TeamHubPage() {
  return (
    <PageTemplate
      eyebrow="Teams"
      title="Teamverwaltung"
      description="Diese Übersichtsseite bündelt die künftigen Einstiege für Teamanlage und Teamverwaltung. Sie ist als Team-Hub innerhalb der Navigation gedacht."
      primaryAction={{ label: 'Team anlegen', to: '/teams/anlegen' }}
      metrics={[
        { label: 'Hub', value: '2 Wege', detail: 'Direkter Einstieg in Anlage und Verwaltung.' },
        { label: 'Rollen', value: 'Offen', detail: 'Trainer, Staff und Organisation können später getrennt werden.' },
        { label: 'Status', value: 'Flexibel', detail: 'Aktiv, pausiert oder archiviert je nach Datenmodell.' },
      ]}
    />
  );
}

export default TeamHubPage;
