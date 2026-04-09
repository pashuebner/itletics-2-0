import React, { useState, useEffect } from 'react';
import { Routes, Route, Navigate, useLocation } from 'react-router-dom';
import './Content.css'
import LoadingBar from '../../components/LoadingBar'; // Ladebalken importieren

import DashboardPage from '../../pages/DashboardPage';
import ProfilePage from '../../pages/ProfilePage';
import TeamCreatePage from '../../pages/TeamCreatePage';
import TeamManagementPage from '../../pages/TeamManagementPage';
import TeamHubPage from '../../pages/TeamHubPage';
import LeagueCreatePage from '../../pages/LeagueCreatePage';
import LeagueManagementPage from '../../pages/LeagueManagementPage';
import TournamentCreatePage from '../../pages/TournamentCreatePage';
import TournamentManagementPage from '../../pages/TournamentManagementPage';
import EntryPage from '../../pages/EntryPage';
import { useAuth } from '../../auth/AuthContext';

const Content: React.FC = () => {
  const [loading, setLoading] = useState(false);
  const location = useLocation(); // Überwacht den Pfad
  const { isAuthenticated } = useAuth();

  if (!isAuthenticated) {
    return(
     <>
    <LoadingBar loading={loading} />
      <div id='content'>
        <div className='content-inner'>
          <EntryPage />
        </div>
      </div>
    </>
    )
  }

  useEffect(() => {
    setLoading(true);
    // Simuliere das Laden der neuen Route
    const timeout = setTimeout(() => {
      setLoading(false);
    }, 100); // Angepasste Ladezeit oder API-Anfragen einfügen

    return () => clearTimeout(timeout); // Aufräumen des Timers
  }, [location]); // Jedes Mal ausführen, wenn sich der Pfad ändert

  return (
    <>
    <LoadingBar loading={loading} />
      <div id='content'>
        <div className='content-inner'>
          <Routes>
            <Route path="/" element={<DashboardPage />} />
            <Route path="/profil" element={<ProfilePage />} />
            <Route path="/teamverwaltung" element={<Navigate to="/teams/verwalten" replace />} />
            <Route path="/teams/anlegen" element={<TeamCreatePage />} />
            <Route path="/teams/verwalten" element={<TeamManagementPage />} />
            <Route path="/teams/verwalten/:teamId" element={<TeamHubPage />} />
            <Route path="/ligen/anlegen" element={<LeagueCreatePage />} />
            <Route path="/ligen/verwalten" element={<LeagueManagementPage />} />
            <Route path="/turniere/anlegen" element={<TournamentCreatePage />} />
            <Route path="/turniere/verwalten" element={<TournamentManagementPage />} />
          </Routes>
        </div>
      </div>
    </>
  );
};

export default Content;
