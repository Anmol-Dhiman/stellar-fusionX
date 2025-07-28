import { Request, Response } from "express";
import axios from "axios";
import { getSolvers } from "../utils/getSolvers.util"; // adjust path if needed

import Order from "../Model/order.model";
import { v4 as uuidv4 } from "uuid";

export const submitOrder = async (req: Request, res: Response) => {
  const {
    maker,
    sourceChain,
    destinationChain,
    sourceToken,
    destinationToken,
    sourceAmount,
    destinationAmount,
    signature,
    secretHash,
    timestamp,
  } = req.body;

  if (
    !maker ||
    !sourceChain ||
    !destinationChain ||
    !sourceToken ||
    !destinationToken ||
    !sourceAmount ||
    !destinationAmount ||
    !signature ||
    !secretHash ||
    !timestamp
  ) {
    return res.status(400).json({ error: "Invalid order" });
  }

  const id = uuidv4(); // Generate a unique ID for the order

  const orderData = {
    id,
    maker,
    sourceChain,
    destinationChain,
    sourceToken,
    destinationToken,
    sourceAmount,
    destinationAmount,
    signature,
    secretHash,
    timestamp,
  };

  try {
    await Order.create(orderData);
    console.log("New order saved:", orderData);
  } catch (err) {
    console.error("Error saving order:", err);
    return res.status(500).json({ error: "Failed to save order" });
  }

  const resolvers = getSolvers();

  const postResults = await Promise.allSettled(
    // TODO: Check the response and then implement the map. Current returned value is an object
    resolvers.map((r) =>
      axios.post(`${r.webhookUrl}/new-order`, orderData).catch((err) => {
        console.warn(`Failed to notify resolver ${r.id}:`, err.message);
      })
    )
  );

  console.log("Resolvers notified.");

  // TODO: Check the response and then implement the map. Current returned value is an object
  return res
    .status(200)
    .json({ success: true, notifiedResolvers: resolvers.length });
};
