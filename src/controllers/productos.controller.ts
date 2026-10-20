import { Request, Response, NextFunction } from 'express';
import * as model from '../models/productos.model.js';

export const getAll = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const data = await model.findAll(req.query);
    res.json(data);
  } catch (err) { next(err); }
};

export const getOne = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const data = await model.findById(Number(req.params.id));
    if (!data) return res.status(404).json({ error: "Producto no encontrado" });
    res.json(data);
  } catch (err) { next(err); }
};

export const create = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const data = await model.create(req.body);
    res.status(201).json(data);
  } catch (err) { next(err); }
};

export const update = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const ex = await model.findById(Number(req.params.id));
    if (!ex) return res.status(404).json({ error: "Producto no encontrado" });
    const data = await model.update(Number(req.params.id), req.body);
    res.json(data);
  } catch (err) { next(err); }
};

export const remove = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const ex = await model.findById(Number(req.params.id));
    if (!ex) return res.status(404).json({ error: "Producto no encontrado" });
    await model.remove(Number(req.params.id));
    res.json({ mensaje: "Producto eliminado" });
  } catch (err) { next(err); }
};

export const stockCategoria = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const data = await model.stockPorCategoria();
    res.json(data);
  } catch (err) { next(err); }
};