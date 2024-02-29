// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract isOdd {
    uint public num;

    function setNum(uint _num) public {
        num = _num;
    }

    function checkOdd() public view returns (uint){
        if(num % 2 != 0){
            return true;
        }else {
            return false;
        }
    }
}