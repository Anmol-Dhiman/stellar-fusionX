// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "./interface/IEscrow.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import "./DutchAuction.sol";
import "./Relayer.sol";
import "./EscrowFactory.sol";

contract Resolver is Ownable {
    DutchAuction public s_dutchAuction;
    Relayer public s_relayer;
    EscrowFactory public s_escrowFactory;

    error LengthMismatch();

    constructor(
        address _dutchAuction,
        address _relayer,
        address _escrowFactory
    ) Ownable(msg.sender) {
        s_dutchAuction = DutchAuction(_dutchAuction);
        s_relayer = Relayer(_relayer);
        s_escrowFactory = EscrowFactory(_escrowFactory);
    }

    /*
     * @dev fill order i.e. deploy EscrowSrc + move funds from relayer to deployed EscrowSrc
     * + deposit security + set the amountOut in DutchAuction contract */
    function deploySrc(bytes32 _orderId) external payable onlyOwner {
        s_dutchAuction.fillOrder{value: msg.value}(_orderId);
    }

    /*
     * @dev deploy the EscrowDest + deposit security + trasnfer amountOut set on stellar */
    function deployDest(
        bytes32 orderId,
        address token,
        uint256 amount,
        address maker
    ) external payable onlyOwner {
        address escrowDest = s_escrowFactory.deployDestEscrow{value: msg.value}(
            orderId,
            token,
            amount,
            maker
        );
        // adding tokens to the escrow
        IERC20(token).transferFrom(msg.sender, escrowDest, amount);
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

    /*
     * @dev notify relayer to check escrowSrc and escrowDest implementation
     * check for amountOut specified in dutchAuction on respective chain
     * and check escrowSrc have the required tokens or not */
    function notifyRelayer(
        bytes32 escrowSrc,
        bytes32 escrowDest,
        bytes32 orderId
    ) external onlyOwner {
        s_relayer.signalShareSecret(escrowSrc, escrowDest, orderId);
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

    fallback() external payable {}
    receive() external payable {}
}
