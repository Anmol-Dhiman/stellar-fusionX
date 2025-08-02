"use client";

import { useState } from "react";
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
import axios from "axios"; // Import axios

export function WalletConnection() {
  const { userData, setUserData, isConnected, setIsConnected } = useUser();
  const [showBalances, setShowBalances] = useState(false);
  const [email, setEmail] = useState("");
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const handleConnect = async () => {
    setIsLoading(true);
    setError(null);
    try {
      const response = await axios.post("http://localhost:3001/user/register", {
        email,
      });

      if (response.data && response.data.user) {
        setUserData(response.data.user);
        setShowBalances(true); // Open balances dialog after successful connection
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

  const handleDisconnect = () => {
    setIsConnected(false);
    setUserData(null);
    setShowBalances(false);
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
        <Dialog>
          <DialogTrigger asChild>
            <Button className="bg-gradient-to-r from-blue-500 to-purple-600 hover:from-blue-600 hover:to-purple-700">
              <Wallet className="w-4 h-4 mr-2" />
              Connect Wallet
            </Button>
          </DialogTrigger>
          <DialogContent className="bg-slate-900 border-white/10 text-white sm:max-w-md">
            <DialogHeader>
              <DialogTitle>Connect Your Wallet</DialogTitle>
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
                onClick={handleConnect}
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
                  : "Connected"}
              </Button>
            </DialogTrigger>
            <DialogContent className="bg-slate-900 border-white/10 text-white max-w-lg max-h-[90vh] overflow-y-auto">
              <DialogHeader>
                <DialogTitle>Account Details</DialogTitle>
              </DialogHeader>
              <div className="space-y-6">
                {/* Account Addresses */}
                <div className="space-y-4">
                  <div>
                    <p className="text-sm text-gray-400 mb-2">
                      Account Abstraction Address
                    </p>
                    <div className="flex items-center space-x-2 p-2 bg-white/5 rounded border border-white/10 min-w-0">
                      <code className="text-xs flex-1 font-mono break-all min-w-0 overflow-hidden">
                        {userData?.ethPublicAddress || "N/A"}
                      </code>
                      <Button
                        variant="ghost"
                        size="sm"
                        className="text-gray-400 hover:text-white flex-shrink-0 p-1"
                      >
                        <Copy className="w-3 h-3" />
                      </Button>
                    </div>
                  </div>

                  <div>
                    <p className="text-sm text-gray-400 mb-2">
                      Stellar Address
                    </p>
                    <div className="flex items-center space-x-2 p-2 bg-white/5 rounded border border-white/10 min-w-0">
                      <code className="text-xs flex-1 font-mono break-all min-w-0 overflow-hidden">
                        {userData?.stellarPublicAddress || "N/A"}
                      </code>
                      <Button
                        variant="ghost"
                        size="sm"
                        className="text-gray-400 hover:text-white flex-shrink-0 p-1"
                      >
                        <Copy className="w-3 h-3" />
                      </Button>
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
                        <div className="flex items-center space-x-3 min-w-0 flex-1">
                          <div className="w-8 h-8 bg-gradient-to-r from-blue-500 to-purple-600 rounded-full flex items-center justify-center flex-shrink-0">
                            <span className="text-xs font-bold">
                              {balance.token.slice(0, 2)}
                            </span>
                          </div>
                          <div className="min-w-0 flex-1">
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
                        <div className="text-right flex-shrink-0">
                          <p className="font-medium">{balance.amount}</p>
                        </div>
                      </div>
                    ))}
                  </div>
                </div>

                <div className="flex flex-col sm:flex-row space-y-2 sm:space-y-0 sm:space-x-2">
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
