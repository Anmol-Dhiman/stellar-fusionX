import express from 'express';
import mongoose from 'mongoose';

import newOrderRoutes from './Routes/newOrder.route';

const app = express();
const PORT = process.env.PORT || 3000;

const MONGO_URI = 'mongodb://localhost:27017/my-ts-db'; // Change to your Mongo URI

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Receive new orders
app.use('/new-order', newOrderRoutes);

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
