// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "forge-std/Script.sol";
import "forge-std/console.sol"; // import console
import "../src/DutchAuction.sol";
import "../src/EscrowFactory.sol";
import "../src/Relayer.sol";
import "../src/Resolver.sol";
import "../src/MockToken.sol";

contract DeployScript is Script {
    function setUp() public {}

    function run() public {
        uint256 owner = vm.envUint("OWNER");
        uint256 resolverOwner = vm.envUint("RESOLVER_OWNER");

        vm.startBroadcast(owner);

        DutchAuction dutchAuction = new DutchAuction();
        console.log("DutchAuction deployed at:", address(dutchAuction));

        Relayer relayer = new Relayer(address(dutchAuction));
        console.log("Relayer deployed at:", address(relayer));

        EscrowFactory escrowFactory = new EscrowFactory(
            address(dutchAuction),
            address(relayer)
        );
        console.log("EscrowFactory deployed at:", address(escrowFactory));

        dutchAuction.setRelayer(address(relayer));
        dutchAuction.setEscrowFactory(address(escrowFactory));

        vm.stopBroadcast();

        MockToken mockToken = new MockToken();
        console.log("MockToken deployed at:", address(mockToken));

        vm.startBroadcast(resolverOwner);

        Resolver resolver = new Resolver(
            address(dutchAuction),
            address(relayer),
            address(escrowFactory)
        );
        console.log("Resolver deployed at:", address(resolver));

        vm.stopBroadcast();
    }
}
