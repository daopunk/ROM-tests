// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.4;

// import "forge-std/Script.sol";
// import {RiteOfMolochFactory} from "src/RiteOfMolochFactory.sol";
// import {RiteOfMoloch} from "src/RiteOfMoloch.sol";
// import "src/InitializationData.sol";a

// // create with verify
// // forge script script/CloneROM.s.sol:CloneROMScript --rpc-url $RU --private-key $PK --broadcast --verify --etherscan-api-key $EK -vvvv

// // create without verify
// // forge script script/CloneROM.s.sol:CloneROMScript --rpc-url $RU --private-key $PK --broadcast -vvvv

// contract CloneROMScript is Script, InitializationData {
//     RiteOfMolochFactory public ROMF;
//     RiteOfMoloch public ROM;
//     InitData Data;
//     uint256 id; // implementatin id
//     address dao = 0x69830F52d75Ed8d1431c17AECFe09F083dDc7761;
//     address token = 0x1Cfb862056ecF2677615F9eB3420B04fb4911C01;
//     address topHat = address(0);

//     function setUp() public {}

//     function run() public {
//         vm.startBroadcast();

//         // deploy factory contract
//         ROMF = new RiteOfMolochFactory();

//         ROMF.addHatsProtocol(5, 0xcf912a0193593f5cD55D81FF611c26c3ED63f924);
//         // ROMF.addHatsProtocol(100, 0x6B49b86D21aBc1D60611bD85c843a9766B5493DB);
//         // ROMF.addHatsProtocol(137, 0x95647F88dcbC12986046fc4f49064Edd11a25d38);

//         // create InitData struct
//         createInitData();

//         // set implementation id
//         id = id + 1;

//         // call createCohort on ROMF w/ InitData
//         ROM = RiteOfMoloch(ROMF.createCohort(Data, id));

//         // ROM.checkTopHat();

//         // ROM.mintHats(msg.sender);

//         // ROM.checkAdminHat(msg.sender);

//         vm.stopBroadcast();
//     }

//     // create initial data
//     function createInitData() public {
//         Data.membershipCriteria = dao;
//         Data.stakingAsset = token;
//         Data.treasury = dao;
//         Data.topHatWearer = topHat;
//         Data.threshold = 10;
//         Data.assetAmount = 10;
//         Data.duration = 10;
//         Data.chainId = 5;
//         Data.topHatId = 0;
//         Data.name = "RiteOfMolochSBT";
//         Data.symbol = "SBTM";
//         Data.baseUri = "";
//     }
// }
