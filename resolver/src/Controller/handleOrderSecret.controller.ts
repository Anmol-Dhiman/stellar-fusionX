import { Request, Response } from "express";

// Create a new solver
export const handleOrderSecret = async (req: Request, res: Response) => {
  try {
    // 1. Get s from relayer
    // 2. Withdraw and send tokens to maker in destination chain
    // 3. Withdraw and send tokens to taker in source chain
  } catch (err: any) {
    res.status(400).json({ error: err.message });
  }
};
