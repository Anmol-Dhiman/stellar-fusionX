// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;
import "./BaseEscrow.sol";
import "./DutchAuction.sol";
import "./Relayer.sol";
import "./interface/IOrder.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract EscrowSrc {
    uint256 public constant FINALITY_LOCK = 2 minutes;
    uint256 public constant RESOLVER_UNLOCK_PERIOD = FINALITY_LOCK + 4 minutes;
    uint256 public constant ANYONE_UNLOCK_PERIOD =
        RESOLVER_UNLOCK_PERIOD + 4 minutes;
    uint256 public constant RESOLVER_CANCEL = ANYONE_UNLOCK_PERIOD + 2 minutes;
    uint256 public constant ANYONE_CANCEL = RESOLVER_CANCEL + 2 minutes;

    bytes32 public s_hashLockSecret;
    address public s_executive_resolver;
    bytes32 public s_orderId;
    DutchAuction public s_dutchAuction;
    address public s_relayer;

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

    modifier onlyValidSecret(bytes32 secret) {
        require(
            s_hashLockSecret == keccak256(abi.encodePacked(secret)),
            "Invalid secret"
        );
        _;
    }

    modifier onlyRelayer() {
        require(msg.sender == s_relayer, "Invalid Call");
        _;
    }

    modifier onlyResolver() {
        require(
            Relayer(s_relayer).isResolver(msg.sender),
            "Invalid Resolver Call"
        );
        _;
    }

    constructor(
        address _resolver,
        address _dutchAuction,
        bytes32 _hashLockSecret,
        bytes32 _orderId,
        address _relayer
    ) payable {
        s_hashLockSecret = _hashLockSecret;
        s_executive_resolver = _resolver;
        s_orderId = _orderId;
        s_dutchAuction = DutchAuction(_dutchAuction);
        s_relayer = _relayer;
    }

    // can only be called by excustive resolver
    // after FINALITY_LOCK
    // before RESOLVER_UNLOCK_PERIOD
    function withdraw(
        bytes32 secret
    )
        external
        onlyAfter(FINALITY_LOCK)
        onlyBefore(RESOLVER_UNLOCK_PERIOD)
        onlyValidSecret(secret)
    {
        require(msg.sender == s_executive_resolver, "Invalid Call");
        IOrder.Order memory order = s_dutchAuction.getOrderById(s_orderId);
        address tokenIn = address(uint160(uint256(order.tokenIn)));
        IERC20(tokenIn).transfer(s_executive_resolver, order.amountIn);
    }

    // only whitelisted resolver
    // after RESOLVER_UNLOCK_PERIOD
    // before ANYONE_UNLOCK_PERIOD
    function publicWithdraw(
        bytes32 secret
    )
        external
        onlyResolver
        onlyAfter(RESOLVER_UNLOCK_PERIOD)
        onlyBefore(ANYONE_UNLOCK_PERIOD)
        onlyValidSecret(secret)
    {
        IOrder.Order memory order = s_dutchAuction.getOrderById(s_orderId);
        address tokenIn = address(uint160(uint256(order.tokenIn)));
        IERC20(tokenIn).transfer(order.maker, order.amountIn);

        payable(msg.sender).call{value: address(this).balance}("");
    }

    // only  excustive resolver
    // after ANYONE_UNLOCK_PERIOD
    // before RESOLVER_CANCEL
    function cancel()
        external
        onlyAfter(ANYONE_UNLOCK_PERIOD)
        onlyBefore(RESOLVER_CANCEL)
    {
        require(msg.sender == s_executive_resolver, "Invalid Call");
        IOrder.Order memory order = s_dutchAuction.getOrderById(s_orderId);
        address tokenIn = address(uint160(uint256(order.tokenIn)));
        IERC20(tokenIn).transfer(order.maker, order.amountIn);
        payable(msg.sender).call{value: address(this).balance}("");
    }

    // after ANYONE_CANCEL
    function publicCancel() external onlyResolver onlyBefore(RESOLVER_CANCEL) {
        IOrder.Order memory order = s_dutchAuction.getOrderById(s_orderId);
        address tokenIn = address(uint160(uint256(order.tokenIn)));
        IERC20(tokenIn).transfer(order.maker, order.amountIn);
        payable(msg.sender).call{value: address(this).balance}("");
    }
}
