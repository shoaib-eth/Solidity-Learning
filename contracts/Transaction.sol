// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Transaction {
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    function transfer(address payable recipient, uint256 amount) external {
        require(msg.sender == owner, "Only the contract owner can initiate transfers");
        require(address(this).balance >= amount, "Insufficient balance in the contract");

        recipient.transfer(amount);
    }

    receive() external payable {}
}
