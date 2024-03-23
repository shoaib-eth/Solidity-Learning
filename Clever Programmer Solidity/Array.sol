// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract Array {
    uint[] public numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

    function getNumber(uint _index) public view returns (uint) {
        return numbers[_index];
    }

    function getNumbers() public view returns (uint[] memory) {
        return numbers;
    }

    function pushNumber(uint _number) public {
        numbers.push(_number);
    }

    function popNumber() public {
        numbers.pop();
    }

    function getLength() public view returns (uint) {
        return numbers.length;
    }
}
