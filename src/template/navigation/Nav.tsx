import './Nav.css'
import React from 'react';
import useWindowSize from '../../functions/useWindowSize';
import ThemeSwitcher from '../../components/ThemeSwitcher';
import Menu from './Menu';

const Nav: React.FC = () => {
  const isSmallScreen = useWindowSize(899);
  return (
    <>
      <nav className={isSmallScreen ? 'mobile-menu' : ''}>
        <Menu/>
        <ThemeSwitcher/>
      </nav>
    </>
  )
}

export default Nav
