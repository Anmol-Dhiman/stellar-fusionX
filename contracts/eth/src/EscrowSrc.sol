// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;
import "./DutchAuction.sol";

contract EscrowSrc {
    uint256 public constant FINALITY_LOCK = 2 minutes;
    uint256 public constant RESOLVER_UNLOCK_PERIOD = 4 minutes;
    uint256 public constant ANYONE_UNLOCK_PERIOD = 4 minutes;
    uint256 public constant RESOLVER_CANCEL = 2 minutes;
    uint256 public constant ANYONE_CANCEL = 2 minutes;

    bytes32 public s_hashLockSecret;
    address public s_resolver; // executive resolver
    bytes32 public s_orderId;
    DutchAuction public s_dutchAuction;
    address public s_relayer;

    modifier onlyRelayer() {
        require(msg.sender == s_relayer, "Invalid Call");
        _;
    }

    modifier onlyResolver() {
        require(
            Relayer(s_relayer).isRelayer(msg.sender),
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
    ) {
        s_hashLockSecret = _hashLockSecret;
        s_resolver = _resolver;
        s_orderId = _orderId;
        s_dutchAuction = DutchAuction(_dutchAuction);
        s_relayer = _relayer;
    }

    // can only be called by excustive resolver
    // after FINALITY_LOCK
    // before RESOLVER_UNLOCK_PERIOD
    function withdraw() external {}

    // only whitelisted resolver
    // after RESOLVER_UNLOCK_PERIOD
    // before ANYONE_UNLOCK_PERIOD
    function publicWithdraw() external {}

    // only  excustive resolver
    // after ANYONE_UNLOCK_PERIOD
    // before RESOLVER_CANCEL
    function cancel() external {}

    // after ANYONE_CANCEL
    function publicCancel() external {}
}
