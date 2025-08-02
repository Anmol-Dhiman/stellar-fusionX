"use client";

import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
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
} from "lucide-react";
import Link from "next/link";
import { WalletConnection } from "@/components/wallet-connection";
import { useUser } from "@/context/user-context"; // Import useUser

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
  const { userData } = useUser(); // Use userData from context

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
                      <Button
                        variant="ghost"
                        size="sm"
                        className="text-gray-400 hover:text-white flex-shrink-0"
                      >
                        <Copy className="w-4 h-4" />
                      </Button>
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
                      <Button
                        variant="ghost"
                        size="sm"
                        className="text-gray-400 hover:text-white flex-shrink-0"
                      >
                        <Copy className="w-4 h-4" />
                      </Button>
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
                      <Button
                        variant="ghost"
                        size="sm"
                        className="text-gray-400 hover:text-white flex-shrink-0"
                      >
                        <Copy className="w-4 h-4" />
                      </Button>
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
                            "Connect wallet to see"
                          : "••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••"}
                      </code>
                      <Button
                        variant="ghost"
                        size="sm"
                        className="text-gray-400 hover:text-white flex-shrink-0"
                      >
                        <Copy className="w-4 h-4" />
                      </Button>
                    </div>
                  </div>

                  <div className="pt-4 border-t border-white/10">
                    <p className="text-gray-400 text-sm mb-2">Token Balances</p>
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
