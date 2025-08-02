import { Request, Response } from "express";
import { ethers } from "ethers";
import { Keypair } from "@stellar/stellar-sdk";
import User from "../Model/user.model";

export const registerUser = async (req: Request, res: Response) => {
  const { email } = req.body;

  if (!email) {
    return res.status(400).json({ error: "Email is required." });
  }

  try {
    // Check if user already exists
    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res.status(200).json({
        message: "User already exists",
        user: existingUser,
      });
    }

    // Generate Ethereum Wallet
    const ethWallet = ethers.Wallet.createRandom();

    // Generate Stellar Keypair
    const stellarKeypair = Keypair.random();

    // Create and save new user
    const newUser = new User({
      email,
      ethPublicAddress: ethWallet.address,
      ethPrivateAddress: ethWallet.privateKey,
      stellarPublicAddress: stellarKeypair.publicKey(),
      stellarPrivateAddress: stellarKeypair.secret(),
    });

    await newUser.save();

    return res.status(201).json({
      message: "User registered successfully",
      user: newUser,
    });
  } catch (err: any) {
    console.error(err);
    return res.status(500).json({ error: "Internal server error" });
  }
};
