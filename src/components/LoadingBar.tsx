import React, { useEffect, useState } from 'react';

interface LoadingBarProps {
  loading: boolean;
}

const LoadingBar: React.FC<LoadingBarProps> = ({ loading }) => {
  const [progress, setProgress] = useState(0);
  const [visible, setVisible] = useState(false); // Kontrolliert die Sichtbarkeit der Progressbar

  useEffect(() => {
    if (loading) {
      setVisible(true); // Progressbar sichtbar machen
      setProgress(0);
      const interval = setInterval(() => {
        setProgress((prev) => (prev < 90 ? prev + 10 : prev)); // Fortschritt bis maximal 90%
      }, 100);

      return () => clearInterval(interval);
    } else if (!loading && progress < 100) {
      // Ladevorgang abgeschlossen, Fortschritt auf 100% setzen
      setProgress(100);
    }
  }, [loading, progress]);

  useEffect(() => {
    if (progress === 100) {
      const timeout = setTimeout(() => {
        setVisible(false); // Progressbar ausblenden, nachdem sie 100% erreicht hat
        setProgress(0); // Fortschritt zurücksetzen für den nächsten Ladevorgang
      }, 500); // Optional, eine kleine Verzögerung nach dem Erreichen von 100%
      return () => clearTimeout(timeout);
    }
  }, [progress]);

  return (
    visible ? (
      <div style={{ position: 'fixed', top: 0, left: 0, width: '100%', height: '4px', background: '#f0f0f0' }}>
        <div style={{ width: `${progress}%`, height: '100%', background: '#29d', transition: 'width 0.2s ease' }} />
      </div>
    ) : null
  );
};

export default LoadingBar;