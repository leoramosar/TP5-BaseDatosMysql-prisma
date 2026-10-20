import { prisma } from '../config/prisma.js';

export const findAll = async () => {
  return await prisma.facturas.findMany({
    include: {
      pedidos: {
        include: { clientes: { select: { nombre: true } } }
      }
    },
    orderBy: { fecha: 'desc' }
  });
};

export const findById = async (id: number) => {
  return await prisma.facturas.findUnique({
    where: { id },
    include: {
      pedidos: {
        include: { clientes: true }
      }
    }
  });
};

export const create = async (data: any) => {
  return await prisma.facturas.create({ data });
};

export const update = async (id: number, data: any) => {
  return await prisma.facturas.update({ where: { id }, data });
};

export const remove = async (id: number) => {
  return await prisma.facturas.delete({ where: { id } });
};

// AGREGACIÓN: IVA por mes
export const ivaPorMes = async () => {
  return await prisma.$queryRaw`
    SELECT DATE_FORMAT(fecha, '%Y-%m') AS mes,
           SUM(subtotal) AS total_subtotal,
           SUM(iva) AS total_iva,
           SUM(total) AS total_facturado
    FROM facturas
    GROUP BY DATE_FORMAT(fecha, '%Y-%m')
    ORDER BY mes DESC
  `;
};