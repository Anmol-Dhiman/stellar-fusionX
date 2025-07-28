// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "./interface/IEscrow.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import "./DutchAuction.sol";



contract Resolver is Ownable {
    DutchAuction public s_dutchAuction;
    error LengthMismatch();
    constructor(address _dutchAuction) Ownable(msg.sender) {
        s_dutchAuction = DutchAuction(_dutchAuction);
    }

    function fillOrder(bytes32 _orderId) external {
        // 1. approve dutch auction to use the tokens of this contract
    }
    function withdraw(IEscrow escrow, bytes32 secret) external {
        escrow.withdraw(secret);
    }

    function cancel(IEscrow escrow) external {
        escrow.cancel();
    }

    function publicWithdraw(IEscrowSrc escrow, bytes32 secret) external {
        escrow.publicWithdraw(secret);
    }

    function publicCancel(IEscrowSrc escrow) external {
        escrow.publicCancel();
    }

    function arbitraryCalls(
        address[] calldata targets,
        bytes[] calldata arguments
    ) external onlyOwner {
        uint256 length = targets.length;
        if (targets.length != arguments.length) revert LengthMismatch();
        for (uint256 i = 0; i < length; ++i) {
            // solhint-disable-next-line avoid-low-level-calls
            (bool success, ) = targets[i].call(arguments[i]);
            if (!success) revert();
        }
    }
}
