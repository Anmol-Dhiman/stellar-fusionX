// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "./DutchAuction.sol";

contract EscrowFactory {
    DutchAuction public s_dutchAuction;

    constructor(address _dutchAuction) {
        s_dutchAuction = DutchAuction(_dutchAuction);
    }

    mapping(bytes32 => address) public s_orderIdToEscrow;

    modifier onlyDutchAuction() {
        require(
            msg.sender == address(s_dutchAuction),
            "Invalid DutchAuction call"
        );
        _;
    }

    function deploySrcEscrow(bytes32 orderId) external onlyDutchAuction {}

    function deployDestEscrow(bytes32 orderId) external onlyDutchAuction {}
}
