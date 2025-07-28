import { Request, Response } from "express";
import Solver from "../Model/solver.model";

import {
  ethSrcFactory,
  xlmSrcFactory,
  ethDestFactory,
  xlmDestFactory,
} from "../utils/contractFactories.util";

// Create a new solver
export const registerSolver = async (req: Request, res: Response) => {
  try {
    const solver = new Solver(req.body);
    const savedSolver = await solver.save();
    res.status(201).json({
      solverInfo: savedSolver,
      factoryContracts: [
        ethSrcFactory,
        xlmSrcFactory,
        ethDestFactory,
        xlmDestFactory,
      ],
    });
  } catch (err: any) {
    res.status(400).json({ error: err.message });
  }
};
