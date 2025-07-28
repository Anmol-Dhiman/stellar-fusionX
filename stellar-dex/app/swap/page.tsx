"use client";

import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { Badge } from "@/components/ui/badge";
import {
  ArrowUpDown,
  Settings,
  History,
  ArrowRight,
  CheckCircle,
  Clock,
} from "lucide-react";
import Link from "next/link";
import { SwapProgress } from "@/components/swap-progress";
import { WalletConnection } from "@/components/wallet-connection";

const tokens = [
  {
    id: "ETH-Ethereum",
    symbol: "ETH",
    name: "Ethereum",
    chain: "Ethereum",
    balance: "2.45",
  },
  {
    id: "USDC-Ethereum",
    symbol: "USDC",
    name: "USD Coin",
    chain: "Ethereum",
    balance: "1,250.00",
  },
  {
    id: "XLM-Stellar",
    symbol: "XLM",
    name: "Stellar Lumens",
    chain: "Stellar",
    balance: "5,000.00",
  },
  {
    id: "USDC-Stellar",
    symbol: "USDC",
    name: "USD Coin",
    chain: "Stellar",
    balance: "750.00",
  },
];

export default function SwapPage() {
  const [fromToken, setFromToken] = useState("ETH-Ethereum");
  const [toToken, setToToken] = useState("XLM-Stellar");
  const [fromAmount, setFromAmount] = useState("");
  const [toAmount, setToAmount] = useState("");
  const [isSwapping, setIsSwapping] = useState(false);
  const [swapStep, setSwapStep] = useState(0);

  const handleSwap = () => {
    setIsSwapping(true);
    setSwapStep(1);

    // Simulate swap progress
    const steps = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
    let currentStep = 1;

    const interval = setInterval(() => {
      currentStep++;
      setSwapStep(currentStep);

      if (currentStep >= 11) {
        clearInterval(interval);
        setTimeout(() => {
          setIsSwapping(false);
          setSwapStep(0);
        }, 2000);
      }
    }, 2000);
  };

  const swapTokens = () => {
    const temp = fromToken;
    setFromToken(toToken);
    setToToken(temp);

    const tempAmount = fromAmount;
    setFromAmount(toAmount);
    setToAmount(tempAmount);
  };

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
              <span className="text-xl font-bold text-white">Stellarion</span>
            </Link>

            <div className="flex items-center space-x-4">
              <Link href="/dashboard">
                <Button
                  variant="ghost"
                  className="text-gray-300 hover:text-white"
                >
                  <History className="w-4 h-4 mr-2" />
                  History
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

      <div className="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
          {/* Swap Interface */}
          <div className="lg:col-span-2">
            <Card className="bg-white/5 backdrop-blur-sm border-white/10">
              <CardHeader>
                <CardTitle className="text-white flex items-center justify-between">
                  Cross-Chain Swap
                  <Button
                    variant="ghost"
                    size="sm"
                    className="text-gray-400 hover:text-white"
                  >
                    <Settings className="w-4 h-4" />
                  </Button>
                </CardTitle>
              </CardHeader>
              <CardContent className="space-y-6">
                {/* From Token */}
                <div className="space-y-2">
                  <label className="text-sm text-gray-400">From</label>
                  <div className="flex space-x-2">
                    <Select value={fromToken} onValueChange={setFromToken}>
                      <SelectTrigger className="w-40 bg-white/5 border-white/10 text-white">
                        <SelectValue />
                      </SelectTrigger>
                      <SelectContent className="bg-white/10 backdrop-blur-md border-white/20 text-white">
                        {tokens.map((token) => (
                          <SelectItem
                            key={token.id}
                            value={token.id}
                            className="hover:bg-gradient-to-r hover:from-blue-500/20 hover:to-purple-600/20 focus:bg-gradient-to-r focus:from-blue-500/20 focus:to-purple-600/20 transition-all duration-200"
                          >
                            <div className="flex items-center space-x-2">
                              <span>{token.symbol}</span>
                              <Badge
                                variant="secondary"
                                className="text-xs whitespace-nowrap"
                              >
                                {token.chain}
                              </Badge>
                            </div>
                          </SelectItem>
                        ))}
                      </SelectContent>
                    </Select>
                    <Input
                      placeholder="0.0"
                      value={fromAmount}
                      onChange={(e) => setFromAmount(e.target.value)}
                      className="flex-1 bg-white/5 border-white/10 text-white text-right text-lg"
                    />
                  </div>
                  <div className="flex justify-between text-sm text-gray-400">
                    <span>
                      Balance: {tokens.find((t) => t.id === fromToken)?.balance}{" "}
                      {tokens.find((t) => t.id === fromToken)?.symbol}
                    </span>
                    <Button
                      variant="ghost"
                      size="sm"
                      className="text-blue-400 hover:text-blue-300 p-0 h-auto"
                    >
                      Max
                    </Button>
                  </div>
                </div>

                {/* Swap Button */}
                <div className="flex justify-center">
                  <Button
                    variant="ghost"
                    size="sm"
                    onClick={swapTokens}
                    className="rounded-full bg-white/10 hover:bg-white/20 border border-white/20"
                  >
                    <ArrowUpDown className="w-4 h-4 text-white" />
                  </Button>
                </div>

                {/* To Token */}
                <div className="space-y-2">
                  <label className="text-sm text-gray-400">To</label>
                  <div className="flex space-x-2">
                    <Select value={toToken} onValueChange={setToToken}>
                      <SelectTrigger className="w-40 bg-white/5 border-white/10 text-white">
                        <SelectValue />
                      </SelectTrigger>
                      <SelectContent className="bg-white/10 backdrop-blur-md border-white/20 text-white">
                        {tokens.map((token) => (
                          <SelectItem
                            key={token.id}
                            value={token.id}
                            className="hover:bg-gradient-to-r hover:from-blue-500/20 hover:to-purple-600/20 focus:bg-gradient-to-r focus:from-blue-500/20 focus:to-purple-600/20 transition-all duration-200"
                          >
                            <div className="flex items-center space-x-2">
                              <span>{token.symbol}</span>
                              <Badge
                                variant="secondary"
                                className="text-xs whitespace-nowrap"
                              >
                                {token.chain}
                              </Badge>
                            </div>
                          </SelectItem>
                        ))}
                      </SelectContent>
                    </Select>
                    <Input
                      placeholder="0.0"
                      value={toAmount}
                      onChange={(e) => setToAmount(e.target.value)}
                      className="flex-1 bg-white/5 border-white/10 text-white text-right text-lg"
                      readOnly
                    />
                  </div>
                  <div className="text-sm text-gray-400">
                    Balance: {tokens.find((t) => t.id === toToken)?.balance}{" "}
                    {tokens.find((t) => t.id === toToken)?.symbol}
                  </div>
                </div>

                {/* Swap Details */}
                <div className="space-y-2 p-4 bg-white/5 rounded-lg border border-white/10">
                  <div className="flex justify-between text-sm">
                    <span className="text-gray-400">Rate</span>
                    <span className="text-white">1 ETH = 2,040.5 XLM</span>
                  </div>
                  <div className="flex justify-between text-sm">
                    <span className="text-gray-400">Network Fee</span>
                    <span className="text-white">~$12.50</span>
                  </div>
                  <div className="flex justify-between text-sm">
                    <span className="text-gray-400">Bridge Fee</span>
                    <span className="text-white">0.3%</span>
                  </div>
                  <div className="flex justify-between text-sm font-medium pt-2 border-t border-white/10">
                    <span className="text-gray-400">You'll receive</span>
                    <span className="text-white">~2,034.2 XLM</span>
                  </div>
                </div>

                {/* Swap Button */}
                <Button
                  onClick={handleSwap}
                  disabled={!fromAmount || isSwapping}
                  className="w-full bg-gradient-to-r from-blue-500 to-purple-600 hover:from-blue-600 hover:to-purple-700 text-lg py-6"
                >
                  {isSwapping ? "Swapping..." : "Swap Tokens"}
                  {!isSwapping && <ArrowRight className="ml-2 w-5 h-5" />}
                </Button>
              </CardContent>
            </Card>
          </div>

          {/* Progress Tracker */}
          <div className="space-y-6">
            <SwapProgress currentStep={swapStep} isActive={isSwapping} />

            {/* Recent Activity */}
            <Card className="bg-white/5 backdrop-blur-sm border-white/10">
              <CardHeader>
                <CardTitle className="text-white text-lg">
                  Recent Activity
                </CardTitle>
              </CardHeader>
              <CardContent className="space-y-3">
                <div className="flex items-center justify-between p-3 bg-white/5 rounded-lg">
                  <div className="flex items-center space-x-3">
                    <CheckCircle className="w-5 h-5 text-green-400" />
                    <div>
                      <div className="text-white text-sm">ETH → XLM</div>
                      <div className="text-gray-400 text-xs">2 hours ago</div>
                    </div>
                  </div>
                  <div className="text-right">
                    <div className="text-white text-sm">1.5 ETH</div>
                    <div className="text-gray-400 text-xs">$3,750</div>
                  </div>
                </div>

                <div className="flex items-center justify-between p-3 bg-white/5 rounded-lg">
                  <div className="flex items-center space-x-3">
                    <Clock className="w-5 h-5 text-yellow-400" />
                    <div>
                      <div className="text-white text-sm">USDC → XLM</div>
                      <div className="text-gray-400 text-xs">Pending</div>
                    </div>
                  </div>
                  <div className="text-right">
                    <div className="text-white text-sm">500 USDC</div>
                    <div className="text-gray-400 text-xs">$500</div>
                  </div>
                </div>
              </CardContent>
            </Card>
          </div>
        </div>
      </div>
    </div>
  );
}
