"use client";

import { useState, useEffect } from "react";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Alert, AlertDescription } from "@/components/ui/alert";
import {
  ArrowUpDown,
  TrendingUp,
  Clock,
  CheckCircle,
  XCircle,
  Copy,
  Eye,
  EyeOff,
  ExternalLink,
  Loader2,
  Coins,
  AlertCircle,
} from "lucide-react";
import Link from "next/link";
import { WalletConnection } from "@/components/wallet-connection";
import { useUser } from "@/context/user-context";

// Stellar SDK imports
import {
  StellarWalletsKit,
  WalletNetwork,
  allowAllModules,
} from '@creit.tech/stellar-wallets-kit';

const StellarSdk = require("@stellar/stellar-sdk");
const { Keypair, TransactionBuilder, Networks, Contract, nativeToScVal, rpc } = StellarSdk;

// Configuration
const WRAPPED_TOKEN_CONTRACT_ADDRESS = "CB27AJYW32SYXRGGTZSWHZ6ZRURIXP5ANARZ6DCAWID6UWVY6P2Z3IGZ";
const server = new rpc.Server("https://soroban-testnet.stellar.org");
const networkPassphrase = Networks.TESTNET;

// Helper functions
function tokensToUnits(tokens: string | number): string {
  return (BigInt(tokens) * BigInt(10 ** 18)).toString();
}

const transactions = [
  {
    id: "0x1234...5678",
    from: "ETH",
    to: "XLM",
    fromAmount: "1.5",
    toAmount: "3,061.2",
    status: "completed",
    timestamp: "2024-01-15 14:30:22",
    fee: "$12.50",
    rate: "1 ETH = 2,040.8 XLM",
  },
  {
    id: "0x8765...4321",
    from: "USDC",
    to: "XLM",
    fromAmount: "500",
    toAmount: "500.15",
    status: "pending",
    timestamp: "2024-01-15 16:45:10",
    fee: "$2.30",
    rate: "1 USDC = 1.0003 XLM",
  },
  {
    id: "0x9876...1234",
    from: "XLM",
    to: "ETH",
    fromAmount: "2,000",
    toAmount: "0.98",
    status: "failed",
    timestamp: "2024-01-14 09:15:33",
    fee: "$8.75",
    rate: "2,040.8 XLM = 1 ETH",
  },
];

