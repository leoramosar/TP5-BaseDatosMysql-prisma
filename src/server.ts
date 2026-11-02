import express from 'express';
import dotenv from 'dotenv';
import swaggerUi from 'swagger-ui-express';
import { readFileSync } from 'fs';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';
import { errorHandler } from './middlewares/errorHandler.js';
import proveedoresRoutes from './routes/proveedores.routes.js'; // <-- NUEVO
import categoriasRoutes from './routes/categorias.routes.js';
import productosRoutes from './routes/productos.routes.js';
import clientesRoutes from './routes/clientes.routes.js';
import empleadosRoutes from './routes/empleados.routes.js';
import pedidosRoutes from './routes/pedidos.routes.js';
import facturasRoutes from './routes/facturas.routes.js';
import companiasRoutes from './routes/companias.routes.js';
import enviosRoutes from './routes/envios.routes.js';
import usuariosRoutes from './routes/usuarios.routes.js'
import { authMiddleware } from './middlewares/auth.middleware.js';

dotenv.config();

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);
const swaggerDocument = JSON.parse(
  readFileSync(join(__dirname, '../swagger.json'), 'utf8')
);

const app = express();
app.use(express.json());

// documentacion swagger
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerDocument));

app.use('/usuarios', usuariosRoutes);

app.use('/proveedores', authMiddleware, proveedoresRoutes);
app.use('/categorias', authMiddleware, categoriasRoutes);
app.use('/productos', authMiddleware, productosRoutes);
app.use('/clientes', authMiddleware, clientesRoutes);
app.use('/empleados', authMiddleware, empleadosRoutes);
app.use('/pedidos', authMiddleware, pedidosRoutes);
app.use('/companias', authMiddleware, companiasRoutes);
app.use('/envios', authMiddleware, enviosRoutes);

app.use((req, res) => {
  res.status(404).json({ error: 'Ruta no encontrada' });
});

app.use(errorHandler);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Servidor en http://localhost:${PORT}`);
});