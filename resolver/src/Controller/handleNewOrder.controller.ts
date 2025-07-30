import { Request, Response } from "express";

// Create a new solver
export const handleNewOrder = async (req: Request, res: Response) => {
  try {
    // 1. Find a profitable deal
    // Calculation: Profit = ((marketPrice - auctionPrice) / auctionPrice) > MIN_PROFIT_MARGIN (also account gas fees)
      // 1. Interact with Dutch Auction, 
      // 2. Deploy in sec, 
      // 3. Deploy in dest, 
      // 4. Add tokens in escrows, 
      // 5. Withdraw tokens, 
      // 6. Relayer Fees
    // 2. Accept a price in Dutch Auction smart contract
    // 3. Deploy a HTLC on source chain (ETH) with security deposit
    // 4. Deploy a HTLC on destination chain (Stellar) with security deposit
    // 5. Add maker's tokens in src escrow and taker's tokens in dst escrow in dest escrow
  } catch (err: any) {
    res.status(400).json({ error: err.message });
  }
};
