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


// Another contract to interact with the Transaction contract
contract TransactionDetails {
    Transaction private transactionContract;

    constructor(address _transactionContract) {
        transactionContract = Transaction(_transactionContract);
    }

    // Get the address of the buyer
    function getBuyer() external view returns (address) {
        return transactionContract.buyer();
    }

    // Get the amount of ether bought
    function getAmount() external view returns (uint) {
        return transactionContract.amount();
    }

    // Get the price of ether
    function getEtherPrice() external view returns (uint) {
        return transactionContract.etherPrice();
    }

    // Get the balance of the transaction contract
    function getBalance() external view returns (uint) {
        return transactionContract.getBalance();
    }
}
