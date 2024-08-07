// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract Accountability {
    address public owner;
    uint256 public lastActive;

    constructor() {
        owner = msg.sender;
        lastActive = block.timestamp;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner");
        _;
    }

    function ping() public onlyOwner {
        lastActive = block.timestamp;
    }

    function transferOwnership(address newOwner) public {
        require(msg.sender == owner, "You are not the owner");
        owner = newOwner;
    }

    function isOwner() public view returns (bool) {
        return msg.sender == owner;
    }

    function timeSinceLastActive() public view returns (uint256) {
        return block.timestamp - lastActive;
    }
}
