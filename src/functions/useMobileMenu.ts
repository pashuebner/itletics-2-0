import { useState } from 'react';

const useMobileMenu = () => {
  const [isMenuOpen, setIsMenuOpen] = useState<boolean>(false);

  const openMobileMenu = () => {
    const rootElement = document.getElementById('root');
    if (rootElement) {
      rootElement.classList.add('mobile-menu--open');
    }
    setIsMenuOpen(true);
  };

  const closeMobileMenu = () => {
    const rootElement = document.getElementById('root');
    if (rootElement) {
      rootElement.classList.remove('mobile-menu--open');
    }
    setIsMenuOpen(false);
  };

  const toggleMobileMenu = () => {
    if (isMenuOpen) {
      closeMobileMenu();
    } else {
      openMobileMenu();
    }
  };

  return { isMenuOpen, openMobileMenu, closeMobileMenu, toggleMobileMenu };
};

export default useMobileMenu;