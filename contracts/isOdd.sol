// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract isOdd {
    function isOddNumber(uint _number) public pure returns (bool) {
        return _number % 2 != 0;
    }
}