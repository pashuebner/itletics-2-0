import PageTemplate from './PageTemplate';

function TeamCreatePage() {
  return (
    <>
    <PageTemplate
      eyebrow="Teams"
      title="Team anlegen"
      description="Diese Beispielseite zeigt, wie ein künftiger Team-Anlegen-Flow im Frontend aufgebaut sein kann. Formulare, Rollen und Vereinszuordnung werden später an die echte API angebunden."
      primaryAction={{ label: 'Teams verwalten', to: '/teams/verwalten' }}
      metrics={[
        { label: 'Schritt 1', value: 'Stammdaten', detail: 'Name, Sportart und interne Kennung des Teams erfassen.' },
        { label: 'Schritt 2', value: 'Kader', detail: 'Trainer, Staff und erste Mitglieder strukturiert hinzufügen.' },
        { label: 'Schritt 3', value: 'Freigabe', detail: 'Validierung und Übergabe an die Verwaltungsorganisation.' },
      ]}
    />
    <form>

    </form>
    </>
  );
}

export default TeamCreatePage;
