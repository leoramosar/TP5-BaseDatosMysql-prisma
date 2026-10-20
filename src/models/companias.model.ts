import { prisma } from '../config/prisma.js';

export const findAll = async () => await prisma.companias_envios.findMany();
export const findById = async (id: number) => await prisma.companias_envios.findUnique({ where: { id } });
export const create = async (data: any) => await prisma.companias_envios.create({ data });
export const update = async (id: number, data: any) => await prisma.companias_envios.update({ where: { id }, data });
export const remove = async (id: number) => await prisma.companias_envios.delete({ where: { id } });

export const enviosPorCompania = async () => {
  return await prisma.companias_envios.findMany({
    include: {
      _count: { select: { envios: true } }
    }
  });
};