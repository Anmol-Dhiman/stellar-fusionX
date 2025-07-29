// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "./DutchAuction.sol";
import "./Relayer.sol";
import {EscrowDest, EscrowSrc} from "./EscrowContracts.sol";

contract EscrowFactory {
    DutchAuction public s_dutchAuction;
    Relayer public s_relayer;
    uint256 public s_security_deposit = 0.01 ether; // Example security deposit amount

    constructor(address _dutchAuction, address _relayer) {
        s_dutchAuction = DutchAuction(_dutchAuction);
        s_relayer = Relayer(_relayer);
    }

    // either orderId -> escrowSrc or escrowDest
    mapping(bytes32 => address) public s_orderIdToEscrow;
    mapping(address => bytes32) public s_escrowToOrderId;

    modifier onlyDutchAuction() {
        require(
            msg.sender == address(s_dutchAuction),
            "Invalid DutchAuction call"
        );
        _;
    }

    modifier onlyResolver() {
        require(
            Relayer(s_relayer).isResolver(msg.sender),
            "Invalid Resolver Call"
        );
        _;
    }

    function deploySrcEscrow(
        bytes32 orderId,
        address resolver,
        bytes32 hashLock
    ) external payable onlyDutchAuction returns (address) {
        require(
            msg.value >= s_security_deposit,
            "Insufficient security deposit"
        );
        address escrowSrc = address(
            new EscrowSrc{value: msg.value}(
                resolver,
                address(s_dutchAuction),
                hashLock,
                orderId,
                address(s_relayer)
            )
        );
        s_orderIdToEscrow[orderId] = escrowSrc;
        s_escrowToOrderId[escrowSrc] = orderId;
        return escrowSrc;
    }

    function deployDestEscrow(
        bytes32 orderId,
        address tokenOut,
        uint256 amountOut,
        address maker
    ) external payable onlyResolver returns (address) {
        require(
            msg.value >= s_security_deposit,
            "Insufficient security deposit"
        );
        bytes32 hashLock = s_dutchAuction.getHashLockByOrderId(orderId);
        address escrowDest = address(
            new EscrowDest{value: msg.value}(
                msg.sender,
                address(s_dutchAuction),
                hashLock,
                orderId,
                address(s_relayer),
                tokenOut,
                amountOut,
                maker
            )
        );
        s_orderIdToEscrow[orderId] = escrowDest;
        s_escrowToOrderId[escrowDest] = orderId;
        return escrowDest;
    }
}
