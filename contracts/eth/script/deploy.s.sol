// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import {LimitOrderProtocol} from "../src/LoP.sol";
import {IWETH} from "../src/LoP.sol";
import {DutchAuctionCalculator} from "../src/DutchAuctionCalculator.sol";

import {Resolver} from "../src/Resolver.sol";
import {IEscrowFactory} from "../src/Resolver.sol";
import {IOrderMixin} from "../src/Resolver.sol";
import {EscrowFactory} from "../src/Escrow.sol";
import {MockToken} from "../src/MockToken.sol";
import {IERC20} from "../src/Escrow.sol";
contract DeployScript is Script {
    function setUp() public {}

    function run() public {
        address _weth = 0x600f947A88caF40eb57c2d8f501E781C4241E6A1; // WETH address on Polygon Amoy
        uint256 ownerPrivateKey = vm.envUint("OWNER");
        address ownerAddress = vm.addr(ownerPrivateKey);

        uint256 resolverOwnerPrivateKey = vm.envUint("RESOLVER_OWNER");
        address resolverOwnerAddress = vm.addr(resolverOwnerPrivateKey);

        vm.startBroadcast(ownerPrivateKey);

        MockToken mockToken = new MockToken();
        console.log("MockToken deployed at:", address(mockToken));

        LimitOrderProtocol lop = new LimitOrderProtocol(IWETH(_weth));
        console.log("LimitOrderProtocol deployed at:", address(lop));

        DutchAuctionCalculator dutchAuctionCalculator = new DutchAuctionCalculator();
        console.log(
            "DutchAuctionCalculator deployed at:",
            address(dutchAuctionCalculator)
        );

        EscrowFactory escrowFactory = new EscrowFactory(
            address(lop),
            IERC20(address(mockToken)),
            ownerAddress,
            uint32(1 minutes),
            uint32(1 minutes)
        );
        console.log("EscrowFactory deployed at:", address(escrowFactory));

        Resolver resolver = new Resolver(
            IEscrowFactory(address(escrowFactory)),
            IOrderMixin(address(lop)),
            resolverOwnerAddress
        );
        console.log("Resolver deployed at:", address(resolver));

        vm.stopBroadcast();
    }
}
