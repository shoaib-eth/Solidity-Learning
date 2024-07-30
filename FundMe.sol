// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {priceConverter} from "./priceConverter.sol";

error NotOwner();

contract FundMe {
    using priceConverter for uint256;

    uint256 public constant MINIMUM_USD = 50 * 1e18;
    // Constant  - > gas : 846814
    // Without Constant  - > gas : 869758

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    address public immutable i_owner;

    // Immutable - > gas : 846814
    // Without Immutable - > gas : 873461

    constructor() {
        i_owner = msg.sender;
    }

    function fund() public payable {
        require(
            msg.value.getConversionRate() > MINIMUM_USD,
            "didn't Send Enough ETH"
        );

        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public onlyOwner {
        for (
            uint256 funderIndex = 0;
            funderIndex < funders.length;
            funderIndex++
        ) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        // Resetting the array of funders addressess
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
        require(callSuccess, "call failed");
        revert();
    }

    modifier onlyOwner() {
        // require(msg.sender == i_owner,"Only the contract owner can call this function");
        if (msg.sender != i_owner) revert NotOwner();
        _;

        // In this require keyword means, in the function of withdraw, require statement execute first.
        // and _; means, execution of function code.
        // If we want to execute function code first, we declare _; first in the function modifier, and then require keyword.
    }
}
