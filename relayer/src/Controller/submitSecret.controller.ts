import { Request, Response } from "express";
import Order from "../Model/order.model";
import Solver from "../Model/solver.model";
import axios from "axios";

import { getSolvers } from "../utils/getSolvers.util"; // adjust path if needed

export const submitSecret = async (req: Request, res: Response) => {
  try {
    const { orderId, secret } = req.body;

    if (!orderId || !secret) {
      return res
        .status(400)
        .json({ error: "orderId and secret are required." });
    }

    // Fetch the order
    const order = await Order.findOne({ id: orderId });

    if (!order) {
      return res.status(404).json({ error: "Order not found." });
    }

    if (order.secret) {
      return res
        .status(400)
        .json({ error: "Secret already submitted for this order." });
    }

    // Update the order with the secret and mark as shared
    order.secret = secret;
    order.secretSharedToResolver = true;

    await order.save();

    // Fetch resolver webhook URL
    const resolver = await Solver.findOne({
      walletAddress: order.resolverAddress,
    });

    if (!resolver) {
      return res.status(404).json({ error: "Resolver not registered." });
    }

    const resolvers = getSolvers();

    const postResults = await Promise.allSettled(
      // TODO: Check the response and then implement the map. Current returned value is an object
      resolvers.map((r) =>
        axios
          .post(`${r.webhookUrl}/secret`, { orderId, secret })
          .catch((err) => {
            console.warn(`Failed to notify resolver ${r.id}:`, err.message);
          })
      )
    );

    return res
      .status(200)
      .json({ message: "Secret submitted and sent to resolver." });
  } catch (err: any) {
    console.error("submitSecret error:", err.message);
    return res.status(500).json({ error: "Server error." });
  }
};
