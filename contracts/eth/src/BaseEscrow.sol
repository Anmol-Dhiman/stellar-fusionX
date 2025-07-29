// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;
import "./DutchAuction.sol";

contract BaseEscrow {
    error InvalidTime();

    uint256 public deployedAt = block.timestamp;

    modifier onlyAfter(uint256 start) {
        if (block.timestamp < deployedAt + start) revert InvalidTime();
        _;
    }

    modifier onlyBefore(uint256 stop) {
        if (block.timestamp >= deployedAt + stop) revert InvalidTime();
        _;
    }

    modifier onlyValidSecret(bytes32 secret, bytes32 hashLock) {
        require(
            hashLock == keccak256(abi.encodePacked(secret)),
            "Invalid secret"
        );
        _;
    }
}
