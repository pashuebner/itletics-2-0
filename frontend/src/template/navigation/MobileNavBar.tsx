import './MobileNavBar.css'
import React from 'react';
import { NavLink } from 'react-router-dom';
import { FaBars, FaHome, FaPlus, FaUser} from 'react-icons/fa';
import useWindowSize from '../../functions/useWindowSize';
import useMobileMenu from '../../functions/useMobileMenu';
import { FaGear } from 'react-icons/fa6';



const MobileNavBar: React.FC = () =>{
    const { openMobileMenu } = useMobileMenu();
    
    const isSmallScreen = useWindowSize(899);

    if (!isSmallScreen) {
        return null;
      }

    return (
    <>
      <div className="mobile-navbar">
        <div><NavLink to="/"><FaHome className="navbar-icon" /></NavLink></div>
        <div><NavLink to="/turniere/anlegen"><FaPlus className="navbar-icon" /></NavLink></div>
        <div id="menu-button" onClick={openMobileMenu}><FaBars className="navbar-icon" /></div>
        <div><NavLink to="/profil"><FaUser className="navbar-icon" /></NavLink></div>
        <div><NavLink to="/teams/verwalten"><FaGear className="navbar-icon" /></NavLink></div>
      </div>
    </>
  )
}

export default MobileNavBar
