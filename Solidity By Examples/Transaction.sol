// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Transaction {
    address public buyer; // Address of the buyer
    uint public amount; // Amount of ether bought
    uint public etherPrice; // Price of ether

    constructor() {
        buyer = msg.sender; // Set the buyer as the contract deployer
        amount = 0; // Initialize the amount to 0
        etherPrice = 0; // Initialize the ether price to 0
    }

    function buyEther(uint _amount, uint _etherPrice) external payable {
        require(
            msg.value == _amount * _etherPrice,
            "Incorrect amount of Ether sent"
        );
        amount += _amount; // Add the bought amount to the total amount
        etherPrice = _etherPrice; // Update the ether price
    }

    function getBalance() external view returns (uint) {
        return address(this).balance; // Return the contract's balance
    }
}
