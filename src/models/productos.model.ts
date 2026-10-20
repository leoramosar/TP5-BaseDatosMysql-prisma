import { prisma } from '../config/prisma.js';

export const findAll = async (filtros: any = {}) => {
  const where: any = { activo: true };

  if (filtros.categoria) {
    where.categoria = { nombre: filtros.categoria };
  }
  if (filtros.precio_max) {
    where.precio = { lte: Number(filtros.precio_max) };
  }

  return await prisma.productos.findMany({
    where,
    include: {
      categorias: true,
      proveedores: true
    }
  });
};

export const findById = async (id: number) => {
  return await prisma.productos.findUnique({
    where: { id },
    include: {
      categorias: true,
      proveedores: true
    }
  });
};

export const create = async (data: any) => {
  return await prisma.productos.create({ data });
};

export const update = async (id: number, data: any) => {
  return await prisma.productos.update({
    where: { id },
    data
  });
};

export const remove = async (id: number) => {
  // Baja lógica
  return await prisma.productos.update({
    where: { id },
    data: { activo: false }
  });
};

// AGREGACIÓN: stock total por categoría
export const stockPorCategoria = async () => {
  return await prisma.productos.groupBy({
    by: ['id_categoria'],
    _sum: { stock: true },
    _count: { id: true },
    where: { activo: true }
  });
};