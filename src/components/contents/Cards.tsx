import React from 'react';
import './Cards.css';
interface CardsProps {
  columns?: string;
  bgColor?:string;
  children: React.ReactNode;
}

const Cards: React.FC<CardsProps> = ({ columns = '', bgColor = '',children }) => {
  return (
    <div data-column={columns} data-bg={bgColor} className="cards">
      {children}
    </div>
  );
};

export default Cards;
