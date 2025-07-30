import express from 'express';

import { handleNewOrder } from '../Controller/handleNewOrder.controller';

const router = express.Router();

// Handle new order
router.post('/', handleNewOrder);


export default router;