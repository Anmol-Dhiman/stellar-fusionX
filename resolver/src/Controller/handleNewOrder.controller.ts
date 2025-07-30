import { Request, Response } from "express";

// Create a new solver
export const handleNewOrder = async (req: Request, res: Response) => {
  try {
    // Find a good deal and execute it
  } catch (err: any) {
    res.status(400).json({ error: err.message });
  }
};
