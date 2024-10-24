import React from 'react';
import './Cards.css';
import useWindowSize from '../../functions/useWindowSize';

interface CardsProps {
  columns?: string;
  bgColor?: string;
  disableOn?: string;
  children: React.ReactNode;
}

const Cards: React.FC<CardsProps> = ({ disableOn= '', columns = '', bgColor = '', children }) => {
  const isMobile = useWindowSize(899);

  if ((disableOn === 'mobile' && isMobile) || (disableOn === 'desktop' && !isMobile)) {
    return null;
  }

  return (
    <div data-column={columns} data-bg={bgColor} className="cards">
      {children}
    </div>
  );
};

export default Cards;
