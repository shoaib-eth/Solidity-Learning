// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;

contract StorageOptimization {
    uint256 public data = 10;

    // This function will cost less gas
    function increment() public {
        data += 1;
    }

    // This function will cost more gas
    function incrementBy(uint256 _value) public {
        data += _value;
    }
}