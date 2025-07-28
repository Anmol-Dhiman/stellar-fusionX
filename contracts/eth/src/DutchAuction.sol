// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;
import {IOrder} from "./interface/IOrder.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";
import "./Relayer.sol";
contract DutchAuction is Ownable {
    mapping(bytes32 => IOrder.Order) public s_orders;
    address public s_relayer;
    uint256 public constant MAX_AUCTION_TIME = 10 minutes;
    uint256 public constant AUCTION_START_BUFFER = 2 minutes;

    modifier onlyRelayer() {
        require(msg.sender == s_relayer, "Invalid Relayer Call");
        _;
    }

    modifier onlyResolver() {
        require(
            Relayer(s_relayer).isRelayer(msg.sender),
            "Invalid Resolver Call"
        );
        _;
    }

    constructor() Ownable(msg.sender) {}
    function startAuction(
        IOrder.OrderInput memory orderInput
    ) external onlyRelayer {
        s_orders[orderInput.orderId] = IOrder.Order({
            maker: orderInput.maker,
            tokenIn: orderInput.tokenIn,
            tokenOut: orderInput.tokenOut,
            amountIn: orderInput.amountIn,
            amountOut: 0,
            minAmountOut: orderInput.minAmountOut,
            maxAmountOut: orderInput.maxAmountOut,
            status: IOrder.OrderStatus.Pending,
            resolverAssigned: address(0),
            path: orderInput.path,
            startTime: uint32(block.timestamp) + uint32(AUCTION_START_BUFFER),
            hashLock: orderInput.hashLock
        });
    }

    function fillOrder() external onlyRelayer {}

    /*
     * @dev gives the amount out value based on the start and end time of this order
     * @notice the price is decreasing linearly
     * @notice inspired from https://github.com/1inch/limit-order-protocol/blob/master/contracts/extensions/DutchAuctionCalculator.sol
     */
    function _getAmountOut(bytes32 _orderId) internal view returns (uint256) {
        IOrder.Order memory _order = s_orders[_orderId];
        uint256 startTime = _order.startTime;
        uint256 endTime = startTime + MAX_AUCTION_TIME;
        uint256 currentTime = Math.max(
            startTime,
            Math.min(endTime, block.timestamp)
        );
        return
            (_order.maxAmountOut *
                (endTime - currentTime) +
                _order.minAmountOut *
                (currentTime - startTime)) / (endTime - startTime);
    }

    function setRelayer(address _relayer) external onlyOwner {
        s_relayer = _relayer;
    }
}
