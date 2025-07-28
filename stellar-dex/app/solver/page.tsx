"use client";

import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import {
  ArrowUpDown,
  Plus,
  Settings,
  TrendingUp,
  DollarSign,
  Activity,
  CheckCircle,
  Clock,
} from "lucide-react";
import Link from "next/link";

const solverTransactions = [
  {
    id: "0x1234...5678",
    orderId: "ORD-001",
    pair: "ETH/XLM",
    amount: "1.5 ETH",
    profit: "$45.30",
    status: "completed",
    timestamp: "2024-01-15 14:30:22",
    auctionPrice: "2,040.8 XLM/ETH",
  },
  {
    id: "0x8765...4321",
    orderId: "ORD-002",
    pair: "USDC/XLM",
    amount: "500 USDC",
    profit: "$12.50",
    status: "pending",
    timestamp: "2024-01-15 16:45:10",
    auctionPrice: "1.0003 XLM/USDC",
  },
];

export default function SolverPage() {
  const [walletAddress, setWalletAddress] = useState("");
  const [webhookUrl, setWebhookUrl] = useState("");
  const [isRegistered, setIsRegistered] = useState(false);

  const handleRegister = () => {
    setIsRegistered(true);
  };

  const getStatusIcon = (status: string) => {
    switch (status) {
      case "completed":
        return <CheckCircle className="w-4 h-4 text-green-400" />;
      case "pending":
        return <Clock className="w-4 h-4 text-yellow-400" />;
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
              <span className="text-xl font-bold text-white">Stellarion</span>
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
              <Link href="/dashboard">
                <Button
                  variant="ghost"
                  className="text-gray-300 hover:text-white"
                >
                  Dashboard
                </Button>
              </Link>
            </div>
          </div>
        </div>
      </nav>

      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div className="mb-8">
          <h1 className="text-3xl font-bold text-white mb-2">
            Solver Dashboard
          </h1>
          <p className="text-gray-400">
            Manage your solver operations and track performance
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
              value="registration"
              className="data-[state=active]:bg-white/10"
            >
              Registration
            </TabsTrigger>
            <TabsTrigger
              value="transactions"
              className="data-[state=active]:bg-white/10"
            >
              Transactions
            </TabsTrigger>
            <TabsTrigger
              value="settings"
              className="data-[state=active]:bg-white/10"
            >
              Settings
            </TabsTrigger>
          </TabsList>

          <TabsContent value="overview" className="space-y-6">
            {/* Stats Cards */}
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
              <Card className="bg-white/5 backdrop-blur-sm border-white/10">
                <CardContent className="p-6">
                  <div className="flex items-center justify-between">
                    <div>
                      <p className="text-gray-400 text-sm">Total Profit</p>
                      <p className="text-2xl font-bold text-white">$2,847.50</p>
                    </div>
                    <DollarSign className="w-8 h-8 text-green-400" />
                  </div>
                  <p className="text-green-400 text-sm mt-2">
                    +18.2% from last month
                  </p>
                </CardContent>
              </Card>

              <Card className="bg-white/5 backdrop-blur-sm border-white/10">
                <CardContent className="p-6">
                  <div className="flex items-center justify-between">
                    <div>
                      <p className="text-gray-400 text-sm">Orders Solved</p>
                      <p className="text-2xl font-bold text-white">127</p>
                    </div>
                    <Activity className="w-8 h-8 text-blue-400" />
                  </div>
                  <p className="text-blue-400 text-sm mt-2">23 this week</p>
                </CardContent>
              </Card>

              <Card className="bg-white/5 backdrop-blur-sm border-white/10">
                <CardContent className="p-6">
                  <div className="flex items-center justify-between">
                    <div>
                      <p className="text-gray-400 text-sm">Success Rate</p>
                      <p className="text-2xl font-bold text-white">96.8%</p>
                    </div>
                    <CheckCircle className="w-8 h-8 text-green-400" />
                  </div>
                  <p className="text-green-400 text-sm mt-2">Above average</p>
                </CardContent>
              </Card>

              <Card className="bg-white/5 backdrop-blur-sm border-white/10">
                <CardContent className="p-6">
                  <div className="flex items-center justify-between">
                    <div>
                      <p className="text-gray-400 text-sm">Avg. Profit</p>
                      <p className="text-2xl font-bold text-white">$22.42</p>
                    </div>
                    <TrendingUp className="w-8 h-8 text-purple-400" />
                  </div>
                  <p className="text-purple-400 text-sm mt-2">
                    Per transaction
                  </p>
                </CardContent>
              </Card>
            </div>

            {/* Recent Activity */}
            <Card className="bg-white/5 backdrop-blur-sm border-white/10">
              <CardHeader>
                <CardTitle className="text-white">
                  Recent Solver Activity
                </CardTitle>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  {solverTransactions.map((tx) => (
                    <div
                      key={tx.id}
                      className="flex items-center justify-between p-4 bg-white/5 rounded-lg border border-white/10"
                    >
                      <div className="flex items-center space-x-4">
                        {getStatusIcon(tx.status)}
                        <div>
                          <div className="flex items-center space-x-2">
                            <span className="text-white font-medium">
                              {tx.pair}
                            </span>
                            <Badge className={getStatusColor(tx.status)}>
                              {tx.status}
                            </Badge>
                          </div>
                          <p className="text-gray-400 text-sm">
                            Order: {tx.orderId}
                          </p>
                        </div>
                      </div>
                      <div className="text-right">
                        <p className="text-white">{tx.amount}</p>
                        <p className="text-green-400 text-sm">+{tx.profit}</p>
                      </div>
                    </div>
                  ))}
                </div>
              </CardContent>
            </Card>
          </TabsContent>

          <TabsContent value="registration" className="space-y-6">
            <Card className="bg-white/5 backdrop-blur-sm border-white/10">
              <CardHeader>
                <CardTitle className="text-white">
                  Solver Registration
                </CardTitle>
                <p className="text-gray-400">
                  Register as a solver to participate in Dutch auctions
                </p>
              </CardHeader>
              <CardContent className="space-y-6">
                {!isRegistered ? (
                  <>
                    <div className="space-y-2">
                      <Label htmlFor="wallet" className="text-white">
                        Wallet Address
                      </Label>
                      <Input
                        id="wallet"
                        placeholder="0x742d35Cc6634C0532925a3b8D4C0532925a3b8D4"
                        value={walletAddress}
                        onChange={(e) => setWalletAddress(e.target.value)}
                        className="bg-white/5 border-white/10 text-white"
                      />
                      <p className="text-gray-400 text-sm">
                        Your Ethereum wallet address for receiving payments
                      </p>
                    </div>

                    <div className="space-y-2">
                      <Label htmlFor="webhook" className="text-white">
                        Webhook URL
                      </Label>
                      <Input
                        id="webhook"
                        placeholder="https://your-server.com/webhook"
                        value={webhookUrl}
                        onChange={(e) => setWebhookUrl(e.target.value)}
                        className="bg-white/5 border-white/10 text-white"
                      />
                      <p className="text-gray-400 text-sm">
                        URL to receive POST requests for new orders
                      </p>
                    </div>

                    <Button
                      onClick={handleRegister}
                      disabled={!walletAddress || !webhookUrl}
                      className="w-full bg-gradient-to-r from-blue-500 to-purple-600 hover:from-blue-600 hover:to-purple-700"
                    >
                      <Plus className="w-4 h-4 mr-2" />
                      Register as Solver
                    </Button>
                  </>
                ) : (
                  <div className="text-center py-8">
                    <CheckCircle className="w-16 h-16 text-green-400 mx-auto mb-4" />
                    <h3 className="text-xl font-semibold text-white mb-2">
                      Registration Successful!
                    </h3>
                    <p className="text-gray-400 mb-4">
                      You are now registered as a solver and will receive
                      webhook notifications for new orders.
                    </p>

                    <div className="bg-white/5 rounded-lg p-4 text-left space-y-2">
                      <div className="flex justify-between">
                        <span className="text-gray-400">Wallet:</span>
                        <span className="text-white font-mono text-sm">
                          {walletAddress}
                        </span>
                      </div>
                      <div className="flex justify-between">
                        <span className="text-gray-400">Webhook:</span>
                        <span className="text-white font-mono text-sm">
                          {webhookUrl}
                        </span>
                      </div>
                    </div>
                  </div>
                )}
              </CardContent>
            </Card>
          </TabsContent>

          <TabsContent value="transactions" className="space-y-6">
            <Card className="bg-white/5 backdrop-blur-sm border-white/10">
              <CardHeader>
                <CardTitle className="text-white">
                  Solver Transaction History
                </CardTitle>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  {solverTransactions.map((tx) => (
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
                                {tx.pair}
                              </span>
                              <Badge className={getStatusColor(tx.status)}>
                                {tx.status}
                              </Badge>
                            </div>
                            <p className="text-gray-400 text-sm">
                              Order ID: {tx.orderId}
                            </p>
                          </div>
                        </div>
                        <div className="text-right">
                          <p className="text-white font-medium">+{tx.profit}</p>
                          <p className="text-gray-400 text-sm">Profit</p>
                        </div>
                      </div>

                      <div className="grid grid-cols-2 md:grid-cols-4 gap-4 text-sm">
                        <div>
                          <p className="text-gray-400">Amount</p>
                          <p className="text-white">{tx.amount}</p>
                        </div>
                        <div>
                          <p className="text-gray-400">Auction Price</p>
                          <p className="text-white">{tx.auctionPrice}</p>
                        </div>
                        <div>
                          <p className="text-gray-400">Transaction ID</p>
                          <p className="text-white font-mono">{tx.id}</p>
                        </div>
                        <div>
                          <p className="text-gray-400">Timestamp</p>
                          <p className="text-white">{tx.timestamp}</p>
                        </div>
                      </div>
                    </div>
                  ))}
                </div>
              </CardContent>
            </Card>
          </TabsContent>

          <TabsContent value="settings" className="space-y-6">
            <Card className="bg-white/5 backdrop-blur-sm border-white/10">
              <CardHeader>
                <CardTitle className="text-white flex items-center">
                  <Settings className="w-5 h-5 mr-2" />
                  Solver Settings
                </CardTitle>
              </CardHeader>
              <CardContent className="space-y-6">
                <div className="space-y-2">
                  <Label htmlFor="min-profit" className="text-white">
                    Minimum Profit Threshold
                  </Label>
                  <Input
                    id="min-profit"
                    placeholder="10.00"
                    className="bg-white/5 border-white/10 text-white"
                  />
                  <p className="text-gray-400 text-sm">
                    Minimum profit in USD to accept an order
                  </p>
                </div>

                <div className="space-y-2">
                  <Label htmlFor="max-gas" className="text-white">
                    Maximum Gas Price
                  </Label>
                  <Input
                    id="max-gas"
                    placeholder="50"
                    className="bg-white/5 border-white/10 text-white"
                  />
                  <p className="text-gray-400 text-sm">
                    Maximum gas price in Gwei for transactions
                  </p>
                </div>

                <div className="space-y-2">
                  <Label htmlFor="supported-pairs" className="text-white">
                    Supported Trading Pairs
                  </Label>
                  <div className="flex flex-wrap gap-2 mb-2">
                    <Badge className="bg-blue-500/20 text-blue-400 border-blue-500/30">
                      ETH/XLM
                    </Badge>
                    <Badge className="bg-green-500/20 text-green-400 border-green-500/30">
                      USDC/XLM
                    </Badge>
                    <Badge className="bg-purple-500/20 text-purple-400 border-purple-500/30">
                      XLM/ETH
                    </Badge>
                  </div>
                  <Button
                    variant="outline"
                    size="sm"
                    className="border-white/20 text-white hover:bg-white/10 bg-transparent"
                  >
                    <Plus className="w-4 h-4 mr-2" />
                    Add Pair
                  </Button>
                </div>

                <Button className="w-full bg-gradient-to-r from-blue-500 to-purple-600 hover:from-blue-600 hover:to-purple-700">
                  Save Settings
                </Button>
              </CardContent>
            </Card>
          </TabsContent>
        </Tabs>
      </div>
    </div>
  );
}
