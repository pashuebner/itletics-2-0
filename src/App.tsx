
import React from 'react';
import { BrowserRouter as Router } from 'react-router-dom';
import './App.css'
import Header from './template/header/Header.tsx'
import Nav from './template/navigation/Nav.tsx'
import Sidebar from './template/content/Sidebar.tsx'
import Footer from './template/Footer.tsx'
import Content from './template/content/Content.tsx'
import IconChanger from './template/header/Favicon.tsx'
import { HelmetProvider } from 'react-helmet-async';
import MobileNavBar from './template/navigation/MobileNavBar.tsx';


const App: React.FC = () => {
  return (
    <>
    <Router>
      <HelmetProvider>
        <IconChanger/>
        <MobileNavBar/>
        <Header />
        <Nav />
        <Content />
        <Sidebar />
        <Footer />
      </HelmetProvider>
    </Router>
    </>
  )
}

export default App
