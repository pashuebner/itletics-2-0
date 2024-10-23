import './Button.css';
import React from 'react';
import { NavLink } from 'react-router-dom';

interface CardsProps {
  aLink?: string;
  buttonClass?: string;
  dataType?: string;
  children: React.ReactNode;
}

const Cards: React.FC<CardsProps> = ({ dataType, buttonClass, aLink = '', children }) => {
  return (
    <button className={buttonClass} data-type={dataType}>
      <span>
        <NavLink to={aLink}>
            {children}
        </NavLink>
        </span>
    </button>
  );
};

export default Cards;
