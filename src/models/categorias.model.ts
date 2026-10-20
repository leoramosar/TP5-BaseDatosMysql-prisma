import { prisma } from '../config/prisma.js';

export const findAll = async () => {
  return await prisma.categorias.findMany();
};

export const findById = async (id: number) => {
  return await prisma.categorias.findUnique({ where: { id } });
};

export const create = async (data: any) => {
  return await prisma.categorias.create({ data });
};

export const update = async (id: number, data: any) => {
  return await prisma.categorias.update({ where: { id }, data });
};

export const remove = async (id: number) => {
  return await prisma.categorias.delete({ where: { id } });
};