import { prisma } from "../config/prisma.js";
import type { Request, Response } from 'express';
import * as bcrypt from 'bcrypt';
import { generartoken } from '../helpers/autenticacion.js'

class UsersController {
  constructor() { }

  async register(req: Request, res: Response) {
    try {
      const { nombre, email, password, rol } = req.body;

      const existeUsuario = await prisma.user.findUnique({
        where: {
          email
        }
      });

      if (existeUsuario) {
        return res.status(400).json({
          error: "El email ya se encuentr registrado"
        });
      }

      const passwordHash = await bcrypt.hash(password, 10);

      const usuario = await prisma.user.create({
        data: {
          nombre,
          email,
          password: passwordHash,
          rol: 'USER'
        },
        omit: {
          password
        }
      });


      return res.status(201).json({
        mensaje: "Usuario creado correctamente",
        usuario
      });

    } catch (err) {
      if (err instanceof Error) {
        return res.status(500).json({ error: err.message });
      }
      return res.status(500).json({ error: "Error interno del servidor" });

    }

  }

  async login(req: Request, res: Response) {
    try {
      const { email, password } = req.body;

      const usuario = await prisma.user.findUnique({
        where: {
          email
        }
      });

      if (!usuario) {
        return res.status(401).json({ error: "Credenciales inválidas" });
      }

      if (!usuario.activo) {
        return res.status(403).json({ error: "Usuario inactivo" });
      }

      const passwordValido = await bcrypt.compare(password, usuario.password!);

      if (!passwordValido) {
        return res.status(401).json({ error: "Credenciales inválidas" });
      }

      const token = generartoken(usuario.id, usuario.email!, usuario.rol);

      return res.status(200).json({
        mensaje: "Login exitoso",
        token,
        usuario: {
          id: usuario.id,
          nombre: usuario.nombre,
          email: usuario.email,
          rol: usuario.rol
        }
      });

    } catch (err) {
      if (err instanceof Error) {
        return res.status(500).json({ error: err.message });
      }
      return res.status(500).json({ error: "Error interno del servidor" });
    }
  }
}

export default new UsersController()