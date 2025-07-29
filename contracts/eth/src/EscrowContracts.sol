// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;
import "./DutchAuction.sol";
import "./Relayer.sol";

contract BaseEscrow {
    uint256 public deployedAt = block.timestamp;
    bytes32 public s_hashLockSecret;
    bytes32 public s_orderId;
    address public s_executive_resolver;
    DutchAuction public s_dutchAuction;
    address public s_relayer;

    error InvalidTime();

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

    modifier onlyExecutiveResolver() {
        require(
            msg.sender == s_executive_resolver,
            "Only executive resolver can call"
        );
        _;
    }

    constructor(
        address _resolver,
        address _dutchAuction,
        bytes32 _hashLockSecret,
        bytes32 _orderId,
        address _relayer
    ) {
        s_executive_resolver = _resolver;
        s_dutchAuction = DutchAuction(_dutchAuction);
        s_hashLockSecret = _hashLockSecret;
        s_orderId = _orderId;
        s_relayer = _relayer;
    }

    function _withdraw(address token, address to, uint amount) internal {
        IERC20(token).transfer(to, amount);
    }
    function _transferSecurityDeposit(address payable to) internal {
        (bool success, ) = to.call{value: address(this).balance}("");
        require(success, "Transfer failed");
    }
}

contract EscrowDest is BaseEscrow {
    address public s_tokenOut;
    uint256 public s_amountOut;
    address public s_maker;

    uint256 public constant FINALITY_LOCK = 2 minutes;
    uint256 public constant RESOLVER_UNLOCK_PERIOD = FINALITY_LOCK + 2 minutes;
    uint256 public constant ANYONE_UNLOCK_PERIOD =
        RESOLVER_UNLOCK_PERIOD + 2 minutes;

    constructor(
        address _resolver,
        address _dutchAuction,
        bytes32 _hashLockSecret,
        bytes32 _orderId,
        address _relayer,
        address _tokenOut,
        uint256 _amountOut,
        address _maker
    )
        payable
        BaseEscrow(
            _resolver,
            _dutchAuction,
            _hashLockSecret,
            _orderId,
            _relayer
        )
    {
        s_tokenOut = _tokenOut;
        s_amountOut = _amountOut;
        s_maker = _maker;
    }

    function withdraw(
        bytes32 secret
    )
        external
        onlyAfter(FINALITY_LOCK)
        onlyBefore(RESOLVER_UNLOCK_PERIOD)
        onlyValidSecret(secret)
    {
        require(msg.sender == s_executive_resolver, "Invalid Call");
        _withdraw(s_tokenOut, s_maker, s_amountOut);
        _transferSecurityDeposit(payable(msg.sender));
    }

    // only whitelisted resolver
    function publicWithdraw(
        bytes32 secret
    )
        external
        onlyResolver
        onlyAfter(RESOLVER_UNLOCK_PERIOD)
        onlyBefore(ANYONE_UNLOCK_PERIOD)
        onlyValidSecret(secret)
    {
        _withdraw(s_tokenOut, s_maker, s_amountOut);
        _transferSecurityDeposit(payable(msg.sender));
    }

    // only executive resolver after finality lock + resolver unlock period + anyone unlock period
    // this would be called when the secret is not shared form user
    function cancel() external onlyAfter(ANYONE_UNLOCK_PERIOD) {
        require(msg.sender == s_executive_resolver, "Invalid Call");
        _withdraw(s_tokenOut, msg.sender, s_amountOut);
        _transferSecurityDeposit(payable(msg.sender));
    }
}

contract EscrowSrc is BaseEscrow {
    uint256 public constant FINALITY_LOCK = 2 minutes;
    uint256 public constant RESOLVER_UNLOCK_PERIOD = FINALITY_LOCK + 4 minutes;
    uint256 public constant ANYONE_UNLOCK_PERIOD =
        RESOLVER_UNLOCK_PERIOD + 4 minutes;
    uint256 public constant RESOLVER_CANCEL = ANYONE_UNLOCK_PERIOD + 2 minutes;
    uint256 public constant ANYONE_CANCEL = RESOLVER_CANCEL + 2 minutes;

    constructor(
        address _resolver,
        address _dutchAuction,
        bytes32 _hashLockSecret,
        bytes32 _orderId,
        address _relayer
    )
        payable
        BaseEscrow(
            _resolver,
            _dutchAuction,
            _hashLockSecret,
            _orderId,
            _relayer
        )
    {}

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

        _withdraw(tokenIn, s_executive_resolver, order.amountIn);
        _transferSecurityDeposit(payable(msg.sender));
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

        _withdraw(tokenIn, s_executive_resolver, order.amountIn);
        _transferSecurityDeposit(payable(msg.sender));
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

        _withdraw(tokenIn, order.maker, order.amountIn);
        _transferSecurityDeposit(payable(msg.sender));
    }

    // after ANYONE_CANCEL
    function publicCancel() external onlyResolver onlyBefore(RESOLVER_CANCEL) {
        IOrder.Order memory order = s_dutchAuction.getOrderById(s_orderId);
        address tokenIn = address(uint160(uint256(order.tokenIn)));

        _withdraw(tokenIn, order.maker, order.amountIn);
        _transferSecurityDeposit(payable(msg.sender));
    }
}
