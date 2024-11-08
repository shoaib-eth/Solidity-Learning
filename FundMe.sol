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
        uint256 usdAmount = msg.value.getConversionRate();
        // Directly check if the user has sent sufficient ETH in USD terms
        if (usdAmount < MINIMUM_USD) {
            revert FundMe__NotEnoughETH();
        }
        // Instead of pushing to funders array on every fund, maintain mapping only
        addressToAmountFunded[msg.sender] += msg.value;
        if (addressToAmountFunded[msg.sender] == msg.value) {
            funders.push(msg.sender); // Add funder to array only if it's their first funding
        }
    }

    function withdraw() public onlyOwner {
        uint256 totalBalance = address(this).balance;
        // Efficient transfer directly to the owner without looping through funders
        (bool callSuccess,) = payable(msg.sender).call{value: totalBalance}("");
        if (!callSuccess) {
            revert Fund__WithdrawalFailed();
        }

        // Reset funded amounts after successful withdrawal
        for (uint256 i = 0; i < funders.length; i++) {
            address funder = funders[i];
            addressToAmountFunded[funder] = 0;
        }

        // Clear the funders array in one transaction (fewer gas)
        delete funders;
    }
}
