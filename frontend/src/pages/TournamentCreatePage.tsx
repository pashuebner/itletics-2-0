import PageTemplate from './PageTemplate';
import '../template/css/Form.css'
function TournamentCreatePage() {
  return (
    <>
      <PageTemplate
        eyebrow="Turniere"
        title="Turnier anlegen"
        description="Diese Seite skizziert einen künftigen Anlegen-Flow für Turniere. Struktur, Spielmodus und Freigabe können später direkt mit dem Backend verbunden werden."
        primaryAction={{ label: 'Turniere verwalten', to: '/turniere/verwalten' }}
        metrics={[
          { label: 'Setup', value: 'Format', detail: 'Ligaformat, Gruppenphase oder K.-o.-System vorbereiten.' },
          { label: 'Organisation', value: 'Teams', detail: 'Einladungen, Slots und Warteliste als spätere Module planen.' },
          { label: 'Betrieb', value: 'Ablauf', detail: 'Zeitslots, Orte und Ansprechpartner strukturiert definieren.' },
        ]}
      />
      {/* Create Tournament Form */}
        <form className="ui-form tournament-create-form">
          <h2>Turnier anlegen</h2>
          <div className="ui-form__row">
            <div className="ui-form__col">
              <label className="ui-field__label" htmlFor="tournament-name">Name des Turniers</label>
              <input className="ui-control" type="text" id="tournament-name" name="tournamentName" placeholder="z.B. Sommerturnier 2024" />
            </div>
          </div>
        </form>  
    </>
  );
}

export default TournamentCreatePage;
