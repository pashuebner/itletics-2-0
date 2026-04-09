import 'dotenv/config';
import express from 'express';
import cors from 'cors';
import databaseRouter from './routes/databaseRoutes';
import authRouter from './routes/authRoutes';

const app = express();
const PORT = Number(process.env.PORT ?? 3001);

app.use(
  cors({
    origin: process.env.CORS_ORIGIN ?? 'http://localhost:5173',
    credentials: true,
  })
);
app.use(express.json());

// Health check
app.get('/api/health', (_req, res) => {
  res.json({ status: 'ok', timestamp: new Date().toISOString() });
});

app.use('/api/db', databaseRouter);
app.use('/api/auth', authRouter);

// Global error handler
app.use((err: Error, _req: express.Request, res: express.Response, _next: express.NextFunction) => {
  console.error(err);

  const message = err.message || 'Internal server error';
  const status = message.startsWith('Unknown table:') || message.includes('has no primary key')
    ? 404
    : message === 'No valid columns provided'
      ? 400
      : 500;

  res.status(status).json({ error: message });
});

app.listen(PORT, () => {
  console.log(`[backend] Server listening on port ${PORT}`);
});
