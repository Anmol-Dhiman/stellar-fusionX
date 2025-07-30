import { Request, Response } from "express";

// Create a new solver
export const handleNewOrder = async (req: Request, res: Response) => {
  try {
    // 1. Find a profitable deal
    // 2. Accept a price in Dutch Auction smart contract
    // 3. Deploy a HTLC on source chain (ETH) with security deposit
    // 4. Deploy a HTLC on destination chain (Stellar) with security deposit
    // 5. Add maker's tokens in src escrow and taker's tokens in dst escrow in dest escrow
  } catch (err: any) {
    res.status(400).json({ error: err.message });
  }
};
