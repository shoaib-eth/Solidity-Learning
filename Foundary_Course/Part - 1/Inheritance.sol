// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {simpleStorage} from "./simpleStorage.sol";

contract InheritContract is simpleStorage {
    function store(uint) public override {
        myNumber = myNumber + 5;
    }
}