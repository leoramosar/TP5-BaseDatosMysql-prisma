import type { Request, Response, NextFunction } from 'express';
import * as jsonwebtoken from 'jsonwebtoken';
import "dotenv/config";

export const authMiddleware = (req: Request, res: Response, next: NextFunction) => {
  // 1. Buscamos el token en el header "Authorization"
  const authHeader = req.headers.authorization;

  if (!authHeader || !authHeader.startsWith('Bearer ')) {
    return res.status(401).json({ error: "Token no proporcionado" });
  }

  // 2. Extraemos el token (le sacamos la palabra "Bearer ")
  const token = authHeader.split(' ')[1];

  try {
    // 3. Verificamos que el token sea válido y no esté expirado
    jsonwebtoken.verify(token, process.env.JWT_TOKEN_SECRET as string);
    
    // 4. Si todo está bien, dejamos pasar la petición
    next(); 
  } catch (error) {
    return res.status(401).json({ error: "Token inválido o expirado" });
  }
};