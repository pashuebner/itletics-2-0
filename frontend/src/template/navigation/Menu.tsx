import './Menu.css';
import React, { useEffect, useRef } from 'react';
import { NavLink } from 'react-router-dom';
import { FaTachometerAlt, FaTrophy, FaChevronLeft, FaHockeyPuck, FaBook, FaSignOutAlt } from 'react-icons/fa';
import logo from '../../assets/logo.png';
import useWindowSize from '../../functions/useWindowSize';
import useMobileMenu from '../../functions/useMobileMenu';
import useDesktopMenu from '../../functions/useDesktopMenu';
import { FaPeopleGroup, FaPerson } from 'react-icons/fa6';
import { useAuth } from '../../auth/AuthContext';


const Menu: React.FC = () => {
const { closeMobileMenu } = useMobileMenu();
const { closeDesktopMenu, toggleDesktopMenu } = useDesktopMenu();
const { isAuthenticated, logout } = useAuth();
const isSmallScreen = useWindowSize(899);
const menuRef = useRef<HTMLDivElement | null>(null);

  useEffect(() => {
    const handleOutsideClick = (event: MouseEvent) => {
      const menuElement = menuRef.current;
      if (!menuElement) {
        return;
      }

      const target = event.target;
      if (!(target instanceof Node)) {
        return;
      }

      const navElement = menuElement.closest('nav');
      if (navElement?.contains(target)) {
        return;
      }

      if (menuElement.contains(target)) {
        return;
      }

      const rootElement = document.getElementById('root');
      if (!rootElement) {
        return;
      }

      if (isSmallScreen && rootElement.classList.contains('mobile-menu--open')) {
        closeMobileMenu();
      }

      if (!isSmallScreen && rootElement.classList.contains('desktop-menu--opened')) {
        closeDesktopMenu();
      }
    };

    document.addEventListener('mousedown', handleOutsideClick);

    return () => {
      document.removeEventListener('mousedown', handleOutsideClick);
    };
  }, [closeDesktopMenu, closeMobileMenu, isSmallScreen]);

  return (
    <>
      <div className='menu-wrapper' ref={menuRef}>
        { isSmallScreen === false &&
          <div className='close-desktop-menu' onClick={toggleDesktopMenu}><FaChevronLeft className="nav-icon" /></div>
        }
        <div className="menu-logo">
          <NavLink to="/"><img src={logo} alt="Logo" /></NavLink>
        </div>
        <ul className="nav-list">
          {isAuthenticated ? (
            <>
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
              to="/teams/verwalten" 
              className={({ isActive }) => isActive ? 'nav-link active' : 'nav-link'}
            >
              <FaPeopleGroup className="nav-icon" />
              <span>Teamverwaltung</span>
            </NavLink>
          </li>
          <li className="nav-item" onClick={closeMobileMenu}>
            <NavLink 
              to="/turniere/verwalten" 
              className={({ isActive }) => isActive ? 'nav-link active' : 'nav-link'}
            >
              <FaTrophy className="nav-icon" />
              <span>Turnierverwaltung</span>
            </NavLink>
          </li>
          <li className="nav-item" onClick={closeMobileMenu}>
            <NavLink 
              to="/ligen/verwalten" 
              className={({ isActive }) => isActive ? 'nav-link active' : 'nav-link'}
            >
              <FaHockeyPuck className="nav-icon" />
              <span>Ligenverwaltung</span>
            </NavLink>
          </li>
          <li className="nav-item" onClick={closeMobileMenu}>
            <NavLink
              to="/profil"
              className={({ isActive }) => isActive ? 'nav-link active' : 'nav-link'}
              >
                <FaPerson className="nav-icon" />
                <span>Profil</span>
              </NavLink>
          </li>
          <li className="nav-item">
            <a className="nav-link" style={{cursor:"pointer"}} onClick={logout}>
                <FaSignOutAlt className="nav-icon" />
                <span>Logout</span>
                </a>
              </li>
          </>
          ) : (
            <>
              <li className="nav-item" onClick={closeMobileMenu}>
                <NavLink 
                  to="/"
                  className={({ isActive }) => isActive ? 'nav-link active' : 'nav-link'}
                >
                  <FaPerson className="nav-icon" />
                  <span>Login</span>
                </NavLink>
              </li>
              <li className="nav-item" onClick={closeMobileMenu}>
                <NavLink
                to="/impressum" className={({ isActive }) => isActive ? 'nav-link active' : 'nav-link'}
                >
                  <FaBook className="nav-icon" />
                  <span>Impressum</span>
                </NavLink>
              </li>
              <li className="nav-item" onClick={closeMobileMenu}>
                <NavLink
                to="/datenschutz" className={({ isActive }) => isActive ? 'nav-link active' : 'nav-link'}
                >
                  <FaBook className="nav-icon" />
                  <span>Datenschutz</span>
                </NavLink>
              </li>
            </>
          )}
        </ul>
      </div>
    </>
  );
}

export default Menu;
