// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract IsEven {
    function isEven(uint256 _number) public pure returns (bool) {
        return _number % 2 == 0;
    }
}
