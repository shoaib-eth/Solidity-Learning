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

    function transfer(address _to, uint256 _amount) public {
        require(_amount <= balance, "Insufficient balance");
        require(msg.sender == owner, "You are not the owner");

        balance -= _amount;
        payable(_to).transfer(_amount);
    }

    function getBalance() public view returns (uint256) {
        return balance;
    }

    function getOwner() public view returns (address) {
        return owner;
    }

    function getContractAddress() public view returns (address) {
        return address(this);
    }

    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function getSender() public view returns (address) {
        return msg.sender;
    }
}
