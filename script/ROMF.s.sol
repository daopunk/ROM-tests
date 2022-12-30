// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "forge-std/Script.sol";
import {RiteOfMolochFactory} from "src/RiteOfMolochFactory.sol";

// create with verify
// forge script script/ROMF.s.sol:ROMFScript --rpc-url $RU --private-key $PK --broadcast --verify --etherscan-api-key $EK -vvvv

// create without verify
// forge script script/ROMF.s.sol:ROMFScript --rpc-url $RU --private-key $PK --broadcast -vvvv

contract ROMFScript is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        new RiteOfMolochFactory();
        vm.stopBroadcast();
    }
}
