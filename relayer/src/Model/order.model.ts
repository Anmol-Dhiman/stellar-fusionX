import mongoose, { Schema, Document } from 'mongoose';

export interface IOrder extends Document {
  id: string;
  maker: string;
  sourceChain: 'ethereum' | 'stellar';
  destinationChain: 'ethereum' | 'stellar';
  sourceToken: string;
  destinationToken: string;
  sourceAmount: string;
  destinationAmount: string;
  signature: string;
  timestamp: number;
  secretHash?: string;
  secret?: string;
  secretSharedToResolver?: boolean;
  secretSharedToNetwork?: boolean;
  sourceEscrowContractAddress?: string;
  destinationEscrowContractAddress?: string;
  isSourceEscrowFunded?: boolean;
  isDestinationEscrowFunded?: boolean;
  isFinalityConfirmed?: boolean;
  resolverAddress?: string;
  stellarMemo?: string;
}

const OrderSchema: Schema = new Schema({
  id: { type: String, required: true, unique: true },
  maker: { type: String, required: true },
  sourceChain: { type: String, enum: ['ethereum', 'stellar'], required: true },
  destinationChain: { type: String, enum: ['ethereum', 'stellar'], required: true },
  sourceToken: { type: String, required: true },
  destinationToken: { type: String, required: true },
  sourceAmount: { type: String, required: true },
  destinationAmount: { type: String, required: true },
  signature: { type: String, required: true },
  secretHash: { type: String, required: true },

  // Optional fields for later updates
  secret: { type: String },
  secretSharedToResolver: { type: Boolean, default: false },
  secretSharedToNetwork: { type: Boolean, default: false },
  sourceEscrowContractAddress: { type: String },
  destinationEscrowContractAddress: { type: String },
  isSourceEscrowFunded: { type: Boolean, default: false },
  isDestinationEscrowFunded: { type: Boolean, default: false },
  isFinalityConfirmed: { type: Boolean, default: false },
  resolverAddress: { type: String },
  stellarMemo: { type: String }
}, {
  timestamps: true
});

export default mongoose.model<IOrder>('Order', OrderSchema);
