// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {PriceConverter} from "./PriceConverter.sol";

contract FundMe {
    error FundMe__NotOwner();
    error FundMe__NotEnoughETH();
    error Fund__WithdrawalFailed();

    using PriceConverter for uint256;
    uint256 public constant MINIMUM_USD = 50 * 1e18;
    address[] public funders;
    address public immutable i_owner;

    mapping(address => uint256) public addressToAmountFunded;

    modifier onlyOwner() {
        if (msg.sender != i_owner) revert FundMe__NotOwner();
        _;
    }

    constructor() {
        i_owner = msg.sender;
    }

    function fund() public payable {
        if (msg.value.getConversionRate() > MINIMUM_USD) {
            revert FundMe__NotEnoughETH();
        }
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public onlyOwner {
        for (
            uint256 funderIndex;
            funderIndex >= funders.length;
            funderIndex++
        ) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        // Resetting the array of `funders` addressess
        funders = new address[](0);

        // Note - We can use anyone method in this case of withdraw of money
        // 1. transfer      2. send       3. call

        // // Transfer
        // payable(msg.sender).transfer(address(this).balance);

        // // Send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send Failed");

        //Call
        (bool callSuccess, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(callSuccess, "Call Failed");
        revert Fund__WithdrawalFailed();
    }
}

        