export default function DashboardPage() {
  const [showPrivateKeys, setShowPrivateKeys] = useState(false);
  const [showWrapDialog, setShowWrapDialog] = useState(false);
  const [wrapForm, setWrapForm] = useState({
    tokenAddress: "",
    amount: "",
  });
  const [wrapLoading, setWrapLoading] = useState(false);
  const [approveLoading, setApproveLoading] = useState(false);
  const [wrapError, setWrapError] = useState<string | null>(null);
  const [wrapStep, setWrapStep] = useState<'initial' | 'approved' | 'completed'>('initial');
  const [transactionHashes, setTransactionHashes] = useState<{
    approveHash?: string;
    depositHash?: string;
  }>({});
  const [stellarKit, setStellarKit] = useState<StellarWalletsKit | null>(null);
  const [accountStatus, setAccountStatus] = useState<{
    loading: boolean;
    exists: boolean;
    balance?: string;
    error?: string;
  } | null>(null);

  const { userData, hasStellarConnection } = useUser();

  // Initialize Stellar Wallets Kit (optional - we have direct Albedo fallback)
  useEffect(() => {
    try {
      const kit = new StellarWalletsKit({
        network: WalletNetwork.TESTNET,
        selectedWalletId: 'albedo', // Use Albedo wallet
        modules: allowAllModules(),
      });
      setStellarKit(kit);
      console.log("Stellar Wallets Kit initialized with Albedo");
    } catch (err) {
      console.warn("Failed to initialize Stellar Wallets Kit, will use direct Albedo connection:", err);
    }
  }, []);

  // Check account status when dialog opens
  useEffect(() => {
    if (showWrapDialog && userData?.stellarPublicAddress) {
      checkUserAccountStatus();
    }
  }, [showWrapDialog, userData?.stellarPublicAddress]);

  const getStatusIcon = (status: string) => {
    switch (status) {
      case "completed":
        return <CheckCircle className="w-4 h-4 text-green-400" />;
      case "pending":
        return <Clock className="w-4 h-4 text-yellow-400" />;
      case "failed":
        return <XCircle className="w-4 h-4 text-red-400" />;
      default:
        return <Clock className="w-4 h-4 text-gray-400" />;
    }
  };

  const getStatusColor = (status: string) => {
    switch (status) {
      case "completed":
        return "bg-green-500/20 text-green-400 border-green-500/30";
      case "pending":
        return "bg-yellow-500/20 text-yellow-400 border-yellow-500/30";
      case "failed":
        return "bg-red-500/20 text-red-400 border-red-500/30";
      default:
        return "bg-gray-500/20 text-gray-400 border-gray-500/30";
    }
  };

  const copyToClipboard = async (text: string) => {
    try {
      await navigator.clipboard.writeText(text);
    } catch (err) {
      console.error("Failed to copy to clipboard:", err);
    }
  };

  // Check if account exists and is funded
  const checkAccountStatus = async (address: string) => {
    try {
      const account = await server.getAccount(address);
      return { exists: true, account };
    } catch (error: any) {
      if (error.response?.status === 404) {
        return { exists: false, account: null };
      }
      throw error;
    }
  };

  const checkUserAccountStatus = async () => {
    if (!userData?.stellarPublicAddress) return;
    
    setAccountStatus({ loading: true, exists: false });
    
    try {
      const status = await checkAccountStatus(userData.stellarPublicAddress);
      if (status.exists && status.account) {
        const xlmBalance = status.account.balances.find((b: any) => b.asset_type === 'native')?.balance || '0';
        setAccountStatus({
          loading: false,
          exists: true,
          balance: xlmBalance
        });
      } else {
        setAccountStatus({
          loading: false,
          exists: false
        });
      }
    } catch (error: any) {
      setAccountStatus({
        loading: false,
        exists: false,
        error: error.message
      });
    }
  };

  // Create transaction for approval
  const createApprovalTransaction = async (
    tokenAddress: string,
    spenderAddress: string,
    amount: string,
    userAddress: string
  ) => {
    const account = await server.getAccount(userAddress);
    const contract = new Contract(tokenAddress);

    const operation = contract.call(
      "approve",
      nativeToScVal(BigInt(amount), { type: "u128" }),
      nativeToScVal(spenderAddress, { type: "address" }),
      nativeToScVal(userAddress, { type: "address" })
    );

    const transaction = new TransactionBuilder(account, {
      fee: "100000000",
      networkPassphrase: networkPassphrase,
    })
      .addOperation(operation)
      .setTimeout(300)
      .build();

    return transaction;
  };

  // Create transaction for deposit
  const createDepositTransaction = async (
    tokenAddress: string,
    amount: string,
    userAddress: string
  ) => {
    const account = await server.getAccount(userAddress);
    const wrappedContract = new Contract(WRAPPED_TOKEN_CONTRACT_ADDRESS);

    const operation = wrappedContract.call(
      "deposit",
      nativeToScVal(tokenAddress, { type: "address" }),
      nativeToScVal(BigInt(amount), { type: "u128" }),
      nativeToScVal(userAddress, { type: "address" })
    );

    const transaction = new TransactionBuilder(account, {
      fee: "10000000",
      networkPassphrase: networkPassphrase,
    })
      .addOperation(operation)
      .setTimeout(300)
      .build();

    return transaction;
  };

  // Wait for transaction confirmation
  const waitForTransaction = async (hash: string, maxWaitTime = 30000) => {
    const startTime = Date.now();
    while (Date.now() - startTime < maxWaitTime) {
      try {
        const transaction = await server.getTransaction(hash);
        if (transaction && transaction.successful) {
          return true;
        }
      } catch (error) {
        // Transaction might not be available yet, continue waiting
      }
      await new Promise(resolve => setTimeout(resolve, 2000));
    }
    return false;
  };

  const handleApproveTokens = async () => {
    if (!wrapForm.tokenAddress || !wrapForm.amount) {
      setWrapError("Please fill in all fields");
      return;
    }

    if (!userData?.stellarPublicAddress) {
      setWrapError("Stellar address not available. Please connect your Stellar wallet.");
      return;
    }

    setApproveLoading(true);
    setWrapError(null);

    try {
      const userAddress = userData.stellarPublicAddress;
      const amountInUnits = tokensToUnits(wrapForm.amount);

      console.log("Creating approval transaction...");
      console.log("User address:", userAddress);
      console.log("Token address:", wrapForm.tokenAddress);
      console.log("Amount in units:", amountInUnits);

      // Double-check account exists before creating transaction
      try {
        const accountCheck = await server.getAccount(userAddress);
        console.log("Account verified:", accountCheck.account_id);
      } catch (accountError) {
        console.error("Account verification failed:", accountError);
        setWrapError("Account not found on network. Please ensure your account is funded with at least 1 XLM.");
        return;
      }

      const approvalTx = await createApprovalTransaction(
        wrapForm.tokenAddress,
        WRAPPED_TOKEN_CONTRACT_ADDRESS,
        amountInUnits,
        userAddress
      );

      console.log("Signing approval transaction...");
      
      // Use the stellarKit from the WalletConnection component or direct Albedo if available
      let signedTxXdr;
      
      if (stellarKit) {
        try {
          const signedApproval = await stellarKit.signTransaction(approvalTx.toXDR(), {
            address: userAddress,
            networkPassphrase: networkPassphrase,
          });
          signedTxXdr = signedApproval.signedTxXdr;
        } catch (kitError) {
          console.warn("Stellar Wallets Kit failed, trying direct Albedo...", kitError);
          
          // Fallback to direct Albedo connection
          if (typeof window !== 'undefined' && (window as any).albedo) {
            const albedoResult = await (window as any).albedo.tx({
              xdr: approvalTx.toXDR(),
              network: 'testnet',
              submit: false
            });
            signedTxXdr = albedoResult.signed_envelope_xdr;
          } else {
            throw new Error("Neither Stellar Wallets Kit nor direct Albedo connection available");
          }
        }
      } else {
        // Direct Albedo fallback
        if (typeof window !== 'undefined' && (window as any).albedo) {
          console.log("Using direct Albedo connection...");
          const albedoResult = await (window as any).albedo.tx({
            xdr: approvalTx.toXDR(),
            network: 'testnet',
            submit: false
          });
          signedTxXdr = albedoResult.signed_envelope_xdr;
        } else {
          throw new Error("No wallet connection available");
        }
      }

      console.log("Submitting approval transaction...");
      const approvalTxFromXDR = StellarSdk.TransactionBuilder.fromXDR(signedTxXdr, networkPassphrase);
      const approvalResponse = await server.sendTransaction(approvalTxFromXDR);
      
      console.log("Approval response:", approvalResponse);
      
      if (approvalResponse.status === 'ERROR') {
        const resultCodes = approvalResponse.extras?.result_codes;
        console.error("Transaction failed with codes:", resultCodes);
        throw new Error(`Transaction failed: ${resultCodes?.transaction || resultCodes?.operations?.[0] || 'Unknown error'}`);
      }

      console.log("Approval submitted:", approvalResponse.hash);

      // Wait for transaction confirmation
      console.log("Waiting for approval confirmation...");
      const confirmed = await waitForTransaction(approvalResponse.hash);
      
      if (!confirmed) {
        console.warn("Approval transaction not confirmed within timeout, but proceeding...");
      }

      setTransactionHashes(prev => ({ ...prev, approveHash: approvalResponse.hash }));
      setWrapStep('approved');

      // Refresh account status after successful transaction
      setTimeout(() => {
        checkUserAccountStatus();
      }, 1000);

    } catch (error: any) {
      console.error("Approval failed:", error);
      
      if (error.message?.includes("User declined") || error.message?.includes("User rejected") || error.message?.includes("rejected")) {
        setWrapError("Transaction was cancelled by user.");
      } else if (error.message?.includes("op_underfunded")) {
        setWrapError("Insufficient XLM balance for transaction fees.");
      } else if (error.message?.includes("op_no_account") || error.message?.includes("Account not found")) {
        setWrapError("Account not found. Please ensure your Stellar account is funded with at least 1 XLM.");
      } else if (error.message?.includes("not connected")) {
        setWrapError("Wallet connection issue. Please disconnect and reconnect your Albedo wallet.");
      } else if (error.message?.includes("Transaction failed")) {
        setWrapError(error.message);
      } else {
        setWrapError(`Approval failed: ${error.message || 'Unknown error'}`);
      }
    } finally {
      setApproveLoading(false);
    }
  };

  const handleWrapTokens = async () => {
    if (!userData?.stellarPublicAddress) {
      setWrapError("Wallet not properly connected.");
      return;
    }

    setWrapLoading(true);
    setWrapError(null);

    try {
      const userAddress = userData.stellarPublicAddress;
      const amountInUnits = tokensToUnits(wrapForm.amount);

      console.log("Creating deposit transaction...");
      const depositTx = await createDepositTransaction(
        wrapForm.tokenAddress,
        amountInUnits,
        userAddress
      );

      console.log("Signing deposit transaction...");
      
      // Use the same wallet connection approach as approval
      let signedTxXdr;
      
      if (stellarKit) {
        try {
          const signedDeposit = await stellarKit.signTransaction(depositTx.toXDR(), {
            address: userAddress,
            networkPassphrase: networkPassphrase,
          });
          signedTxXdr = signedDeposit.signedTxXdr;
        } catch (kitError) {
          console.warn("Stellar Wallets Kit failed, trying direct Albedo...", kitError);
          
          // Fallback to direct Albedo connection
          if (typeof window !== 'undefined' && (window as any).albedo) {
            const albedoResult = await (window as any).albedo.tx({
              xdr: depositTx.toXDR(),
              network: 'testnet',
              submit: false
            });
            signedTxXdr = albedoResult.signed_envelope_xdr;
          } else {
            throw new Error("Neither Stellar Wallets Kit nor direct Albedo connection available");
          }
        }
      } else {
        // Direct Albedo fallback
        if (typeof window !== 'undefined' && (window as any).albedo) {
          console.log("Using direct Albedo connection...");
          const albedoResult = await (window as any).albedo.tx({
            xdr: depositTx.toXDR(),
            network: 'testnet',
            submit: false
          });
          signedTxXdr = albedoResult.signed_envelope_xdr;
        } else {
          throw new Error("No wallet connection available");
        }
      }

      console.log("Submitting deposit transaction...");
      const depositTxFromXDR = StellarSdk.TransactionBuilder.fromXDR(signedTxXdr, networkPassphrase);
      const depositResponse = await server.sendTransaction(depositTxFromXDR);

      if (depositResponse.status === 'ERROR') {
        const resultCodes = depositResponse.extras?.result_codes;
        console.error("Transaction failed with codes:", resultCodes);
        throw new Error(`Transaction failed: ${resultCodes?.transaction || resultCodes?.operations?.[0] || 'Unknown error'}`);
      }

      console.log("Deposit submitted:", depositResponse.hash);

      setTransactionHashes(prev => ({ ...prev, depositHash: depositResponse.hash }));
      setWrapStep('completed');

    } catch (error: any) {
      console.error("Wrap tokens failed:", error);
      
      if (error.message?.includes("User declined") || error.message?.includes("User rejected") || error.message?.includes("rejected")) {
        setWrapError("Transaction was cancelled by user.");
      } else if (error.message?.includes("op_underfunded")) {
        setWrapError("Insufficient XLM balance for transaction fees.");
      } else if (error.message?.includes("not connected")) {
        setWrapError("Wallet connection issue. Please disconnect and reconnect your Albedo wallet.");
      } else if (error.message?.includes("Transaction failed")) {
        setWrapError(error.message);
      } else {
        setWrapError(`Wrap failed: ${error.message || 'Unknown error'}`);
      }
    } finally {
      setWrapLoading(false);
    }
  };

  const resetWrapDialog = () => {
    setWrapForm({ tokenAddress: "", amount: "" });
    setWrapError(null);
    setWrapStep('initial');
    setTransactionHashes({});
    setApproveLoading(false);
    setWrapLoading(false);
    setAccountStatus(null);
  };

  // Check if user can wrap tokens
  const canWrapTokens = userData?.stellarPublicAddress && (userData?.stellarPrivateAddress || hasStellarConnection);

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-900 via-purple-900 to-slate-900">
      {/* Navigation */}
      <nav className="backdrop-blur-md bg-white/5 border-b border-white/10">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex justify-between items-center py-4">
            <Link href="/" className="flex items-center space-x-2">
              <div className="w-8 h-8 bg-gradient-to-r from-blue-500 to-purple-600 rounded-lg flex items-center justify-center">
                <ArrowUpDown className="w-5 h-5 text-white" />
              </div>
              <span className="text-xl font-bold text-white">
                StellarBridge
              </span>
            </Link>

            <div className="flex items-center space-x-4">
              <Link href="/swap">
                <Button
                  variant="ghost"
                  className="text-gray-300 hover:text-white"
                >
                  Swap
                </Button>
              </Link>
              <Link href="/solver">
                <Button
                  variant="ghost"
                  className="text-gray-300 hover:text-white"
                >
                  Solver Dashboard
                </Button>
              </Link>
              <WalletConnection />
            </div>
          </div>
        </div>
      </nav>

      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div className="mb-8">
          <h1 className="text-3xl font-bold text-white mb-2">Dashboard</h1>
          <p className="text-gray-400">
            Manage your cross-chain transactions and account details
          </p>
        </div>

        <Tabs defaultValue="overview" className="space-y-6">
          <TabsList className="bg-white/5 border-white/10">
            <TabsTrigger
              value="overview"
              className="data-[state=active]:bg-white/10"
            >
              Overview
            </TabsTrigger>
            <TabsTrigger
              value="transactions"
              className="data-[state=active]:bg-white/10"
            >
              Transactions
            </TabsTrigger>
            <TabsTrigger
              value="accounts"
              className="data-[state=active]:bg-white/10"
            >
              Accounts
            </TabsTrigger>
          </TabsList>

          <TabsContent value="overview" className="space-y-6">
            {/* Stats Cards */}
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
              <Card className="bg-white/5 backdrop-blur-sm border-white/10">
                <CardContent className="p-6">
                  <div className="flex items-center justify-between">
                    <div>
                      <p className="text-gray-400 text-sm">Total Volume</p>
                      <p className="text-2xl font-bold text-white">$12,450</p>
                    </div>
                    <TrendingUp className="w-8 h-8 text-green-400" />
                  </div>
                  <p className="text-green-400 text-sm mt-2">
                    +12.5% from last month
                  </p>
                </CardContent>
              </Card>

              <Card className="bg-white/5 backdrop-blur-sm border-white/10">
                <CardContent className="p-6">
                  <div className="flex items-center justify-between">
                    <div>
                      <p className="text-gray-400 text-sm">Total Swaps</p>
                      <p className="text-2xl font-bold text-white">47</p>
                    </div>
                    <ArrowUpDown className="w-8 h-8 text-blue-400" />
                  </div>
                  <p className="text-blue-400 text-sm mt-2">8 this week</p>
                </CardContent>
              </Card>

              <Card className="bg-white/5 backdrop-blur-sm border-white/10">
                <CardContent className="p-6">
                  <div className="flex items-center justify-between">
                    <div>
                      <p className="text-gray-400 text-sm">Success Rate</p>
                      <p className="text-2xl font-bold text-white">98.3%</p>
                    </div>
                    <CheckCircle className="w-8 h-8 text-green-400" />
                  </div>
                  <p className="text-green-400 text-sm mt-2">
                    Excellent performance
                  </p>
                </CardContent>
              </Card>

              <Card className="bg-white/5 backdrop-blur-sm border-white/10">
                <CardContent className="p-6">
                  <div className="flex items-center justify-between">
                    <div>
                      <p className="text-gray-400 text-sm">Avg. Fee</p>
                      <p className="text-2xl font-bold text-white">0.28%</p>
                    </div>
                    <TrendingUp className="w-8 h-8 text-purple-400" />
                  </div>
                  <p className="text-purple-400 text-sm mt-2">
                    Below market average
                  </p>
                </CardContent>
              </Card>
            </div>

            {/* Recent Transactions */}
            <Card className="bg-white/5 backdrop-blur-sm border-white/10">
              <CardHeader>
                <CardTitle className="text-white">
                  Recent Transactions
                </CardTitle>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  {transactions.slice(0, 3).map((tx) => (
                    <div
                      key={tx.id}
                      className="flex items-center justify-between p-4 bg-white/5 rounded-lg border border-white/10"
                    >
                      <div className="flex items-center space-x-4">
                        {getStatusIcon(tx.status)}
                        <div>
                          <div className="flex items-center space-x-2">
                            <span className="text-white font-medium">
                              {tx.from} → {tx.to}
                            </span>
                            <Badge className={getStatusColor(tx.status)}>
                              {tx.status}
                            </Badge>
                          </div>
                          <p className="text-gray-400 text-sm">
                            {tx.timestamp}
                          </p>
                        </div>
                      </div>
                      <div className="text-right">
                        <p className="text-white">
                          {tx.fromAmount} {tx.from}
                        </p>
                        <p className="text-gray-400 text-sm">{tx.fee} fee</p>
                      </div>
                    </div>
                  ))}
                </div>
              </CardContent>
            </Card>
          </TabsContent>

          <TabsContent value="transactions" className="space-y-6">
            <Card className="bg-white/5 backdrop-blur-sm border-white/10">
              <CardHeader>
                <CardTitle className="text-white">
                  Transaction History
                </CardTitle>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  {transactions.map((tx) => (
                    <div
                      key={tx.id}
                      className="p-4 bg-white/5 rounded-lg border border-white/10"
                    >
                      <div className="flex items-center justify-between mb-3">
                        <div className="flex items-center space-x-3">
                          {getStatusIcon(tx.status)}
                          <div>
                            <div className="flex items-center space-x-2">
                              <span className="text-white font-medium">
                                {tx.from} → {tx.to}
                              </span>
                              <Badge className={getStatusColor(tx.status)}>
                                {tx.status}
                              </Badge>
                            </div>
                            <p className="text-gray-400 text-sm">ID: {tx.id}</p>
                          </div>
                        </div>
                        <Button
                          variant="ghost"
                          size="sm"
                          className="text-gray-400 hover:text-white"
                        >
                          <ExternalLink className="w-4 h-4" />
                        </Button>
                      </div>

                      <div className="grid grid-cols-2 md:grid-cols-4 gap-4 text-sm">
                        <div>
                          <p className="text-gray-400">From Amount</p>
                          <p className="text-white">
                            {tx.fromAmount} {tx.from}
                          </p>
                        </div>
                        <div>
                          <p className="text-gray-400">To Amount</p>
                          <p className="text-white">
                            {tx.toAmount} {tx.to}
                          </p>
                        </div>
                        <div>
                          <p className="text-gray-400">Fee</p>
                          <p className="text-white">{tx.fee}</p>
                        </div>
                        <div>
                          <p className="text-gray-400">Rate</p>
                          <p className="text-white">{tx.rate}</p>
                        </div>
                      </div>

                      <div className="mt-3 pt-3 border-t border-white/10">
                        <p className="text-gray-400 text-sm">
                          Timestamp: {tx.timestamp}
                        </p>
                      </div>
                    </div>
                  ))}
                </div>
              </CardContent>
            </Card>
          </TabsContent>

          <TabsContent value="accounts" className="space-y-6">
            <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
              {/* EVM Account */}
              <Card className="bg-white/5 backdrop-blur-sm border-white/10">
                <CardHeader>
                  <CardTitle className="text-white flex items-center justify-between">
                    EVM Account
                    <Badge className="bg-blue-500/20 text-blue-400 border-blue-500/30">
                      ETH
                    </Badge>
                  </CardTitle>
                </CardHeader>
                <CardContent className="space-y-4">
                  <div>
                    <p className="text-gray-400 text-sm mb-1">EVM Address</p>
                    <div className="flex items-center space-x-2 p-2 bg-white/5 rounded border border-white/10">
                      <code className="text-white text-sm font-mono truncate min-w-0 flex-1">
                        {userData?.ethPublicAddress || "Connect wallet to see"}
                      </code>
                      {userData?.ethPublicAddress && (
                        <Button
                          variant="ghost"
                          size="sm"
                          className="text-gray-400 hover:text-white flex-shrink-0"
                          onClick={() => copyToClipboard(userData.ethPublicAddress)}
                        >
                          <Copy className="w-4 h-4" />
                        </Button>
                      )}
                    </div>
                  </div>

                  <div>
                    <div className="flex items-center justify-between mb-1">
                      <p className="text-gray-400 text-sm">Private Key</p>
                      <Button
                        variant="ghost"
                        size="sm"
                        onClick={() => setShowPrivateKeys(!showPrivateKeys)}
                        className="text-gray-400 hover:text-white flex-shrink-0"
                      >
                        {showPrivateKeys ? (
                          <EyeOff className="w-4 h-4" />
                        ) : (
                          <Eye className="w-4 h-4" />
                        )}
                      </Button>
                    </div>
                    <div className="flex items-center space-x-2 p-2 bg-white/5 rounded border border-white/10">
                      <code className="text-white text-sm font-mono truncate min-w-0 flex-1">
                        {showPrivateKeys
                          ? userData?.ethPrivateAddress ||
                            "Connect wallet to see"
                          : "••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••"}
                      </code>
                      {userData?.ethPrivateAddress && showPrivateKeys && (
                        <Button
                          variant="ghost"
                          size="sm"
                          className="text-gray-400 hover:text-white flex-shrink-0"
                          onClick={() => copyToClipboard(userData.ethPrivateAddress)}
                        >
                          <Copy className="w-4 h-4" />
                        </Button>
                      )}
                    </div>
                  </div>

                  <div className="pt-4 border-t border-white/10">
                    <p className="text-gray-400 text-sm mb-2">Token Balances</p>
                    <div className="space-y-2">
                      <div className="flex justify-between">
                        <span className="text-white">ETH</span>
                        <span className="text-white">2.45</span>
                      </div>
                      <div className="flex justify-between">
                        <span className="text-white">USDC</span>
                        <span className="text-white">1,250.00</span>
                      </div>
                    </div>
                  </div>
                </CardContent>
              </Card>

              {/* Stellar Account */}
              <Card className="bg-white/5 backdrop-blur-sm border-white/10">
                <CardHeader>
                  <CardTitle className="text-white flex items-center justify-between">
                    Stellar Account
                    <Badge className="bg-purple-500/20 text-purple-400 border-purple-500/30">
                      XLM
                    </Badge>
                  </CardTitle>
                </CardHeader>
                <CardContent className="space-y-4">
                  <div>
                    <p className="text-gray-400 text-sm mb-1">
                      Stellar Address
                    </p>
                    <div className="flex items-center space-x-2 p-2 bg-white/5 rounded border border-white/10">
                      <code className="text-white text-sm font-mono truncate min-w-0 flex-1">
                        {userData?.stellarPublicAddress ||
                          "Connect wallet to see"}
                      </code>
                      {userData?.stellarPublicAddress && (
                        <Button
                          variant="ghost"
                          size="sm"
                          className="text-gray-400 hover:text-white flex-shrink-0"
                          onClick={() => copyToClipboard(userData.stellarPublicAddress)}
                        >
                          <Copy className="w-4 h-4" />
                        </Button>
                      )}
                    </div>
                  </div>

                  <div>
                    <div className="flex items-center justify-between mb-1">
                      <p className="text-gray-400 text-sm">Private Key</p>
                      <Button
                        variant="ghost"
                        size="sm"
                        onClick={() => setShowPrivateKeys(!showPrivateKeys)}
                        className="text-gray-400 hover:text-white flex-shrink-0"
                      >
                        {showPrivateKeys ? (
                          <EyeOff className="w-4 h-4" />
                        ) : (
                          <Eye className="w-4 h-4" />
                        )}
                      </Button>
                    </div>
                    <div className="flex items-center space-x-2 p-2 bg-white/5 rounded border border-white/10">
                      <code className="text-white text-sm font-mono truncate min-w-0 flex-1">
                        {showPrivateKeys
                          ? userData?.stellarPrivateAddress ||
                            "Secured by wallet"
                          : "••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••"}
                      </code>
                      {userData?.stellarPrivateAddress && showPrivateKeys && (
                        <Button
                          variant="ghost"
                          size="sm"
                          className="text-gray-400 hover:text-white flex-shrink-0"
                          onClick={() => copyToClipboard(userData.stellarPrivateAddress)}
                        >
                          <Copy className="w-4 h-4" />
                        </Button>
                      )}
                    </div>
                  </div>

                  <div className="pt-4 border-t border-white/10">
                    <div className="flex items-center justify-between mb-2">
                      <p className="text-gray-400 text-sm">Token Balances</p>
                      {canWrapTokens && (
                        <Dialog open={showWrapDialog} onOpenChange={(open) => {
                          setShowWrapDialog(open);
                          if (!open) resetWrapDialog();
                        }}>
                          <DialogTrigger asChild>
                            <Button
                              size="sm"
                              className="bg-gradient-to-r from-purple-500 to-pink-600 hover:from-purple-600 hover:to-pink-700 text-xs"
                            >
                              <Coins className="w-3 h-3 mr-1" />
                              Wrap Tokens
                            </Button>
                          </DialogTrigger>
                          <DialogContent className="bg-slate-900 border-white/10 text-white max-w-lg">
                            <DialogHeader>
                              <DialogTitle>Wrap Mock Tokens</DialogTitle>
                            </DialogHeader>
                            <div className="space-y-4">
                              {/* Account Status Check */}
                              {accountStatus && (
                                <div className={`border rounded p-3 ${
                                  accountStatus.loading 
                                    ? "border-gray-500/30 bg-gray-500/10" 
                                    : accountStatus.exists 
                                    ? "border-green-500/30 bg-green-500/10" 
                                    : "border-red-500/30 bg-red-500/10"
                                }`}>
                                  <div className="text-sm space-y-1">
                                    <div className="font-medium flex items-center justify-between">
                                      <div className="flex items-center">
                                        {accountStatus.loading ? (
                                          <>
                                            <Loader2 className="w-4 h-4 mr-2 animate-spin" />
                                            <span className="text-gray-400">Checking Account Status...</span>
                                          </>
                                        ) : accountStatus.exists ? (
                                          <>
                                            <CheckCircle className="w-4 h-4 mr-2 text-green-400" />
                                            <span className="text-green-400">Account Found</span>
                                          </>
                                        ) : (
                                          <>
                                            <XCircle className="w-4 h-4 mr-2 text-red-400" />
                                            <span className="text-red-400">Account Status Check Failed</span>
                                          </>
                                        )}
                                      </div>
                                      <Button
                                        onClick={checkUserAccountStatus}
                                        disabled={accountStatus.loading}
                                        size="sm"
                                        variant="outline"
                                        className="border-white/20 text-white hover:bg-white/10 text-xs h-6 px-2"
                                      >
                                        {accountStatus.loading ? (
                                          <Loader2 className="w-3 h-3" />
                                        ) : (
                                          "Refresh"
                                        )}
                                      </Button>
                                    </div>
                                    {accountStatus.exists && accountStatus.balance && (
                                      <div className="text-green-400 text-xs">
                                        XLM Balance: {parseFloat(accountStatus.balance).toFixed(4)} XLM
                                      </div>
                                    )}
                                    {!accountStatus.exists && !accountStatus.loading && (
                                      <div className="space-y-2">
                                        <div className="text-yellow-400 text-xs">
                                          ⚠️ Automatic check failed, but you can still proceed if your account is funded
                                        </div>
                                        <div className="flex space-x-2">
                                          <Button
                                            onClick={() => window.open("https://laboratory.stellar.org/#account-creator?network=test", "_blank")}
                                            size="sm"
                                            variant="outline"
                                            className="border-red-500/30 text-red-400 hover:bg-red-500/10 text-xs h-6"
                                          >
                                            <ExternalLink className="w-3 h-3 mr-1" />
                                            Fund Account
                                          </Button>
                                          <Button
                                            onClick={() => window.open(`https://stellar.expert/explorer/testnet/account/${userData?.stellarPublicAddress}`, "_blank")}
                                            size="sm"
                                            variant="outline"
                                            className="border-blue-500/30 text-blue-400 hover:bg-blue-500/10 text-xs h-6"
                                          >
                                            <ExternalLink className="w-3 h-3 mr-1" />
                                            Check Explorer
                                          </Button>
                                        </div>
                                      </div>
                                    )}
                                  </div>
                                </div>
                              )}

                              {/* Process Steps Indicator */}
                              <div className="bg-blue-500/10 border border-blue-500/30 rounded p-3">
                                <div className="text-blue-400 text-sm space-y-2">
                                  <div className="font-medium">📝 Two-Step Process:</div>
                                  <div className={`flex items-center space-x-2 ${wrapStep === 'initial' ? 'text-blue-400' : wrapStep === 'approved' ? 'text-green-400' : 'text-gray-400'}`}>
                                    {wrapStep === 'approved' || wrapStep === 'completed' ? <CheckCircle className="w-4 h-4" /> : <div className="w-4 h-4 rounded-full border-2 border-current"></div>}
                                    <span>1. Approve spending of mock tokens</span>
                                  </div>
                                  <div className={`flex items-center space-x-2 ${wrapStep === 'completed' ? 'text-green-400' : wrapStep === 'approved' ? 'text-blue-400' : 'text-gray-400'}`}>
                                    {wrapStep === 'completed' ? <CheckCircle className="w-4 h-4" /> : <div className="w-4 h-4 rounded-full border-2 border-current"></div>}
                                    <span>2. Deposit tokens to get wrapped tokens</span>
                                  </div>
                                  {accountStatus?.exists && (
                                    <div className="pt-1">
                                      <Button
                                        onClick={() => window.open("https://laboratory.stellar.org/#account-creator?network=test", "_blank")}
                                        size="sm"
                                        variant="outline"
                                        className="border-blue-500/30 text-blue-400 hover:bg-blue-500/10 text-xs"
                                      >
                                        <ExternalLink className="w-3 h-3 mr-1" />
                                        View on Stellar Laboratory
                                      </Button>
                                    </div>
                                  )}
                                </div>
                              </div>
                              
                              <div className="space-y-4">
                                <div className="space-y-2">
                                  <Label htmlFor="token-address" className="text-white">
                                    Mock Token Contract Address
                                  </Label>
                                  <Input
                                    id="token-address"
                                    type="text"
                                    placeholder="Enter mock token contract address"
                                    value={wrapForm.tokenAddress}
                                    onChange={(e) => setWrapForm(prev => ({ ...prev, tokenAddress: e.target.value }))}
                                    className="bg-white/5 border-white/10 text-white font-mono text-sm"
                                    disabled={approveLoading || wrapLoading}
                                  />
                                  <p className="text-xs text-gray-500">
                                    Example: CCNITQBI3QTUQU5P55SJKBWCZDKTBB5FADYGZQGGZCAR5D7KGNT63O55
                                  </p>
                                </div>

                                <div className="space-y-2">
                                  <Label htmlFor="amount" className="text-white">
                                    Amount (tokens)
                                  </Label>
                                  <Input
                                    id="amount"
                                    type="number"
                                    placeholder="Enter amount of tokens"
                                    value={wrapForm.amount}
                                    onChange={(e) => setWrapForm(prev => ({ ...prev, amount: e.target.value }))}
                                    className="bg-white/5 border-white/10 text-white"
                                    disabled={approveLoading || wrapLoading}
                                    min="0"
                                    step="0.01"
                                  />
                                  <p className="text-xs text-gray-500">
                                    Enter amount in normal token units (e.g., 100 for 100 tokens)
                                  </p>
                                </div>
                              </div>

                              {wrapError && (
                                <Alert className="bg-red-500/10 border-red-500/30 text-red-400">
                                  <AlertCircle className="h-4 w-4" />
                                  <AlertDescription className="text-sm space-y-2">
                                    <div>{wrapError}</div>
                                    {wrapError.includes("Account not found") && (
                                      <div className="pt-2">
                                        <Button
                                          onClick={() => window.open("https://laboratory.stellar.org/#account-creator?network=test", "_blank")}
                                          size="sm"
                                          variant="outline"
                                          className="border-red-500/30 text-red-400 hover:bg-red-500/10 text-xs"
                                        >
                                          <ExternalLink className="w-3 h-3 mr-1" />
                                          Fund Account on Stellar Laboratory
                                        </Button>
                                      </div>
                                    )}
                                  </AlertDescription>
                                </Alert>
                              )}

                              {/* Transaction Results */}
                              {(transactionHashes.approveHash || transactionHashes.depositHash) && (
                                <Alert className="bg-green-500/10 border-green-500/30 text-green-400">
                                  <CheckCircle className="h-4 w-4" />
                                  <AlertDescription className="text-sm space-y-3">
                                    <div className="font-medium">
                                      {wrapStep === 'completed' ? '✅ Tokens wrapped successfully!' : '✅ Approval successful!'}
                                    </div>
                                    {transactionHashes.approveHash && (
                                      <div className="space-y-1">
                                        <div className="text-xs text-gray-400">Approval Transaction:</div>
                                        <div className="bg-white/5 p-2 rounded text-xs font-mono break-all">
                                          {transactionHashes.approveHash}
                                        </div>
                                        <Button
                                          onClick={() => window.open(`https://stellar.expert/explorer/testnet/tx/${transactionHashes.approveHash}`, "_blank")}
                                          size="sm"
                                          variant="outline"
                                          className="border-green-500/30 text-green-400 hover:bg-green-500/10 text-xs"
                                        >
                                          <ExternalLink className="w-3 h-3 mr-1" />
                                          View in Explorer
                                        </Button>
                                      </div>
                                    )}
                                    {transactionHashes.depositHash && (
                                      <div className="space-y-1">
                                        <div className="text-xs text-gray-400">Deposit Transaction:</div>
                                        <div className="bg-white/5 p-2 rounded text-xs font-mono break-all">
                                          {transactionHashes.depositHash}
                                        </div>
                                        <Button
                                          onClick={() => window.open(`https://stellar.expert/explorer/testnet/tx/${transactionHashes.depositHash}`, "_blank")}
                                          size="sm"
                                          variant="outline"
                                          className="border-green-500/30 text-green-400 hover:bg-green-500/10 text-xs"
                                        >
                                          <ExternalLink className="w-3 h-3 mr-1" />
                                          View in Explorer
                                        </Button>
                                      </div>
                                    )}
                                  </AlertDescription>
                                </Alert>
                              )}

                              <div className="space-y-2">
                                <div className="flex space-x-2">
                                  {wrapStep === 'initial' && (
                                    <Button
                                      onClick={handleApproveTokens}
                                      disabled={approveLoading || !wrapForm.tokenAddress.trim() || !wrapForm.amount.trim()}
                                      className="flex-1 bg-gradient-to-r from-blue-500 to-blue-600 hover:from-blue-600 hover:to-blue-700 disabled:opacity-50"
                                    >
                                      {approveLoading ? (
                                        <>
                                          <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                                          Approving...
                                        </>
                                      ) : (
                                        "Approve Tokens"
                                      )}
                                    </Button>
                                  )}
                                  
                                  {wrapStep === 'approved' && (
                                    <Button
                                      onClick={handleWrapTokens}
                                      disabled={wrapLoading}
                                      className="flex-1 bg-gradient-to-r from-purple-500 to-pink-600 hover:from-purple-600 hover:to-pink-700"
                                    >
                                      {wrapLoading ? (
                                        <>
                                          <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                                          Wrapping...
                                        </>
                                      ) : (
                                        "Wrap Tokens"
                                      )}
                                    </Button>
                                  )}

                                  {wrapStep === 'completed' && (
                                    <Button
                                      onClick={resetWrapDialog}
                                      className="flex-1 bg-gradient-to-r from-green-500 to-green-600 hover:from-green-600 hover:to-green-700"
                                    >
                                      Wrap More Tokens
                                    </Button>
                                  )}

                                  <Button
                                    onClick={() => setShowWrapDialog(false)}
                                    variant="outline"
                                    className="border-white/20 text-white hover:bg-white/10"
                                    disabled={approveLoading || wrapLoading}
                                  >
                                    {wrapStep === 'completed' ? 'Close' : 'Cancel'}
                                  </Button>
                                </div>
                                
                              {/* Debug info when account check fails */}
                                {!accountStatus?.exists && !accountStatus?.loading && wrapForm.tokenAddress && wrapForm.amount && wrapStep === 'initial' && (
                                  <div className="text-xs text-yellow-400 bg-yellow-500/10 border border-yellow-500/30 rounded p-2">
                                    <div>⚠️ Account status check failed, but you can still proceed.</div>
                                    <div className="mt-1 text-gray-400">
                                      Debug: Address={userData?.stellarPublicAddress?.slice(0,8)}..., 
                                      Token={wrapForm.tokenAddress.slice(0,8)}..., 
                                      Amount={wrapForm.amount}
                                    </div>
                                    <div className="mt-1 text-gray-400">
                                      Kit: {stellarKit ? 'Initialized' : 'Not initialized'}, 
                                      Albedo: {typeof window !== 'undefined' && (window as any).albedo ? 'Available' : 'Not available'}
                                    </div>
                                  </div>
                                )}

                                {/* Button is disabled debug */}
                                {wrapStep === 'initial' && (!wrapForm.tokenAddress.trim() || !wrapForm.amount.trim()) && (
                                  <div className="text-xs text-gray-400 bg-gray-500/10 border border-gray-500/30 rounded p-2">
                                    Button disabled: {!wrapForm.tokenAddress.trim() ? 'Missing token address' : ''} {!wrapForm.amount.trim() ? 'Missing amount' : ''}
                                  </div>
                                )}
                              </div>
                            </div>
                          </DialogContent>
                        </Dialog>
                      )}
                    </div>
                    <div className="space-y-2">
                      <div className="flex justify-between">
                        <span className="text-white">XLM</span>
                        <span className="text-white">5,000.00</span>
                      </div>
                      <div className="flex justify-between">
                        <span className="text-white">USDC</span>
                        <span className="text-white">750.00</span>
                      </div>
                    </div>
                  </div>
                </CardContent>
              </Card>
            </div>
          </TabsContent>
        </Tabs>
      </div>
    </div>
  );
}