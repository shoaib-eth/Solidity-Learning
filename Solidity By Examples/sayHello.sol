// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract sayHello {
    string public message;
    
    constructor() {
        message = "Hello, World!";
    }
    
    function setMessage(string memory newMessage) public {
        message = newMessage;
    }
    
    function getMessage() public view returns (string memory) {
        return message;
    }
}