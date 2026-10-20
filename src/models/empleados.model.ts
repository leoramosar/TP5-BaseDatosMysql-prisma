import { prisma } from '../config/prisma.js';

export const findAll = async () => {
  return await prisma.empleados.findMany({
    where: { activo: true }
  });
};

export const findById = async (id: number) => {
  return await prisma.empleados.findUnique({ where: { id } });
};

export const create = async (data: any) => {
  return await prisma.empleados.create({ data });
};

export const update = async (id: number, data: any) => {
  return await prisma.empleados.update({ where: { id }, data });
};

export const remove = async (id: number) => {
  return await prisma.empleados.update({
    where: { id },
    data: { activo: false }
  });
};

// AGREGACIÓN: salario promedio por puesto
export const salarioPorPuesto = async () => {
  return await prisma.empleados.groupBy({
    by: ['puesto'],
    _avg: { salario: true },
    _max: { salario: true },
    _count: { id: true },
    where: { activo: true }
  });
};