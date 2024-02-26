// SPDX-License-Identifier: MIT 
pragma solidity 0.8.24;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe {
    // Minimum USD value for a valid contribution (currently $5)
    uint256 public minimumUSD = 5e18;

    // Keeps track of who funded the contract
    address[] public funders; 
    // Records how much each address contributed 
    mapping(address => uint256) public addressToAmountFunded;

    // Allows contributions in ETH, checks if they meet the minimum USD value
    function fund() public payable {
        // Use getConversionRate to determine if enough ETH was sent
        require(getConversionRate(msg.value) >= minimumUSD, "Didn't send enough ETH"); 

        funders.push(msg.sender); // Record the funder
        addressToAmountFunded[msg.sender] += msg.value; // Update funding amount
    } 

    // Gets the current ETH/USD exchange rate from a Chainlink price feed
    function getPrice() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (, int256 price, , , ) = priceFeed.latestRoundData();
        // Adjust price to match 18 decimals used in ETH calculations
        return uint256(price * 1e10); 
    }

    // Calculates the USD equivalent of a given amount of ETH
    function getConversionRate(uint256 ethAmount) public view returns (uint256) {
        uint256 ethPrice = getPrice(); 
        uint256 ethAmountInUSD = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUSD;
    }

    // Gets the version of the Chainlink price feed contract being used
    function getVersion() public view returns (uint256) {
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }
}
