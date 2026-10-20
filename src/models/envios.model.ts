import { prisma } from '../config/prisma.js';

export const findAll = async () => {
  return await prisma.envios.findMany({
    include: { companias_envios: true, pedidos: true },
    orderBy: { fecha_envio: 'desc' }
  });
};
export const findById = async (id: number) => {
  return await prisma.envios.findUnique({
    where: { id },
    include: { companias_envios: true, pedidos: true }
  });
};
export const create = async (data: any) => await prisma.envios.create({ data });
export const update = async (id: number, data: any) => await prisma.envios.update({ where: { id }, data });
export const remove = async (id: number) => await prisma.envios.delete({ where: { id } });