import { useState } from 'react';

const useDesktopMenu = () => {
  const [isMenuOpen, setIsMenuOpen] = useState<boolean>(false);

  const openDesktopMenu = () => {
    const rootElement = document.getElementById('root');
    if (rootElement) {
      rootElement.classList.add('desktop-menu--opened');
    }
    setIsMenuOpen(true);
  };

  const closeDesktopMenu = () => {
    const rootElement = document.getElementById('root');
    if (rootElement) {
      rootElement.classList.remove('desktop-menu--opened');
    }
    setIsMenuOpen(false);
  };

  const toggleDesktopMenu = () => {
    if (isMenuOpen) {
      closeDesktopMenu();
    } else {
      openDesktopMenu();
    }
  };

  return { isMenuOpen, openDesktopMenu, closeDesktopMenu, toggleDesktopMenu };
};

export default useDesktopMenu;