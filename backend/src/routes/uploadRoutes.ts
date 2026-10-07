import express, { Request, Response } from 'express';
import multer from 'multer';
import path from 'path';
import fs from 'fs';

const router = express.Router();

// Ensure uploads directory exists
const uploadsDir = path.join(__dirname, '../../uploads');
if (!fs.existsSync(uploadsDir)) {
  fs.mkdirSync(uploadsDir, { recursive: true });
}

// Configure multer storage
const storage = multer.diskStorage({
  destination: (_req, _file, cb) => {
    cb(null, uploadsDir);
  },
  filename: (_req, file, cb) => {
    // Generate unique filename while preserving extension
    const timestamp = Date.now();
    const randomStr = Math.random().toString(36).substring(2, 8);
    const ext = path.extname(file.originalname);
    const name = path.basename(file.originalname, ext);
    cb(null, `${name}-${timestamp}-${randomStr}${ext}`);
  },
});

// File filter for images and PDFs
const fileFilter = (_req: Request, file: Express.Multer.File, cb: multer.FileFilterCallback) => {
  const allowedMimes = ['image/jpeg', 'image/png', 'image/gif', 'image/webp', 'application/pdf'];
  const fileSize = 5 * 1024 * 1024; // 5MB limit

  if (allowedMimes.includes(file.mimetype)) {
    cb(null, true);
  } else {
    cb(new Error(`Dateityp nicht erlaubt: ${file.mimetype}. Erlaubte Typen: JPEG, PNG, GIF, WebP, PDF`));
  }
};

const upload = multer({
  storage,
  fileFilter,
  limits: { fileSize: 5 * 1024 * 1024 }, // 5MB
});

// Upload endpoint: POST /api/upload
router.post('/logo', upload.single('file'), (_req: Request, res: Response) => {
  if (!_req.file) {
    return res.status(400).json({ error: 'Keine Datei hochgeladen.' });
  }

  // Return relative path that can be stored in database and served by frontend
  const relativePath = `/uploads/${_req.file.filename}`;
  return res.status(200).json({
    success: true,
    filename: _req.file.filename,
    path: relativePath,
    size: _req.file.size,
    mimetype: _req.file.mimetype,
  });
});

// Optional: GET endpoint to list uploads (useful for debugging)
router.get('/list', (_req: Request, res: Response) => {
  try {
    const files = fs.readdirSync(uploadsDir);
    return res.json({
      count: files.length,
      files: files.map((f) => ({
        filename: f,
        path: `/uploads/${f}`,
      })),
    });
  } catch (err) {
    return res.status(500).json({ error: 'Fehler beim Auflisten der Dateien.' });
  }
});

export default router;
