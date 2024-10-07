// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract Airdrop {
    address public owner;
    mapping(address => uint256) public balances;

    event Airdropped(address indexed recipient, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function airdrop(address[] calldata recipients, uint256 amount) external onlyOwner {
        for (uint256 i = 0; i < recipients.length; i++) {
            balances[recipients[i]] += amount;
            emit Airdropped(recipients[i], amount);
        }
    }

    function withdraw() external {
        uint256 amount = balances[msg.sender];
        require(amount > 0, "No balance to withdraw");
        balances[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
    }

    receive() external payable {}
}