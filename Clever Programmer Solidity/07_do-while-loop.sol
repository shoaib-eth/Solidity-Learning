// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Important Note
// Not recommended to use do-while loop in Solidity

contract doWhileLoop {
    uint256[] public numbers;

    constructor(uint256[] memory _numbers) {
        numbers = _numbers;
    }

    function sumWithdowhileLoop() public view returns (uint256) {
        uint256 sum = 0;
        uint256 i = 0;

        do {
            sum += numbers[i];
            i++;
        } while (i < numbers.length);
        return sum;
    }
}
