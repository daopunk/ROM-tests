// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {TestHelperB} from "test/createNewHats/TestHelperB.t.sol";
import "test/utils/hats/interfaces/HatsErrorsT.sol";

// forge test --match-contract AccessControlB -vv

contract AccessControlB is TestHelperB {
    bytes32 public constant SUPER_ADMIN = keccak256("SUPER_ADMIN");
    bytes32 public constant ADMIN = keccak256("ADMIN");

    function testSuperAdminPermissions() public {
        vm.startPrank(deployer);
        ROM.setMinimumStake(20);
        ROM.setShareThreshold(20);
        ROM.setMaxDuration(20);
        emit log_named_uint("Min     Share", ROM.minimumShare());
        emit log_named_uint("Min     Stake", ROM.minimumStake());
        emit log_named_uint("Max      Time", ROM.maximumTime());
        vm.stopPrank();
    }

    function testSetAdminPermissions() public {
        uint256 adminHat = ROM.adminHat();
        uint256 superAdminHat = ROM.superAdminHat();

        hats.mintHat(adminHat, bob);
        assertTrue(ROM.hasRole(ADMIN, bob));

        // alice should be able to call admin functions
        vm.startPrank(alice);

        ROM.setMinimumStake(30);
        ROM.setShareThreshold(30);
        emit log_named_uint("Min     Share", ROM.minimumShare());
        emit log_named_uint("Min     Stake", ROM.minimumStake());

        // alice should not be able to call superAdmin functions
        vm.expectRevert(
            abi.encodeWithSelector(
                HatsErrorsT.NotWearingRoleHat.selector,
                SUPER_ADMIN,
                superAdminHat,
                alice
            )
        );
        ROM.setMaxDuration(30);

        vm.stopPrank();

        // charlie should not be able to call admin functions
        vm.startPrank(charlie);

        vm.expectRevert(
            abi.encodeWithSelector(
                HatsErrorsT.NotWearingRoleHat.selector,
                ADMIN,
                adminHat,
                charlie
            )
        );
        ROM.setMinimumStake(40);

        vm.stopPrank();
    }

    function testSetAdminLimit() public {
        uint256 adminHat = ROM.adminHat();

        hats.mintHat(adminHat, bob);

        // all hats have been minted, next hat [for charlie] should revert
        vm.expectRevert(
            abi.encodeWithSelector(HatsErrorsT.AllHatsWorn.selector, adminHat)
        );
        hats.mintHat(adminHat, charlie);
    }

    function testDoubleMintGuard() public {
        uint256 adminHat = ROM.adminHat();

        // alice already has a admin hat
        vm.expectRevert(
            abi.encodeWithSelector(
                HatsErrorsT.AlreadyWearingHat.selector,
                alice,
                adminHat
            )
        );
        hats.mintHat(adminHat, alice);
    }

    // function testHatAssignments() public {}
}
