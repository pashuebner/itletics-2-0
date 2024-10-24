import './Menu.css';
import React from 'react';
import { NavLink } from 'react-router-dom';
import { FaTachometerAlt, FaTrophy, FaChevronLeft, FaHockeyPuck } from 'react-icons/fa';
import logo from '../../assets/logo.png';
import useWindowSize from '../../functions/useWindowSize';
import useMobileMenu from '../../functions/useMobileMenu';
import useDesktopMenu from '../../functions/useDesktopMenu';

const Menu: React.FC = () => {
const { closeMobileMenu } = useMobileMenu();
const { toggleDesktopMenu } = useDesktopMenu();
const isSmallScreen = useWindowSize(899);

  return (
    <>
      <div className='menu-wrapper' onClick={isSmallScreen ? closeMobileMenu : undefined}>
        { isSmallScreen === false &&
          <div className='close-desktop-menu' onClick={toggleDesktopMenu}><FaChevronLeft className="nav-icon" /></div>
        }
        <div className="menu-logo">
          <NavLink to="/"><img src={logo} alt="Logo" /></NavLink>
        </div>
       { isSmallScreen === true &&
          <div className='close-mobile-menu' onClick={closeMobileMenu}><FaChevronLeft className="nav-icon" /><FaChevronLeft className="nav-icon" /></div>
        }
        <ul className="nav-list">
          <li className="nav-item" onClick={closeMobileMenu}>
            <NavLink 
              to="/" 
              className={({ isActive }) => isActive ? 'nav-link active' : 'nav-link'}
              end
            >
              <FaTachometerAlt className="nav-icon" />
              <span>Dashboard</span>
            </NavLink>
          </li>
          <li className="nav-item" onClick={closeMobileMenu}>
            <NavLink 
              to="/Ligenverwaltung" 
              className={({ isActive }) => isActive ? 'nav-link active' : 'nav-link'}
            >
              <FaHockeyPuck className="nav-icon" />
              <span>Ligenverwaltung</span>
            </NavLink>
          </li>
          <li className="nav-item" onClick={closeMobileMenu}>
            <NavLink 
              to="/Turnierverwaltung" 
              className={({ isActive }) => isActive ? 'nav-link active' : 'nav-link'}
            >
              <FaTrophy className="nav-icon" />
              <span>Turnierverwaltung</span>
            </NavLink>
          </li>
        </ul>
      </div>
    </>
  );
}

export default Menu;
