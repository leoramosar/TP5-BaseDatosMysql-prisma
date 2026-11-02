import { Request, Response, NextFunction } from 'express';
import { Prisma } from '../../generated/prisma/client.js';

export const errorHandler = (err: any, req: Request, res: Response, next: NextFunction) => {
  console.error('Error:', err.message);

  // errores de CHECK de la base
  const msg = String(err.message || '');
  if (msg.includes('chk_productos_precio')) {
    return res.status(400).json({ error: 'El precio no puede ser negativo' });
  }
  if (msg.includes('chk_productos_stock')) {
    return res.status(400).json({ error: 'El stock no puede ser negativo' });
  }
  if (msg.includes('chk_detalle_cantidad')) {
    return res.status(400).json({ error: 'La cantidad debe ser mayor a 0' });
  }
  if (msg.includes('chk_detalle_precio')) {
    return res.status(400).json({ error: 'El precio unitario no puede ser negativo' });
  }
  if (msg.includes('chk_empleados_salario')) {
    return res.status(400).json({ error: 'El salario no puede ser negativo' });
  }
  if (msg.includes('chk_companias_costo')) {
    return res.status(400).json({ error: 'El costo base no puede ser negativo' });
  }

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