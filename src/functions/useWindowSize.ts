import { useState, useEffect } from 'react';

const useWindowSize = (breakpoint: number) => {
  const [isSmallScreen, setIsSmallScreen] = useState<boolean>(window.innerWidth < breakpoint);

  useEffect(() => {
    const handleResize = () => {
      setIsSmallScreen(window.innerWidth < breakpoint);
    };

    // Initial check
    handleResize();

    // Add event listener
    window.addEventListener('resize', handleResize);

    // Clean up event listener
    return () => {
      window.removeEventListener('resize', handleResize);
    };
  }, [breakpoint]);

  return isSmallScreen;
};

export default useWindowSize;
