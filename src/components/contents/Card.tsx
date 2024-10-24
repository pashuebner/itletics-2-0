import React from 'react';
import './Card.css';
interface CardProps {
  children: React.ReactNode;
  bgColor?: string;
}

const Card: React.FC<CardProps> = ({ children, bgColor ='' }) => {
  return (
    <div className="card" style={{background:bgColor}}>
      <div className='card-inner' style={{background:bgColor}}>
        {children}
      </div>
    </div>
  );
};

export default Card;
