import { Router } from 'express';
import {
  deleteRow,
  getRowById,
  getTables,
  insertRow,
  listRows,
  updateRow,
} from '../db';

const databaseRouter = Router();

databaseRouter.get('/tables', async (_req, res, next) => {
  try {
    const tables = await getTables();
    res.json({ tables });
  } catch (error) {
    next(error);
  }
});

databaseRouter.get('/tables/:table/rows', async (req, res, next) => {
  try {
    const limit = req.query.limit ? Number(req.query.limit) : undefined;
    const offset = req.query.offset ? Number(req.query.offset) : undefined;
    const sortBy = typeof req.query.sortBy === 'string' ? req.query.sortBy : undefined;
    const sortOrder = req.query.sortOrder === 'desc' ? 'desc' : 'asc';

    const data = await listRows(req.params.table, {
      limit,
      offset,
      sortBy,
      sortOrder,
    });

    res.json(data);
  } catch (error) {
    next(error);
  }
});

databaseRouter.get('/tables/:table/rows/:id', async (req, res, next) => {
  try {
    const row = await getRowById(req.params.table, req.params.id);
    if (!row) {
      res.status(404).json({ error: 'Row not found' });
      return;
    }

    res.json({ row });
  } catch (error) {
    next(error);
  }
});

databaseRouter.post('/tables/:table/rows', async (req, res, next) => {
  try {
    const row = await insertRow(req.params.table, req.body ?? {});
    res.status(201).json({ row });
  } catch (error) {
    next(error);
  }
});

databaseRouter.put('/tables/:table/rows/:id', async (req, res, next) => {
  try {
    const row = await updateRow(req.params.table, req.params.id, req.body ?? {});
    res.json({ row });
  } catch (error) {
    next(error);
  }
});

databaseRouter.patch('/tables/:table/rows/:id', async (req, res, next) => {
  try {
    const row = await updateRow(req.params.table, req.params.id, req.body ?? {});
    res.json({ row });
  } catch (error) {
    next(error);
  }
});

databaseRouter.delete('/tables/:table/rows/:id', async (req, res, next) => {
  try {
    await deleteRow(req.params.table, req.params.id);
    res.status(204).send();
  } catch (error) {
    next(error);
  }
});

export default databaseRouter;
