// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Constants {
    // Address constant
    address public constant MY_ADDRESS = 0x777788889999AaAAbBbbCcccddDdeeeEfFFfCcCc;

    // Unsigned integer constant
    uint256 public constant MY_UINT = 123;

    // String constant
    string public constant MY_STRING = "Hello, Solidity!";

    // Bytes32 constant
    bytes32 public constant MY_BYTES32 = keccak256(abi.encodePacked("Solidity"));

    // Integer constant
    int256 public constant MY_INT = -123;

    // Boolean constant
    bool public constant MY_BOOL = true;

    // Function to demonstrate the use of constants
    function getConstants() public pure returns (address, uint256, string memory, bytes32, int256, bool) {
        return (MY_ADDRESS, MY_UINT, MY_STRING, MY_BYTES32, MY_INT, MY_BOOL);
    }

    // Function to demonstrate the use of a constant in a calculation
    function multiplyByConstant(uint256 value) public pure returns (uint256) {
        return value * MY_UINT;
    }

    // Function to demonstrate the use of a constant in a condition
    function isAddressEqual(address addr) public pure returns (bool) {
        return addr == MY_ADDRESS;
    }

    // Function to demonstrate the use of a constant in a condition
    function isStringEqual(string memory str) public pure returns (bool) {
        return keccak256(abi.encodePacked(str)) == keccak256(abi.encodePacked(MY_STRING));
    }
}
