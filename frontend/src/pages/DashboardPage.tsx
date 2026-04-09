import './Dashboard.css';
import Cards from '../components/contents/Cards';
import Card from '../components/contents/Card';
import Button from '../components/contents/Button';
import Slider from '../components/Slider';
import { FaCheckCircle, FaTrophy, FaQuestion, FaHockeyPuck } from 'react-icons/fa';
import { FaCircleXmark, FaPeopleGroup } from 'react-icons/fa6';
import PageTemplate from './PageTemplate';
function DashboardPage() {

  return (
    <>
        <PageTemplate
      eyebrow="Dashboard"
      title="Willkommen im Dashboard"
      description="Dein Dashboard zur zentralen Steuerung aller Funktionen. Hier findest du die wichtigsten Kennzahlen auf einen Blick und kannst direkt in die Verwaltung deiner Ligen, Teams und Turniere einsteigen."
      primaryAction={{ label: 'Ligen verwalten', to: '/ligen/verwalten' }}
    />
        <Cards disableOn="mobile" columns="4">
          <Card>
            <Button aLink="/turniere/anlegen" dataType='icon'><FaTrophy/>
            <h3>Turnier anlegen</h3>
            Starte den Beispiel-Flow für ein neues Turnier.
            </Button>
          </Card>
          <Card>
            <Button aLink="/ligen/anlegen" dataType='icon' ><FaHockeyPuck/>
            <h3>Liga anlegen</h3>
            Lege eine neue Saison oder Wettbewerbsklasse an.
            </Button>
          </Card>
          <Card>
            <Button aLink="/teams/anlegen" dataType='icon'><FaPeopleGroup/>
            <h3>Team anlegen</h3>
            Erstelle eine neue Teamstruktur als Beispielseite.
            </Button>
          </Card>
          <Card>
            <Button aLink="/profil" dataType='icon'><FaQuestion/>
            <h3>Profilseite</h3>
            Öffne die vorbereitete Beispielansicht für den Nutzerbereich.
            </Button>
          </Card>
        </Cards>
        <h2>Übersicht</h2>
        <Cards columns="2">
        <Slider>
          <Card>
            <h3>36. IHHC 2024</h3>
            <ul>
              <li>31.10.24 - 20.11.24</li>
              <li>BLZ Arena</li>
              <li>19 / 21</li>
              <li><FaCheckCircle></FaCheckCircle></li>
            </ul>
            <Button aLink="/turniere/verwalten" buttonClass='secondary'>Turniere verwalten</Button>
          </Card>
          <Card>
            <h3>36. IHHC 2024</h3>
            <ul>
              <li>31.10.24 - 20.11.24</li>
              <li>BLZ Arena</li>
              <li>19 / 21</li>
              <li><FaCircleXmark></FaCircleXmark></li>
            </ul>
            <Button aLink="/turniere/verwalten" buttonClass='secondary'>Turniere verwalten</Button>
          </Card>
          <Card>
            <h3>36. IHHC 2024</h3>
            <ul>
              <li>31.10.24 - 20.11.24</li>
              <li>BLZ Arena</li>
              <li>19 / 21</li>
              <li><FaCheckCircle></FaCheckCircle></li>
            </ul>
            <Button aLink="/turniere/verwalten" buttonClass='secondary'>Turniere verwalten</Button>
          </Card>
        </Slider>
        </Cards>
        <h2>Support</h2>
        <Cards columns="2">
              <Card>
                <h3>Technischer Support</h3>
                Hier kannst du dein Problem per Email mitteilen. Wir kontaktieren dich dann so schnell wie möglich.
                <br></br><br></br><a href='mailto:it@itletics.de'>it@itletics.de</a>
              </Card>
              <Card>
                <h3>Allgemeiner Support</h3>
                Hier findest du den direkten Kontakt zu uns. Wir stehen dir für alle Fragen zur Seite.
                <br></br><br></br><a href='mailto:info@itletics.de'>info@itletics.de</a>
            </Card>
          </Cards>
          <Cards columns='1' alignText="center">
            <Card bgColor='transparent'>
            <h3>Impressum und Datenschutz</h3>
                Alles was du über uns und unsere Datenverarbeitung wissen musst, findest du hier.
                <p><a href='#'>Impressum</a> | <a href='#'>Datenschutz</a></p>
            </Card>
          </Cards>
    </>
  )
}

export default DashboardPage
