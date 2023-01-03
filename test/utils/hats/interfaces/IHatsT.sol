// SPDX-License-Identifier: GNU
pragma solidity >=0.8.13;

import "./IHatsIdUtilitiesT.sol";
import "./HatsEventsT.sol";
import "./HatsErrorsT.sol";

interface IHats is IHatsIdUtilitiesT, HatsErrorsT, HatsEventsT {
    function mintTopHat(
        address _target,
        string memory _details,
        string memory _imageURI
    ) external returns (uint256 topHatId);

    function createHat(
        uint256 _admin,
        string memory _details,
        uint32 _maxSupply,
        address _eligibility,
        address _toggle,
        bool _mutable,
        string memory _imageURI
    ) external returns (uint256 newHatId);

    function batchCreateHats(
        uint256[] memory _admins,
        string[] memory _details,
        uint32[] memory _maxSupplies,
        address[] memory _eligibilityModules,
        address[] memory _toggleModules,
        bool[] memory _mutables,
        string[] memory _imageURIs
    ) external returns (bool);

    function getNextId(uint256 _admin) external view returns (uint256);

    function mintHat(uint256 _hatId, address _wearer) external returns (bool);

    function batchMintHats(uint256[] memory _hatIds, address[] memory _wearers)
        external
        returns (bool);

    function setHatStatus(uint256 _hatId, bool _newStatus)
        external
        returns (bool);

    function checkHatStatus(uint256 _hatId) external returns (bool);

    function setHatWearerStatus(
        uint256 _hatId,
        address _wearer,
        bool _eligible,
        bool _standing
    ) external returns (bool);

    function checkHatWearerStatus(uint256 _hatId, address _wearer)
        external
        returns (bool);

    function renounceHat(uint256 _hatId) external;

    function transferHat(
        uint256 _hatId,
        address _from,
        address _to
    ) external;

    /*//////////////////////////////////////////////////////////////
                              HATS ADMIN FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    function makeHatImmutable(uint256 _hatId) external;

    function changeHatDetails(uint256 _hatId, string memory _newDetails)
        external;

    function changeHatEligibility(uint256 _hatId, address _newEligibility)
        external;

    function changeHatToggle(uint256 _hatId, address _newToggle) external;

    function changeHatImageURI(uint256 _hatId, string memory _newImageURI)
        external;

    function changeHatMaxSupply(uint256 _hatId, uint32 _newMaxSupply) external;

    /*//////////////////////////////////////////////////////////////
                              VIEW FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    function viewHat(uint256 _hatId)
        external
        view
        returns (
            string memory details,
            uint32 maxSupply,
            uint32 supply,
            address eligibility,
            address toggle,
            string memory imageURI,
            uint8 lastHatId,
            bool mutable_,
            bool active
        );

    function isWearerOfHat(address _user, uint256 _hatId)
        external
        view
        returns (bool);

    function isAdminOfHat(address _user, uint256 _hatId)
        external
        view
        returns (bool);

    // function isActive(uint256 _hatId) external view returns (bool);

    function isInGoodStanding(address _wearer, uint256 _hatId)
        external
        view
        returns (bool);

    function isEligible(address _wearer, uint256 _hatId)
        external
        view
        returns (bool);

    function getImageURIForHat(uint256 _hatId)
        external
        view
        returns (string memory);

    function balanceOf(address wearer, uint256 hatId)
        external
        view
        returns (uint256 balance);

    function uri(uint256 id) external view returns (string memory);
}
