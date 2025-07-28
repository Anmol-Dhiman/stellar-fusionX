// TODO: All the functions user need to click - Dutch Auctions, Order executions everything should be accessible to APIs and state maintained

import express from 'express';
import mongoose from 'mongoose';
import solverRoutes from './Routes/resolver.route';
import orderRoutes from './Routes/order.route';

const app = express();
const PORT = process.env.PORT || 3000;

// TODO: Get a valid MONGO_URI
const MONGO_URI = 'mongodb://localhost:27017/my-ts-db'; // Change to your Mongo URI

app.use(express.json());
app.use('/solver', solverRoutes);
app.use('/order', orderRoutes);

// TODO: Run the scripts for websockets
mongoose.connect(MONGO_URI)
  .then(() => {
    console.log('✅ Connected to MongoDB');
    app.listen(PORT, () => {
      console.log(`🚀 Server is running at http://localhost:${PORT}`);
    });
  })
  .catch((err) => {
    console.error('❌ Failed to connect to MongoDB:', err);
  });
