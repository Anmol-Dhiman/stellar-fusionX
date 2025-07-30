import express from 'express';

import { handleNewOrder } from '../Controller/handleNewOrder.controller';
import { handleOrderSecret } from '../Controller/handleOrderSecret.controller';

const router = express.Router();

// Handle new order
router.post('/new-order', handleNewOrder);
router.post('/secret', handleOrderSecret);


export default router;