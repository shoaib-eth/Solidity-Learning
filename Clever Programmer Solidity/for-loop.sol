// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract forLoop {
    uint256[] public numbers;

    constructor(uint256[] memory _numbers) {
        numbers = _numbers;
    }

    function someWithForLoop() public view returns (uint256) {
        uint256 sum = 0;
        for (uint256 i = 0; i < numbers.length; i++) {
            sum += numbers[i];
        }
        return sum;
    }
}
