import express from "express";

import { registerUser } from "../Controller/registerUser.controller";

const router = express.Router();

// Create order
router.post("/register", registerUser);

export default router;
