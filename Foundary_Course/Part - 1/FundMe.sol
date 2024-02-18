// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.24;

contract FundMe {
    uint256 public myValue;

    function fund() public payable {
        myValue = myValue + 1;

        require(msg.value >= 0.01 ether, "Minimum contribution is 0.01 ether");
    }
}
