import { Request, Response, NextFunction } from 'express';
import * as model from '../models/empleados.model.js';

export const getAll = async (req: Request, res: Response, next: NextFunction) => {
  try { res.json(await model.findAll()); } catch (e) { next(e); }
};

export const getOne = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const data = await model.findById(Number(req.params.id));
    if (!data) return res.status(404).json({ error: "Empleado no encontrado" });
    res.json(data);
  } catch (e) { next(e); }
};

export const create = async (req: Request, res: Response, next: NextFunction) => {
  try { res.status(201).json(await model.create(req.body)); } catch (e) { next(e); }
};

export const update = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const ex = await model.findById(Number(req.params.id));
    if (!ex) return res.status(404).json({ error: "Empleado no encontrado" });
    res.json(await model.update(Number(req.params.id), req.body));
  } catch (e) { next(e); }
};

export const remove = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const ex = await model.findById(Number(req.params.id));
    if (!ex) return res.status(404).json({ error: "Empleado no encontrado" });
    await model.remove(Number(req.params.id));
    res.json({ mensaje: "Empleado eliminado" });
  } catch (e) { next(e); }
};

export const salarios = async (req: Request, res: Response, next: NextFunction) => {
  try { res.json(await model.salarioPorPuesto()); } catch (e) { next(e); }
};