import express from 'express';

import { submitOrder } from '../Controller/submitOrder.controller';

const router = express.Router();

// Create order
router.post('/submit', submitOrder);


export default router;