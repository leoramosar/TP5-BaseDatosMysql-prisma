import { prisma } from '../config/prisma.js';

export const findAll = async (filtros: any = {}) => {
  const where: any = {};
  if (filtros.estado) where.estado = filtros.estado;
  if (filtros.id_cliente) where.id_cliente = Number(filtros.id_cliente);

  return await prisma.pedidos.findMany({
    where,
    include: {
      clientes: { select: { nombre: true } },
      empleados: { select: { nombre: true, apellido: true } }
    },
    orderBy: { fecha: 'desc' }
  });
};

export const findById = async (id: number) => {
  return await prisma.pedidos.findUnique({
    where: { id },
    include: {
      clientes: true,
      empleados: true,
      detalle_pedido: {
        include: { productos: true }
      }
    }
  });
};

export const create = async (data: any) => {
  return await prisma.pedidos.create({ data });
};

export const update = async (id: number, data: any) => {
  return await prisma.pedidos.update({ where: { id }, data });
};

export const remove = async (id: number) => {
  return await prisma.pedidos.delete({ where: { id } });
};

// Detalle: agregar producto a un pedido
export const addDetalle = async (id_pedido: number, data: any) => {
  const { id_producto, cantidad, precio_unitario } = data;

  // Usamos upsert para busca si ya existe ese producto en este pedido.
  return await prisma.detalle_pedido.upsert({
    where: {
      id_pedido_id_producto: { 
        id_pedido: id_pedido, 
        id_producto: id_producto 
      }
    },
    update: {
      // Si ya existe, le sumamos la cantidad nueva a la que ya tenía
      cantidad: { increment: cantidad },
    },
    create: {
      // Si no existe, lo creamos
      id_pedido,
      id_producto,
      cantidad,
      precio_unitario,
    },
  });
};

// AGREGACIÓN: cantidad de pedidos por mes
export const totalPorMes = async () => {
  // Prisma groupBy no soporta agrupar por funciones de fecha (DATE_FORMAT) directamente.
  // Usamos queryRaw para esta agregación específica (Consigna 3.4 del TP).
  return await prisma.$queryRaw`
    SELECT DATE_FORMAT(fecha, '%Y-%m') AS mes,
           COUNT(*) AS cantidad_pedidos
    FROM pedidos
    GROUP BY DATE_FORMAT(fecha, '%Y-%m')
    ORDER BY mes DESC
  `;
};