import { Request, Response, NextFunction } from 'express';
import * as model from '../models/categorias.model.js';

export const getAll = async (req: Request, res: Response, next: NextFunction) => {
  try { res.json(await model.findAll()); } catch (e) { next(e); }
};

export const getOne = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const data = await model.findById(Number(req.params.id));
    if (!data) return res.status(404).json({ error: "Categoría no encontrada" });
    res.json(data);
  } catch (e) { next(e); }
};

export const create = async (req: Request, res: Response, next: NextFunction) => {
  try { res.status(201).json(await model.create(req.body)); } catch (e) { next(e); }
};

export const update = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const ex = await model.findById(Number(req.params.id));
    if (!ex) return res.status(404).json({ error: "Categoría no encontrada" });
    res.json(await model.update(Number(req.params.id), req.body));
  } catch (e) { next(e); }
};

export const remove = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const ex = await model.findById(Number(req.params.id));
    if (!ex) return res.status(404).json({ error: "Categoría no encontrada" });
    await model.remove(Number(req.params.id));
    res.json({ mensaje: "Categoría eliminada" });
  } catch (e) { next(e); }
};