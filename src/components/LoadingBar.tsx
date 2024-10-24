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
        setProgress((prev) => (prev < 95 ? prev + 5 : prev)); 
      }, 50);

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
      <div className="loading-bar" style={{ position: 'relative', gridArea: 'content', top: 0, left: 0, width: '100%', height: '1rem', background: 'var(--bg-color)' }}>
        <div style={{ width: `${progress}%`, height: '100%', backgroundColor: 'transparent', transition: 'width 0.2s ease' }} />
      </div>
    ) : null
  );
};

export default LoadingBar;
