import { Request, Response } from 'express';
import Solver from '../Model/solver.model';

export const getAllSolvers = async (_req: Request, res: Response) => {
  try {
    const solvers = await Solver.find();
    res.json(solvers);
  } catch (err: any) {
    res.status(500).json({ error: err.message });
  }
};