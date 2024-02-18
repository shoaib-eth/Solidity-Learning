// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.24;

contract FundMe {
    uint256 public myValue;

    // payable is a modifier that allows a function to receive ether
    function fund() public payable {
        myValue = myValue + 1;

        require(msg.value >= 0.01 ether, "Minimum contribution is 0.01 ether");
    }

    // transfer the balance of the contract to the caller
    function withdraw() public {
        payable(msg.sender).transfer(address(this).balance);
    }
}
