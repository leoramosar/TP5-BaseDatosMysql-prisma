import { prisma } from '../config/prisma.js';

export const findAll = async () => {
  return await prisma.proveedores.findMany({
    where: { activo: true }
  });
};

export const findById = async (id: number) => {
  return await prisma.proveedores.findUnique({
    where: { id }
  });
};

export const create = async (data: any) => {
  return await prisma.proveedores.create({
    data
  });
};

export const update = async (id: number, data: any) => {
  return await prisma.proveedores.update({
    where: { id },
    data
  });
};

export const remove = async (id: number) => {
  return await prisma.proveedores.update({
    where: { id },
    data: { activo: false }
  });
};