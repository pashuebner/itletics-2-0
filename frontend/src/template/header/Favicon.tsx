import React, { useEffect } from 'react';

// Importiere alle Favicons
import favicon1 from '../../assets/template/favicon/favicon-1.png';
import favicon2 from '../../assets/template/favicon/favicon-2.png';
import favicon3 from '../../assets/template/favicon/favicon-3.png';
import favicon4 from '../../assets/template/favicon/favicon-4.png';
import favicon5 from '../../assets/template/favicon/favicon-5.png';
import favicon6 from '../../assets/template/favicon/favicon-6.png';
import favicon7 from '../../assets/template/favicon/favicon-7.png';
import favicon8 from '../../assets/template/favicon/favicon-8.png';
import favicon9 from '../../assets/template/favicon/favicon-10.png';
import faviconDefault from '../../assets/template/favicon/favicon.png';

const favicons = [faviconDefault, faviconDefault, faviconDefault, faviconDefault, faviconDefault, faviconDefault, faviconDefault, faviconDefault, faviconDefault, faviconDefault, faviconDefault, faviconDefault, faviconDefault, faviconDefault, favicon1, favicon2, favicon3, favicon4, favicon5, favicon6, favicon7, favicon8, favicon9, favicon9, favicon9, favicon9, favicon9, favicon9, favicon9, favicon9, favicon9, favicon9, favicon9, favicon9, favicon9, favicon9, favicon9, favicon9, favicon9];

const IconChanger: React.FC = () => {
  useEffect(() => {
    let currentIndex = 0;

    const changeFavicon = () => {
      // Hole das Favicon-Element aus dem DOM
      const faviconElement = document.getElementById('favicon') as HTMLLinkElement;

      if (faviconElement) {
        // Setze das Favicon auf das nächste in der Liste
        faviconElement.href = favicons[currentIndex];
        currentIndex = (currentIndex + 1) % favicons.length; // Zyklus durch die Favicon-Liste
      }
    };

    // Intervall, um das Favicon alle 333 ms zu wechseln
    const intervalId = setInterval(changeFavicon, 80);

    // Aufräumen des Intervalls, wenn die Komponente entladen wird
    return () => clearInterval(intervalId);
  }, []);

  return (
    <link id="favicon" rel="icon" href={faviconDefault} />
  );
};

export default IconChanger;
