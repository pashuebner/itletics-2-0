import PageTemplate from './PageTemplate';

function LeagueCreatePage() {
  return (
    <PageTemplate
      eyebrow="Ligen"
      title="Liga anlegen"
      description="Diese Beispielseite bereitet einen künftigen Liga-Erstellungsprozess vor. Saisonstruktur, Spielbetrieb und Zuordnungen lassen sich später an das finale Backend anbinden."
      primaryAction={{ label: 'Ligen verwalten', to: '/ligen/verwalten' }}
      metrics={[
        { label: 'Saison', value: 'Setup', detail: 'Rahmendaten, Klassen und Zeiträume vorbereiten.' },
        { label: 'Teilnehmer', value: 'Clubs', detail: 'Teams oder Vereine der Liga zuordnen.' },
        { label: 'Spielplan', value: 'Regeln', detail: 'Runden, Punktewertung und Sonderfälle definieren.' },
      ]}
    />
  );
}

export default LeagueCreatePage;
