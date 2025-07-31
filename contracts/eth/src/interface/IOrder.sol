// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

interface IOrder {
    struct Order {
        address maker;
        bytes32 tokenIn; // address on eth or stellar , convert address to bytes32 if eth-stellar swap
        bytes32 tokenOut; // address on eth or stellar
        uint256 amountIn;
        uint256 amountOut;
        uint256 minAmountOut;
        uint256 maxAmountOut;
        address resolverAssigned;
        uint32 startTime;
        bytes32 hashLock;
    }

    struct OrderInput {
        bytes32 orderId;
        address maker;
        bytes32 tokenIn;
        bytes32 tokenOut;
        uint256 amountIn;
        uint256 minAmountOut;
        uint256 maxAmountOut;
        bytes32 hashLock;
    }
}
