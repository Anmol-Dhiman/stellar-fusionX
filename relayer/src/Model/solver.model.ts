import mongoose, { Schema, Document } from 'mongoose';

export interface ISolver extends Document {
  walletAddress: string;
  webhookUrl: string;
}

const SolverSchema: Schema = new Schema({
  walletAddress: { type: String, required: true },
  webhookUrl: { type: String, required: true, unique: true },
});

export default mongoose.model<ISolver>('Solver', SolverSchema);