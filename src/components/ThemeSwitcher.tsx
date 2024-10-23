import React, { useState, useEffect } from 'react';
import './ThemeSwitcher.css';
import { FaSun, FaMoon } from 'react-icons/fa'; // Verwende Font Awesome Icons für Sonne und Mond

const ThemeSwitcher: React.FC = () => {
  const getPreferredTheme = (): 'light' | 'dark' => {
    const storedTheme = localStorage.getItem('theme') as 'light' | 'dark' | null;
    if (storedTheme) {
      return storedTheme;
    }

    const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
    return prefersDark ? 'dark' : 'light';
  };

  const [theme, setTheme] = useState<'light' | 'dark'>(getPreferredTheme);

  const toggleTheme = () => {
    const newTheme = theme === 'light' ? 'dark' : 'light';
    setTheme(newTheme);
    document.documentElement.setAttribute('data-theme', newTheme);
    localStorage.setItem('theme', newTheme);
  };

  useEffect(() => {
    document.documentElement.setAttribute('data-theme', theme);
  }, [theme]);

  return (
    <div className="switch-container">
        <h3> Theme wechseln</h3>
      <div className="switch">
        <input
          type="checkbox"
          id="theme-toggle"
          checked={theme === 'light'}
          onChange={toggleTheme}
        />
        <label htmlFor="theme-toggle" className="switch-label light-label">
          <FaSun className="icon" /> <span>Light</span>
        </label>
        <label htmlFor="theme-toggle" className="switch-label dark-label">
          <FaMoon className="icon" /> <span>Dark</span>
        </label>
      </div>
    </div>
  );
};

export default ThemeSwitcher;
