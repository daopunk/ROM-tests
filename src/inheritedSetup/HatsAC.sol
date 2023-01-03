// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {IHats} from "test/utils/hats/interfaces/IHatsT.sol";

contract HatsAC {
    error NotWearingRoleHat(bytes32 role, uint256 hat, address account);
    error RoleAlreadyAssigned(bytes32 role, uint256 roleHat);

    struct RoleData {
        uint256 hat;
        bytes32 adminRole;
    }

    // private vars bc this contract will be inherited
    mapping(bytes32 => RoleData) private _roles;

    IHats private HATS;

    /**
     * @dev Modifier for enforcing Hats protocol
     * Allows Hats Access Control
     */
    modifier onlyRole(bytes32 role) {
        _checkRole(role);
        _;
    }

    /*************************
     HATS FUNCTIONALITY
     *************************/

    /**
     * @dev Hats Access Control public functions
     */

    function hasRole(bytes32 role, address account) public view returns (bool) {
        return HATS.isWearerOfHat(account, _roles[role].hat);
    }

    function getRoleAdmin(bytes32 role) public view returns (bytes32) {
        return _roles[role].adminRole;
    }

    function grantRole(bytes32 role, uint256 hat)
        public
        onlyRole(getRoleAdmin(role))
    {
        _grantRole(role, hat);
    }

    function revokeRole(bytes32 role, uint256 hat)
        public
        onlyRole(getRoleAdmin(role))
    {
        _revokeRole(role, hat);
    }

    /**
     * @dev Hats Access Control internal functions
     */

    function _checkRole(bytes32 role) internal view {
        _checkRole(role, _msgSender());
    }

    function _checkRole(bytes32 role, address account) internal view {
        if (!hasRole(role, account)) {
            revert NotWearingRoleHat(role, _roles[role].hat, account);
        }
    }

    function _grantRole(bytes32 role, uint256 hat) internal {
        uint256 roleHat = _roles[role].hat;
        if (roleHat > 0) {
            revert RoleAlreadyAssigned(role, roleHat);
        }
        if (roleHat != hat) {
            _roles[role].hat = hat;
        }
    }

    function _revokeRole(bytes32 role, uint256 hat) internal {
        if (_roles[role].hat == hat) {
            _roles[role].hat = 0;
        }
    }
}
