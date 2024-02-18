// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.24;

contract FundMe {
    uint256 public myValue;

    function fund() public payable {
        myValue = myValue + 1;
    }
}