import React, { useState, useEffect } from 'react';
import { Routes, Route, useLocation } from 'react-router-dom';
import './Content.css'
import LoadingBar from '../../components/LoadingBar'; // Ladebalken importieren

import Dashboard from '../../pages/Dashboard';
import Ligenverwaltung from '../../pages/Ligenverwaltung';
import Turnierverwaltung from '../../pages/Turnierverwaltung';

const Content: React.FC = () => {
  const [loading, setLoading] = useState(false);
  const location = useLocation(); // Überwacht den Pfad

  useEffect(() => {
    setLoading(true);
    // Simuliere das Laden der neuen Route
    const timeout = setTimeout(() => {
      setLoading(false);
    }, 1000); // Angepasste Ladezeit oder API-Anfragen einfügen

    return () => clearTimeout(timeout); // Aufräumen des Timers
  }, [location]); // Jedes Mal ausführen, wenn sich der Pfad ändert

  return (
    <>
      <div id='content'>
        <LoadingBar loading={loading} />
        <div className='content-inner'>
          <Routes>
            <Route path="/" element={<Dashboard />} />
            <Route path="/ligenverwaltung" element={<Ligenverwaltung />} />
            <Route path="/turnierverwaltung" element={<Turnierverwaltung />} />
          </Routes>
        </div>
      </div>
    </>
  );
};

export default Content;
