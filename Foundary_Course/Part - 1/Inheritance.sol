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

    event LogMessage(string message);

    string public lastMessage;

    function isEven(uint256 _num) public {
        if (_num % 2 == 0) {
            lastMessage = "Number is Even";
            emit LogMessage(lastMessage);
        } else {
            lastMessage = "Number is Odd";
            emit LogMessage(lastMessage);
        }
    }

    function retrieveIsEven() public view returns (string memory) {
        return lastMessage;
    }
}