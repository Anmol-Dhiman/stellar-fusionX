"use client"

import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Progress } from "@/components/ui/progress"
import { Badge } from "@/components/ui/badge"
import { CheckCircle, Clock, AlertCircle, ArrowRight } from "lucide-react"

interface SwapProgressProps {
  currentStep: number
  isActive: boolean
}

const swapSteps = [
  { id: 1, title: "Permit2 Signature", description: "User signs Permit2 for token authorization" },
  { id: 2, title: "Order Received", description: "Relayer receives order through API" },
  { id: 3, title: "Dutch Auction Started", description: "Relayer triggers Dutch auction for Order ID" },
  { id: 4, title: "Order Broadcast", description: "Relayer broadcasts order to solver network" },
  { id: 5, title: "Solver Accepts", description: "Solver accepts price in Dutch auction" },
  { id: 6, title: "Source HTL Deploy", description: "Solver deploys HTL Escrow on source chain" },
  { id: 7, title: "Destination HTL Deploy", description: "Solver deploys HTL Escrow on destination chain" },
  { id: 8, title: "Escrow Verification", description: "Relayer verifies token amounts and addresses" },
  { id: 9, title: "Finality Confirmation", description: "Waiting for 5 block confirmations" },
  { id: 10, title: "Secret Broadcast", description: "Relayer broadcasts secret to network" },
  { id: 11, title: "Swap Complete", description: "Solver withdraws and sends tokens to maker" },
]

export function SwapProgress({ currentStep, isActive }: SwapProgressProps) {
  const getStepStatus = (stepId: number) => {
    if (!isActive) return "pending"
    if (stepId < currentStep) return "completed"
    if (stepId === currentStep) return "active"
    return "pending"
  }

  const getStepIcon = (stepId: number) => {
    const status = getStepStatus(stepId)
    switch (status) {
      case "completed":
        return <CheckCircle className="w-5 h-5 text-green-400" />
      case "active":
        return <Clock className="w-5 h-5 text-blue-400 animate-pulse" />
      case "pending":
        return <div className="w-5 h-5 rounded-full border-2 border-gray-600" />
      default:
        return <AlertCircle className="w-5 h-5 text-red-400" />
    }
  }

  const getStepColor = (stepId: number) => {
    const status = getStepStatus(stepId)
    switch (status) {
      case "completed":
        return "text-green-400"
      case "active":
        return "text-blue-400"
      case "pending":
        return "text-gray-400"
      default:
        return "text-red-400"
    }
  }

  const progressPercentage = isActive ? ((currentStep - 1) / swapSteps.length) * 100 : 0

  return (
    <Card className="bg-white/5 backdrop-blur-sm border-white/10">
      <CardHeader>
        <CardTitle className="text-white flex items-center justify-between">
          Swap Progress
          {isActive && (
            <Badge className="bg-blue-500/20 text-blue-400 border-blue-500/30 animate-pulse">In Progress</Badge>
          )}
        </CardTitle>
        {isActive && (
          <div className="space-y-2">
            <Progress value={progressPercentage} className="h-2" />
            <p className="text-sm text-gray-400">
              Step {currentStep} of {swapSteps.length}
            </p>
          </div>
        )}
      </CardHeader>
      <CardContent className="space-y-4">
        {swapSteps.map((step, index) => (
          <div key={step.id} className="flex items-start space-x-3">
            <div className="flex-shrink-0 mt-0.5">{getStepIcon(step.id)}</div>
            <div className="flex-1 min-w-0">
              <div className={`font-medium ${getStepColor(step.id)}`}>{step.title}</div>
              <div className="text-sm text-gray-400 mt-1">{step.description}</div>
              {getStepStatus(step.id) === "active" && (
                <div className="flex items-center mt-2 text-xs text-blue-400">
                  <div className="w-2 h-2 bg-blue-400 rounded-full animate-pulse mr-2" />
                  Processing...
                </div>
              )}
            </div>
            {index < swapSteps.length - 1 && getStepStatus(step.id) === "completed" && (
              <ArrowRight className="w-4 h-4 text-green-400 mt-0.5" />
            )}
          </div>
        ))}
      </CardContent>
    </Card>
  )
}
