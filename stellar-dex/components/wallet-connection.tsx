"use client"

import { useState } from "react"
import { Button } from "@/components/ui/button"
import { Badge } from "@/components/ui/badge"
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from "@/components/ui/dialog"
import { Wallet, Copy, ExternalLink, ChevronDown } from "lucide-react"
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu"

export function WalletConnection() {
  const [isConnected, setIsConnected] = useState(false)
  const [showBalances, setShowBalances] = useState(false)

  const handleConnect = () => {
    setIsConnected(true)
  }

  const handleDisconnect = () => {
    setIsConnected(false)
  }

  const balances = [
    { token: "ETH", amount: "2.45", chain: "Ethereum", value: "$6,125.00" },
    { token: "USDC", amount: "1,250.00", chain: "Ethereum", value: "$1,250.00" },
    { token: "XLM", amount: "5,000.00", chain: "Stellar", value: "$650.00" },
    { token: "USDC", amount: "750.00", chain: "Stellar", value: "$750.00" },
  ]

  if (!isConnected) {
    return (
      <Button
        onClick={handleConnect}
        className="bg-gradient-to-r from-blue-500 to-purple-600 hover:from-blue-600 hover:to-purple-700"
      >
        <Wallet className="w-4 h-4 mr-2" />
        Connect Wallet
      </Button>
    )
  }

  return (
    <div className="flex items-center space-x-2">
      <Dialog open={showBalances} onOpenChange={setShowBalances}>
        <DialogTrigger asChild>
          <Button variant="outline" className="border-white/20 text-white hover:bg-white/10 bg-transparent">
            <Wallet className="w-4 h-4 mr-2" />
            0x742d...8D4
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
                <p className="text-sm text-gray-400 mb-2">Account Abstraction Address</p>
                <div className="flex items-center space-x-2 p-2 bg-white/5 rounded border border-white/10">
                  <code className="text-sm flex-1">0x742d35Cc6634C0532925a3b8D4C0532925a3b8D4</code>
                  <Button variant="ghost" size="sm" className="text-gray-400 hover:text-white">
                    <Copy className="w-4 h-4" />
                  </Button>
                </div>
              </div>

              <div>
                <p className="text-sm text-gray-400 mb-2">Original Ethereum Address</p>
                <div className="flex items-center space-x-2 p-2 bg-white/5 rounded border border-white/10">
                  <code className="text-sm flex-1 font-mono truncate min-w-0">
                    0x8ba1f109551bD432803012645Hac136c0532925a3
                  </code>
                  <Button variant="ghost" size="sm" className="text-gray-400 hover:text-white flex-shrink-0">
                    <Copy className="w-4 h-4" />
                  </Button>
                </div>
              </div>

              <div>
                <p className="text-sm text-gray-400 mb-2">Stellar Address</p>
                <div className="flex items-center space-x-2 p-2 bg-white/5 rounded border border-white/10">
                  <code className="text-sm flex-1">GCKFBEIYTKP56VOOHQHHUUIU6SXQPQZLFOQGNC4L</code>
                  <Button variant="ghost" size="sm" className="text-gray-400 hover:text-white">
                    <Copy className="w-4 h-4" />
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
                    <div className="flex items-center space-x-3">
                      <div className="w-8 h-8 bg-gradient-to-r from-blue-500 to-purple-600 rounded-full flex items-center justify-center">
                        <span className="text-xs font-bold">{balance.token.slice(0, 2)}</span>
                      </div>
                      <div>
                        <div className="flex items-center space-x-2">
                          <span className="font-medium">{balance.token}</span>
                          <Badge variant="secondary" className="text-xs">
                            {balance.chain}
                          </Badge>
                        </div>
                        <p className="text-sm text-gray-400">{balance.value}</p>
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
              <Button variant="outline" className="flex-1 border-white/20 text-white hover:bg-white/10 bg-transparent">
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
          <Button variant="ghost" size="sm" className="text-gray-400 hover:text-white">
            <ChevronDown className="w-4 h-4" />
          </Button>
        </DropdownMenuTrigger>
        <DropdownMenuContent className="bg-slate-800 border-white/10">
          <DropdownMenuItem onClick={() => setShowBalances(true)} className="text-white hover:bg-white/10">
            View Balances
          </DropdownMenuItem>
          <DropdownMenuItem className="text-white hover:bg-white/10">Account Settings</DropdownMenuItem>
          <DropdownMenuItem onClick={handleDisconnect} className="text-red-400 hover:bg-red-500/10">
            Disconnect
          </DropdownMenuItem>
        </DropdownMenuContent>
      </DropdownMenu>
    </div>
  )
}
