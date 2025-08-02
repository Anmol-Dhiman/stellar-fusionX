// TODO: All the functions user need to click - Dutch Auctions, Order executions everything should be accessible to APIs and state maintained

import express from "express";
import mongoose from "mongoose";
import cors from "cors"; // ✅ Import CORS

import solverRoutes from "./Routes/resolver.route";
import orderRoutes from "./Routes/order.route";
import userRoutes from "./Routes/user.route";

const app = express();
const PORT = process.env.PORT || 3001;

// TODO: Get a valid MONGO_URI
const MONGO_URI =
  "mongodb+srv://anmoldhiman7111:ucvhuIilCSViIsUO@cluster.kifuywp.mongodb.net/?retryWrites=true&w=majority&appName=Cluster"; // Change to your Mongo URI

app.use(express.json());
app.use(cors({ origin: "http://localhost:3000" })); // or your frontend domain

app.use("/solver", solverRoutes);
app.use("/order", orderRoutes);
app.use("/user", userRoutes);
("http://localhost:3001/user/register");

// TODO: Run the scripts for websockets
mongoose
  .connect(MONGO_URI)
  .then(() => {
    console.log("✅ Connected to MongoDB");
    app.listen(PORT, () => {
      console.log(`🚀 Server is running at http://localhost:${PORT}`);
    });
  })
  .catch((err) => {
    console.error("❌ Failed to connect to MongoDB:", err);
  });
