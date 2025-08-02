"use client";

import { useState, useEffect } from "react";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog";
import { Wallet, Copy, ExternalLink, ChevronDown, Loader2 } from "lucide-react";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { useUser } from "@/context/user-context";
import axios from "axios";

// Import Stellar Wallets Kit
import {
  StellarWalletsKit,
  WalletNetwork,
  allowAllModules,
  FREIGHTER_ID,
  ISupportedWallet,
} from "@creit.tech/stellar-wallets-kit";

export function WalletConnection() {
  const { userData, setUserData, isConnected, setIsConnected } = useUser();
  const [showBalances, setShowBalances] = useState(false);
  const [showEmailDialog, setShowEmailDialog] = useState(false);
  const [email, setEmail] = useState("");
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [stellarKit, setStellarKit] = useState<StellarWalletsKit | null>(null);

  // Initialize Stellar Wallets Kit
  useEffect(() => {
    try {
      const kit = new StellarWalletsKit({
        network: WalletNetwork.TESTNET, // Change to MAINNET for production
        selectedWalletId: FREIGHTER_ID,
        modules: allowAllModules(),
      });
      setStellarKit(kit);
    } catch (err) {
      console.error("Failed to initialize Stellar Wallets Kit:", err);
    }
  }, []);

  const handleEmailConnect = async () => {
    setIsLoading(true);
    setError(null);
    try {
      const response = await axios.post("http://localhost:3001/user/register", {
        email,
      });

      if (response.data && response.data.user) {
        setUserData(response.data.user);
        setShowEmailDialog(false);
        setShowBalances(true);
      } else {
        throw new Error(
          response.data.message ||
            "Failed to connect wallet. Invalid response format."
        );
      }
    } catch (err: any) {
      setError(
        err.response?.data?.message ||
          err.message ||
          "An unexpected error occurred."
      );
      console.error("Wallet connection error:", err);
    } finally {
      setIsLoading(false);
    }
  };

  const handleMetamaskConnect = async () => {
    setIsLoading(true);
    setError(null);
    try {
      if (typeof window !== "undefined" && (window as any).ethereum) {
        const ethereum = (window as any).ethereum;
        const accounts = await ethereum.request({
          method: "eth_requestAccounts",
        });
        if (accounts.length > 0) {
          const ethPublicAddress = accounts[0];
          setUserData({
            email: "",
            ethPublicAddress: ethPublicAddress,
            ethPrivateAddress: "",
            stellarPublicAddress: userData?.stellarPublicAddress || "",
            stellarPrivateAddress: userData?.stellarPrivateAddress || "",
          });
          setIsConnected(true);
          setShowBalances(true);
        } else {
          throw new Error("No accounts found or connected via Metamask.");
        }
      } else {
        throw new Error(
          "MetaMask is not installed. Please install it to connect."
        );
      }
    } catch (err: any) {
      setError(err.message || "Failed to connect with MetaMask.");
      console.error("MetaMask connection error:", err);
    } finally {
      setIsLoading(false);
    }
  };

  const handleStellarConnect = async () => {
    if (!stellarKit) {
      setError("Stellar Wallets Kit not initialized.");
      return;
    }

    setIsLoading(true);
    setError(null);

    try {
      await stellarKit.openModal({
        onWalletSelected: async (option: ISupportedWallet) => {
          try {
            // Set the selected wallet
            stellarKit.setWallet(option.id);

            // Get the address from the wallet
            const { address } = await stellarKit.getAddress();

            // Update user data with Stellar address
            setUserData({
              email: userData?.email || "",
              ethPublicAddress: userData?.ethPublicAddress || "",
              ethPrivateAddress: userData?.ethPrivateAddress || "",
              stellarPublicAddress: address,
              stellarPrivateAddress: "", // Wallets don't expose private keys
            });

            setIsConnected(true);
            setShowBalances(true);
            setIsLoading(false);

            console.log(`Connected to ${option.name} with address: ${address}`);
          } catch (walletError: any) {
            console.error("Error connecting to Stellar wallet:", walletError);
            setError(
              `Failed to connect to ${option.name}: ${walletError.message}`
            );
            setIsLoading(false);
          }
        },
        onClosed: (err?: Error) => {
          setIsLoading(false);
          if (err) {
            console.error("Wallet selection modal closed with error:", err);
            setError("Wallet selection was cancelled or failed.");
          }
        },
        modalTitle: "Select Your Stellar Wallet",
        notAvailableText:
          "This wallet is not available in your browser. Please install it first.",
      });
    } catch (err: any) {
      setError(err.message || "Failed to open Stellar wallet selection.");
      console.error("Stellar wallet connection error:", err);
      setIsLoading(false);
    }
  };

  const handleDisconnect = () => {
    setIsConnected(false);
    setUserData(null);
    setShowBalances(false);
    setEmail("");
  };

  const balances = [
    { token: "ETH", amount: "2.45", chain: "Ethereum", value: "$6,125.00" },
    {
      token: "USDC",
      amount: "1,250.00",
      chain: "Ethereum",
      value: "$1,250.00",
    },
    { token: "XLM", amount: "5,000.00", chain: "Stellar", value: "$650.00" },
    { token: "USDC", amount: "750.00", chain: "Stellar", value: "$750.00" },
  ];

  return (
    <div className="flex items-center space-x-2">
      {!isConnected ? (
        <>
          <DropdownMenu>
            <DropdownMenuTrigger asChild>
              <Button
                className="bg-gradient-to-r from-blue-500 to-purple-600 hover:from-blue-600 hover:to-purple-700"
                disabled={isLoading}
              >
                {isLoading ? (
                  <>
                    <Loader2 className="w-4 h-4 mr-2 animate-spin" />
                    Connecting...
                  </>
                ) : (
                  <>
                    <Wallet className="w-4 h-4 mr-2" />
                    Connect Wallet
                  </>
                )}
              </Button>
            </DropdownMenuTrigger>
            <DropdownMenuContent className="bg-slate-800 border-white/10">
              <DropdownMenuItem
                onClick={() => setShowEmailDialog(true)}
                className="text-white hover:bg-gradient-to-r hover:from-blue-500/20 hover:to-purple-600/20 focus:bg-gradient-to-r focus:from-blue-500/20 focus:to-purple-600/20 transition-all duration-200"
                disabled={isLoading}
              >
                Enter Email
              </DropdownMenuItem>
              <DropdownMenuItem
                onClick={handleMetamaskConnect}
                className="text-white hover:bg-gradient-to-r hover:from-blue-500/20 hover:to-purple-600/20 focus:bg-gradient-to-r focus:from-blue-500/20 focus:to-purple-600/20 transition-all duration-200"
                disabled={isLoading}
              >
                Connect with MetaMask
              </DropdownMenuItem>
              <DropdownMenuItem
                onClick={handleStellarConnect}
                className="text-white hover:bg-gradient-to-r hover:from-blue-500/20 hover:to-purple-600/20 focus:bg-gradient-to-r focus:from-blue-500/20 focus:to-purple-600/20 transition-all duration-200"
                disabled={isLoading || !stellarKit}
              >
                Connect with Stellar
              </DropdownMenuItem>
            </DropdownMenuContent>
          </DropdownMenu>

          {/* Display error message */}
          {error && (
            <div className="absolute top-full mt-2 p-2 bg-red-500/10 border border-red-500/30 rounded text-red-400 text-sm max-w-xs">
              {error}
            </div>
          )}

          {/* Email Connection Dialog */}
          <Dialog open={showEmailDialog} onOpenChange={setShowEmailDialog}>
            <DialogContent className="bg-slate-900 border-white/10 text-white">
              <DialogHeader>
                <DialogTitle>Connect Your Wallet via Email</DialogTitle>
              </DialogHeader>
              <div className="space-y-4">
                <p className="text-gray-400 text-sm">
                  Enter your email to connect or create your account.
                </p>
                <div className="space-y-2">
                  <Label htmlFor="email-input" className="text-white">
                    Email Address
                  </Label>
                  <Input
                    id="email-input"
                    type="email"
                    placeholder="you@example.com"
                    value={email}
                    onChange={(e) => setEmail(e.target.value)}
                    className="bg-white/5 border-white/10 text-white"
                    disabled={isLoading}
                  />
                </div>
                {error && <p className="text-red-400 text-sm">{error}</p>}
                <Button
                  onClick={handleEmailConnect}
                  disabled={isLoading || !email}
                  className="w-full bg-gradient-to-r from-blue-500 to-purple-600 hover:from-blue-600 hover:to-purple-700"
                >
                  {isLoading ? (
                    <>
                      <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                      Connecting...
                    </>
                  ) : (
                    "Connect"
                  )}
                </Button>
              </div>
            </DialogContent>
          </Dialog>
        </>
      ) : (
        <>
          <Dialog open={showBalances} onOpenChange={setShowBalances}>
            <DialogTrigger asChild>
              <Button
                variant="outline"
                className="border-white/20 text-white hover:bg-white/10 bg-transparent"
              >
                <Wallet className="w-4 h-4 mr-2" />
                {userData?.ethPublicAddress
                  ? `${userData.ethPublicAddress.slice(
                      0,
                      6
                    )}...${userData.ethPublicAddress.slice(-3)}`
                  : userData?.stellarPublicAddress
                  ? `${userData.stellarPublicAddress.slice(
                      0,
                      6
                    )}...${userData.stellarPublicAddress.slice(-3)}`
                  : "Connected"}
              </Button>
            </DialogTrigger>
            <DialogContent className="bg-slate-900 border-white/10 text-white">
              <DialogHeader>
                <DialogTitle>Account Details</DialogTitle>
              </DialogHeader>
              <div className="space-y-6">
                {/* Account Addresses */}
                <div className="space-y-4">
                  <div>
                    <p className="text-sm text-gray-400 mb-2">EVM Address</p>
                    <div className="flex items-center space-x-2 p-2 bg-white/5 rounded border border-white/10">
                      <code className="text-sm flex-1 font-mono break-all">
                        {userData?.ethPublicAddress || "Not connected"}
                      </code>
                      {userData?.ethPublicAddress && (
                        <Button
                          variant="ghost"
                          size="sm"
                          className="text-gray-400 hover:text-white"
                        >
                          <Copy className="w-4 h-4" />
                        </Button>
                      )}
                    </div>
                  </div>

                  <div>
                    <p className="text-sm text-gray-400 mb-2">
                      Stellar Address
                    </p>
                    <div className="flex items-center space-x-2 p-2 bg-white/5 rounded border border-white/10">
                      <code className="text-sm flex-1 font-mono break-all">
                        {userData?.stellarPublicAddress || "Not connected"}
                      </code>
                      {userData?.stellarPublicAddress && (
                        <Button
                          variant="ghost"
                          size="sm"
                          className="text-gray-400 hover:text-white flex-shrink-0"
                        >
                          <Copy className="w-4 h-4" />
                        </Button>
                      )}
                    </div>
                  </div>
                </div>

                {/* Token Balances */}
                <div>
                  <p className="text-sm text-gray-400 mb-3">Token Balances</p>
                  <div className="space-y-2">
                    {balances.map((balance, index) => (
                      <div
                        key={index}
                        className="flex items-center justify-between p-3 bg-white/5 rounded border border-white/10"
                      >
                        <div className="flex items-center space-x-3">
                          <div className="w-8 h-8 bg-gradient-to-r from-blue-500 to-purple-600 rounded-full flex items-center justify-center">
                            <span className="text-xs font-bold">
                              {balance.token.slice(0, 2)}
                            </span>
                          </div>
                          <div>
                            <div className="flex items-center space-x-2">
                              <span className="font-medium">
                                {balance.token}
                              </span>
                              <Badge variant="secondary" className="text-xs">
                                {balance.chain}
                              </Badge>
                            </div>
                            <p className="text-sm text-gray-400">
                              {balance.value}
                            </p>
                          </div>
                        </div>
                        <div className="text-right">
                          <p className="font-medium">{balance.amount}</p>
                        </div>
                      </div>
                    ))}
                  </div>
                </div>

                <div className="flex space-x-2">
                  <Button
                    variant="outline"
                    className="flex-1 border-white/20 text-white hover:bg-white/10 bg-transparent"
                  >
                    <ExternalLink className="w-4 h-4 mr-2" />
                    View on Explorer
                  </Button>
                  <Button
                    onClick={handleDisconnect}
                    variant="outline"
                    className="border-red-500/30 text-red-400 hover:bg-red-500/10 bg-transparent"
                  >
                    Disconnect
                  </Button>
                </div>
              </div>
            </DialogContent>
          </Dialog>

          <DropdownMenu>
            <DropdownMenuTrigger asChild>
              <Button
                variant="ghost"
                size="sm"
                className="text-gray-400 hover:text-white"
              >
                <ChevronDown className="w-4 h-4" />
              </Button>
            </DropdownMenuTrigger>
            <DropdownMenuContent className="bg-slate-800 border-white/10">
              <DropdownMenuItem
                onClick={() => setShowBalances(true)}
                className="text-white hover:bg-white/10"
              >
                View Balances
              </DropdownMenuItem>
              <DropdownMenuItem className="text-white hover:bg-white/10">
                Account Settings
              </DropdownMenuItem>
              <DropdownMenuItem
                onClick={handleDisconnect}
                className="text-red-400 hover:bg-red-500/10"
              >
                Disconnect
              </DropdownMenuItem>
            </DropdownMenuContent>
          </DropdownMenu>
        </>
      )}
    </div>
  );
}
