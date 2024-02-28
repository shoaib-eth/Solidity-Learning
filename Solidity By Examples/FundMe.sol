// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract FundMe {
    uint256 public minimumUSD = 5e18;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    function fund() public payable {
        require(msg.value >= minimumUSD, "Didn't send enough ETH");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] =
            addressToAmountFunded[msg.sender] +
            msg.value;
    }

    function getVersion() public view returns (uint256) {
        return 1;
    }

    function getFunders() public view returns (address[] memory) {
        return funders;
    }

    function getFunderAmount(address funder) public view returns (uint256) {
        return addressToAmountFunded[funder];
    }

    function getFunderCount() public view returns (uint256) {
        return funders.length;
    }

    function getMinimumUSD() public view returns (uint256) {
        return minimumUSD;
    }
}