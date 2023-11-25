// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract NewContract {
    mapping(uint256 => string) public myMap;

    function addValue(uint256 key, string memory value) public {
        myMap[key] = value;
    }

    function getValue(uint256 key) public view returns (string memory) {
        return myMap[key];
    }

    function deleteValue(uint256 key) public {
        delete myMap[key];
    }
}