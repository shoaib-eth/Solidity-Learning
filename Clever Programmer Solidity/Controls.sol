// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Controls {
    uint myNumber;

    function StoreValue(uint _myNumber) public {
        myNumber = _myNumber;
    }

    function isEven() public view returns (bool) {
        if (myNumber % 2 == 0) {
            return true;
        } else {
            return false;
        }
    }
}
