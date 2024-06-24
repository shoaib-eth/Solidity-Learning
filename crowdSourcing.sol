// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract crowdSourcing {
    AggregatorV3Interface internal priceFeed;

    constructor() {
        // Initialize the priceFeed contract with the specified address
        priceFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
    }

    function getLatestPrice() public view returns (int256) {
        // Retrieve the latest round data from the priceFeed contract
        (, int256 answer, , , ) = priceFeed.latestRoundData();
        return answer;
    }

    function getDecimals() public view returns (uint8) {
        // Retrieve the number of decimals used by the priceFeed contract
        return priceFeed.decimals();
    }

    function getRoundData(uint80 _roundId)
        public
        view
        returns (
            uint80 roundId,
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        )
    {
        // Retrieve the round data for the specified roundId from the priceFeed contract
        return priceFeed.getRoundData(_roundId);
    }
}