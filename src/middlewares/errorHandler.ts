import { Request, Response, NextFunction } from 'express';
import { Prisma } from '../../generated/prisma/client.js';

export const errorHandler = (err: any, req: Request, res: Response, next: NextFunction) => {
  console.error('Error:', err.message);

  if (err instanceof Prisma.PrismaClientKnownRequestError) {
    if (err.code === 'P2002') {
      return res.status(400).json({ error: 'Registro duplicado' });
    }
    if (err.code === 'P2003') {
      return res.status(400).json({ error: 'Referencia inexistente' });
    }
    if (err.code === 'P2025') {
      return res.status(404).json({ error: 'Registro no encontrado' });
    }
  }

  res.status(500).json({ error: 'Error interno del servidor' });
};