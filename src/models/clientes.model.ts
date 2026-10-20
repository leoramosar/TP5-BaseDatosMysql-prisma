import { prisma } from '../config/prisma.js';

export const findAll = async () => {
  return await prisma.clientes.findMany({
    where: { activo: true }
  });
};

export const findById = async (id: number) => {
  return await prisma.clientes.findUnique({ where: { id } });
};

export const create = async (data: any) => {
  return await prisma.clientes.create({ data });
};

export const update = async (id: number, data: any) => {
  return await prisma.clientes.update({ where: { id }, data });
};

export const remove = async (id: number) => {
  return await prisma.clientes.update({
    where: { id },
    data: { activo: false }
  });
};

// AGREGACIÓN: total facturado por cliente
export const totalPorCliente = async () => {
  return await prisma.clientes.findMany({
    where: { activo: true },
    select: {
      id: true,
      nombre: true,
      pedidos: {
        select: {
          facturas: {
            select: { total: true }
          }
        }
      }
    }
  });
};