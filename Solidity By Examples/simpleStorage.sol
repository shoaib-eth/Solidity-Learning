// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract simpleStorage {
    uint public myNumber;

    function setNum(uint _num) public {
        myNumber = _num;
    }

    function getNum() public view returns (uint) {
        return myNumber + 2;
    }
}
