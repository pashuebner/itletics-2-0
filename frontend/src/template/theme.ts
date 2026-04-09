export const applyStoredTheme = () => {
  const storedTheme = localStorage.getItem('theme') as 'light' | 'dark' | null;
  
  if (storedTheme) {
    document.documentElement.setAttribute('data-theme', storedTheme);
  } else {
    // System-Theme abfragen, wenn kein Theme gespeichert wurde
    const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
    const defaultTheme = prefersDark ? 'dark' : 'light';
    document.documentElement.setAttribute('data-theme', defaultTheme);
  }
};
