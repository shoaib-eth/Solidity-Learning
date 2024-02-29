// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract Accountability {
    address public owner;
    uint public lastActive;

    constructor() {
        owner = msg.sender;
        lastActive = block.timestamp;
    }

    function ping() public {
        lastActive = block.timestamp;
    }

    function transferOwnership(address newOwner) public {
        require(msg.sender == owner, "You are not the owner");
        owner = newOwner;
    }

    function isOwner() public view returns (bool) {
        return msg.sender == owner;
    }

    function timeSinceLastActive() public view returns (uint) {
        return block.timestamp - lastActive;
    }
}
