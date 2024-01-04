// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {simpleStorage} from "./simpleStorage.sol";

contract InheritContract is simpleStorage {
    function store(uint256) public override {
        myNumber = myNumber + 5;
    }

    function sayHello() public pure returns (string memory) {
        return "Hello!";
    }
}
