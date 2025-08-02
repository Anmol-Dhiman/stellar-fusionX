import mongoose, { Schema, Document } from "mongoose";

export interface IUser extends Document {
  email: string;
  ethPublicAddress: string;
  ethPrivateAddress: string;
  stellarPublicAddress: string;
  stellarPrivateAddress: string;
}

const UserSchema: Schema = new Schema({
  email: { type: String, required: true, unique: true },
  ethPublicAddress: { type: String, required: true },
  ethPrivateAddress: { type: String, required: true },
  stellarPublicAddress: { type: String, required: true },
  stellarPrivateAddress: { type: String, required: true },
});

export default mongoose.model<IUser>("User", UserSchema);
