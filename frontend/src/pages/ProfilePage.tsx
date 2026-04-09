import PageTemplate from './PageTemplate';

function ProfilePage() {
  return (
    <PageTemplate
      eyebrow="Account"
      title="Profilseite"
      description="Diese Beispielseite ist für persönliche Stammdaten, Rollen und Einstellungen gedacht. Nutzerbezogene Informationen können hier später aus dem Backend geladen werden."
      metrics={[
        { label: 'Profil', value: 'Persönlich', detail: 'Name, Rolle, Kontakt und Verein später dynamisch einbinden.' },
        { label: 'Rechte', value: 'Rollen', detail: 'Zugriffe nach Organisationsrolle sichtbar machen.' },
        { label: 'Einstellungen', value: 'UI', detail: 'Benachrichtigungen, Sprache und persönliche Präferenzen ergänzen.' },
      ]}
    />
  )
}

export default ProfilePage
