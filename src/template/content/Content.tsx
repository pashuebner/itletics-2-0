import React from 'react';
import { Routes, Route } from 'react-router-dom';
import './Content.css'

import Dasboard from '../../pages/Dashboard';
import Ligenverwaltung from '../../pages/Ligenverwaltung';
import Turnierverwaltung from '../../pages/Turnierverwaltung';

const Content: React.FC = () => {
  return (
    <>
      <div id='content'>
        <div className='content-inner'>
          <Routes>
            <Route path="/" element={<Dasboard />} />
            <Route path="/ligenverwaltung" element={<Ligenverwaltung />} />
            <Route path="/turnierverwaltung" element={<Turnierverwaltung />} />
          </Routes>
        </div>
      </div>
    </>
  )
}

export default Content
