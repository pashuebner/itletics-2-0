import './Dashboard.css';
import Cards from '../components/contents/Cards';
import Card from '../components/contents/Card';
import Button from '../components/contents/Button';
import Slider from '../components/Slider';
import { FaCheckCircle, FaFutbol, FaTrophy, FaQuestion, FaHockeyPuck } from 'react-icons/fa';
import { FaCircleXmark, FaPeopleGroup } from 'react-icons/fa6';
import InputAi from '../components/contents/InputAi';
function Dashboard() {

  return (
    <>
        <h1>Dashboard</h1>
        <Cards disableOn="mobile" columns="4">
          <Card>
            <Button aLink="/Turnierverwaltung" dataType='icon'><FaTrophy/>
            <h3>Turnier</h3>
            Erstelle jetz dein Turnier.
            </Button>
          </Card>
          <Card>
            <Button aLink="/Turnierverwaltung" dataType='icon' ><FaHockeyPuck/>
            <h3>Liga</h3>
            Starte deine neue Saison.
            </Button>
          </Card>
          <Card>
            <Button aLink="/Turnierverwaltung" dataType='icon'><FaPeopleGroup/>
            <h3>Team</h3>
            Baue deine Teams hier auf.
            </Button>
          </Card>
          <Card>
            <Button aLink="/Turnierverwaltung" dataType='icon'><FaQuestion/>
            <h3>Hilfecenter</h3>
            Frage gleich unsere neue itletics-ki.
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
            <Button aLink="/Turnierverwaltung" buttonClass='secondary'>Verwalten</Button>
          </Card>
          <Card>
            <h3>36. IHHC 2024</h3>
            <ul>
              <li>31.10.24 - 20.11.24</li>
              <li>BLZ Arena</li>
              <li>19 / 21</li>
              <li><FaCircleXmark></FaCircleXmark></li>
            </ul>
            <Button aLink="/Turnierverwaltung" buttonClass='secondary'>Verwalten</Button>
          </Card>
          <Card>
            <h3>36. IHHC 2024</h3>
            <ul>
              <li>31.10.24 - 20.11.24</li>
              <li>BLZ Arena</li>
              <li>19 / 21</li>
              <li><FaCheckCircle></FaCheckCircle></li>
            </ul>
            <Button aLink="/Turnierverwaltung" buttonClass='secondary'>Verwalten</Button>
          </Card>
        </Slider>
        <Slider>
        </Slider>
        </Cards>
        <h2>Support</h2>
        <Cards columns="3">
          <Card>
              <InputAi type='help'>
              </InputAi>
            </Card>
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

export default Dashboard
