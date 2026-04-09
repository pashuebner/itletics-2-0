## Docker Compose

### Development

Startet Frontend (Vite), Backend im Watch-Mode und erstellt eine SQLite-Testdatenbank aus [db/init/00_init.sql](db/init/00_init.sql).

```bash
docker compose up -d --build
```

Alternativ explizit:

```bash
docker compose -f docker-compose.dev.yml up -d --build
```

Services:

- Frontend: http://localhost:5173
- Backend: http://localhost:3001
- SQLite DB: [dev-data/itletics-dev.sqlite](dev-data/itletics-dev.sqlite)

Nur SQLite neu erzeugen:

```bash
docker compose -f docker-compose.dev.yml run --rm sqlite-init
```

### Production

Startet Frontend (Nginx) und Backend in Production.

```bash
docker compose -f docker-compose.prod.yml up -d --build
```

Hinweis: In Prod muss `DATABASE_URL` gesetzt sein (z. B. per `.env` oder CI/CD-Secret).

# React + TypeScript + Vite

This template provides a minimal setup to get React working in Vite with HMR and some ESLint rules.

Currently, two official plugins are available:

- [@vitejs/plugin-react](https://github.com/vitejs/vite-plugin-react/blob/main/packages/plugin-react/README.md) uses [Babel](https://babeljs.io/) for Fast Refresh
- [@vitejs/plugin-react-swc](https://github.com/vitejs/vite-plugin-react-swc) uses [SWC](https://swc.rs/) for Fast Refresh

## Expanding the ESLint configuration

If you are developing a production application, we recommend updating the configuration to enable type aware lint rules:

- Configure the top-level `parserOptions` property like this:

```js
export default tseslint.config({
  languageOptions: {
    // other options...
    parserOptions: {
      project: ["./tsconfig.node.json", "./tsconfig.app.json"],
      tsconfigRootDir: import.meta.dirname,
    },
  },
});
```

- Replace `tseslint.configs.recommended` to `tseslint.configs.recommendedTypeChecked` or `tseslint.configs.strictTypeChecked`
- Optionally add `...tseslint.configs.stylisticTypeChecked`
- Install [eslint-plugin-react](https://github.com/jsx-eslint/eslint-plugin-react) and update the config:

```js
// eslint.config.js
import react from "eslint-plugin-react";

export default tseslint.config({
  // Set the react version
  settings: { react: { version: "18.3" } },
  plugins: {
    // Add the react plugin
    react,
  },
  rules: {
    // other rules...
    // Enable its recommended rules
    ...react.configs.recommended.rules,
    ...react.configs["jsx-runtime"].rules,
  },
});
```
