// Slider.tsx
import React, { useState, useRef } from 'react';
import { FaChevronLeft, FaChevronRight } from 'react-icons/fa';
import './Slider.css';
import Button from './contents/Button';

interface SliderProps {
  children?: React.ReactNode;
}

const Slider: React.FC<SliderProps> = ({ children }) => {
  const [currentIndex, setCurrentIndex] = useState(0);
  const [isDragging, setIsDragging] = useState(false);
  const [startPos, setStartPos] = useState(0);
  const [currentTranslate, setCurrentTranslate] = useState(0);
  const [prevTranslate, setPrevTranslate] = useState(0);
  const sliderRef = useRef<HTMLDivElement>(null);
  const totalSlides = React.Children.count(children);

  const handleMouseDown = (e: React.MouseEvent) => {
    setIsDragging(true);
    setStartPos(e.clientX);
  };

  const handleTouchStart = (e: React.TouchEvent) => {
    setIsDragging(true);
    setStartPos(e.touches[0].clientX);
  };

  const handleMouseMove = (e: React.MouseEvent) => {
    if (!isDragging) return;
    const currentPosition = e.clientX;
    const translateValue = prevTranslate + currentPosition - startPos;
    setCurrentTranslate(translateValue);
  };

  const handleTouchMove = (e: React.TouchEvent) => {
    if (!isDragging) return;
    const currentPosition = e.touches[0].clientX;
    const translateValue = prevTranslate + currentPosition - startPos;
    setCurrentTranslate(translateValue);
  };

  const handleMouseUp = () => {
    setIsDragging(false);
    const movedBy = currentTranslate - prevTranslate;

    if (movedBy < -10 && currentIndex < totalSlides - 1) {
      handleNext();
    } else if (movedBy > 10 && currentIndex > 0) {
      handlePrev();
    } else {
      setCurrentTranslate(-currentIndex * sliderRef.current!.offsetWidth);
    }
  };

  const handleTouchEnd = () => handleMouseUp();

  // Arrow navigation handlers
  const handleNext = () => {
    if (currentIndex < totalSlides - 1) {
      setCurrentIndex(currentIndex + 1);
      const newTranslate = -((currentIndex + 1) * sliderRef.current!.offsetWidth);
      setPrevTranslate(newTranslate);
      setCurrentTranslate(newTranslate);
    }
  };

  const handlePrev = () => {
    if (currentIndex > 0) {
      setCurrentIndex(currentIndex - 1);
      const newTranslate = -((currentIndex - 1) * sliderRef.current!.offsetWidth);
      setPrevTranslate(newTranslate);
      setCurrentTranslate(newTranslate);
    }
  };

  return (
    <div className="slider-wrapper">
      <div className="slider-container">
        {React.Children.count(children) > 0 ? (
          <div
            className="card-slider"
            style={{
              left: `calc(${currentTranslate}px - (.5rem + 2px) - ((.5rem + 2px) * (${currentIndex} * 2)))`,
              transition: !isDragging
                ? 'left 0.3s ease-out, padding 0.3s ease'
                : 'none',
            }}
            ref={sliderRef}
            onMouseDown={handleMouseDown}
            onMouseMove={handleMouseMove}
            onMouseUp={handleMouseUp}
            onMouseLeave={handleMouseUp}
            onTouchStart={handleTouchStart}
            onTouchMove={handleTouchMove}
            onTouchEnd={handleTouchEnd}
          >
            {React.Children.map(children, (child, index) => (
              <div
                key={index}
                className={`card ${index === currentIndex ? 'active' : ''}`}
              >
                {child}
              </div>
            ))}
          </div>
        ) : (
          <div className="placeholder-for-slides">
            <p>Noch kein Turnier angelegt?</p>
            <Button aLink="/Turnierverwaltung">Turnier anlegen</Button>
          </div>
        )}
      </div>

      {React.Children.count(children) > 0 && (
        <>
          {currentIndex > 0 && (
            <div className="slider-nav--prev" onClick={handlePrev}>
              <FaChevronLeft className="nav-icon" />
            </div>
          )}
          {currentIndex < totalSlides - 1 && (
            <div className="slider-nav--next" onClick={handleNext}>
              <FaChevronRight className="nav-icon" />
            </div>
          )}
        </>
      )}
    </div>
  );
};

export default Slider;
