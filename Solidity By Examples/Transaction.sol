// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Transaction {
    address public buyer;
    uint public amount;
    uint public etherPrice;

    constructor() {
        buyer = msg.sender;
        amount = 0;
        etherPrice = 0;
    }

    function buyEther(uint _amount, uint _etherPrice) external payable {
        require(
            msg.value == _amount * _etherPrice,
            "Incorrect amount of Ether sent"
        );
        amount += _amount;
        etherPrice = _etherPrice;
    }

    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
}
