import { Router } from 'express';
import usuariosController from '../controllers/usuarios.controller.js'; // Sin el *, porque es export default

const router = Router();

// Rutas de autenticación
router.post("/register", usuariosController.register);
router.post("/login", usuariosController.login);

export default router;