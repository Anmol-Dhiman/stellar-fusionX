// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;
import "./DutchAuction.sol";
import "./Relayer.sol";

contract EscrowDest {
    uint256 public constant FINALITY_LOCK = 2 minutes;
    uint256 public constant RESOLVER_UNLOCK_PERIOD = FINALITY_LOCK + 2 minutes;
    uint256 public constant ANYONE_UNLOCK_PERIOD =
        RESOLVER_UNLOCK_PERIOD + 2 minutes;

    bytes32 public s_hashLockSecret;
    address public s_executive_resolver; // executive resolver
    bytes32 public s_orderId;
    address public s_tokenOut;
    uint256 public s_amountOut;
    address public s_maker;
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
        address _relayer,
        address _tokenOut,
        uint256 _amountOut,
        address _maker
    ) payable {
        s_hashLockSecret = _hashLockSecret;
        s_executive_resolver = _resolver;
        s_orderId = _orderId;
        s_dutchAuction = DutchAuction(_dutchAuction);
        s_relayer = _relayer;
        s_tokenOut = _tokenOut;
        s_amountOut = _amountOut;
        s_maker = _maker;
    }

    // only executive resolver
    function withdraw(
        bytes32 secret
    )
        external
        onlyAfter(FINALITY_LOCK)
        onlyBefore(RESOLVER_UNLOCK_PERIOD)
        onlyValidSecret(secret)
    {
        require(msg.sender == s_executive_resolver, "Invalid Call");
        IERC20(s_tokenOut).transfer(s_maker, s_amountOut);
        payable(msg.sender).call{value: address(this).balance}("");
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
        IERC20(s_tokenOut).transfer(s_maker, s_amountOut);
        payable(msg.sender).call{value: address(this).balance}("");
    }

    // only executive resolver after finality lock + resolver unlock period + anyone unlock period
    // this would be called when the secret is not shared form user
    function cancel() external onlyAfter(ANYONE_UNLOCK_PERIOD) {
        require(msg.sender == s_executive_resolver, "Invalid Call");
        IERC20(s_tokenOut).transfer(msg.sender, s_amountOut);
        payable(msg.sender).call{value: address(this).balance}("");
    }
}
