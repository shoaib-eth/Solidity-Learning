// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {simpleStorage} from "./simpleStorage.sol";

contract InheritContract is simpleStorage {
    function store(uint256) public override {
        myNumber = myNumber + 5;
    }

    function sayHello() public pure returns (string memory) {
        return "Hello!";
    }

    event LogMessage(string message); // Event Declaration is here (It is not a function)

    string public lastMessage; // State Variable Declaration is here (It is not a function)

    function isEven(uint256 _num) public {
        // Function Declaration is here
        if (_num % 2 == 0) {
            // State Variable is accessed here
            lastMessage = "Number is Even";
            emit LogMessage(lastMessage); // Event is emitted here
        } else {
            lastMessage = "Number is Odd";
            emit LogMessage(lastMessage);
        }
    }

    function retrieveIsEven() public view returns (string memory) {
        // Function Declaration is here
        return lastMessage; // State Variable is accessed here
    }
}
