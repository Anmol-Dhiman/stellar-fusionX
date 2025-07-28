// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {IERC20Permit} from "@openzeppelin/contracts/token/ERC20/extensions/IERC20Permit.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {IOrder} from "./interface/IOrder.sol";
import {DutchAuction} from "./DutchAuction.sol";

contract Relayer is Ownable {
    event SignalSecretShare(
        bytes32 escrowSrc,
        bytes32 escrowDest,
        bytes32 orderId,
        address resolver
    );

    mapping(address => bool) private s_relayers;
    DutchAuction public s_dutchAuction;

    constructor(address _dutchAuction) Ownable(msg.sender) {
        s_dutchAuction = DutchAuction(_dutchAuction);
    }

    function addRelayer(address _relayer) external onlyOwner {
        require(_relayer != address(0), "Invalid address");
        s_relayers[_relayer] = true;
    }

    function removeRelayer(address _relayer) external onlyOwner {
        require(_relayer != address(0), "Invalid address");
        s_relayers[_relayer] = false;
    }

    function isRelayer(address _relayer) external view returns (bool) {
        return s_relayers[_relayer];
    }

    function placeOrder(
        IOrder.OrderInput memory orderInput,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external {
        address tokenInAddress = address(uint160(uint256(orderInput.tokenIn)));
        IERC20Permit(tokenInAddress).permit(
            orderInput.maker,
            address(this),
            orderInput.amountIn,
            block.timestamp + 600,
            v,
            r,
            s
        );
        IERC20(tokenInAddress).transferFrom(
            orderInput.maker,
            address(this),
            orderInput.amountIn
        );

        s_dutchAuction.startAuction(orderInput);
    }

    /*
     * @dev Signal Relayer to check for src and dest escrow and reveal secret
     */
    function signalShareSecret(
        bytes32 escrowSrc,
        bytes32 escrowDest,
        bytes32 orderId
    ) external {
        require(s_relayers[msg.sender], "Invalid signal call");
        emit SignalSecretShare(escrowSrc, escrowDest, orderId, msg.sender);
    }
}
