// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Wallet {
    uint256 public balance;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function deposit() public payable {
        balance += msg.value;
    }

    function withdraw(uint256 _amount) public {
        require(_amount <= balance, "Insufficient balance");
        require(msg.sender == owner, "You are not the owner");

        balance -= _amount;
        payable(msg.sender).transfer(_amount);
    }
}
