// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

interface IEscrow {
    function withdraw(bytes32 secret) external;
    function cancel() external;
}

interface IEscrowSrc is IEscrow {
    function publicWithdraw(bytes32 secret) external;
    function publicCancel() external;
}
