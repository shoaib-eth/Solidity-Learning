// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract AirdropToken is ERC20, Ownable {
    // Constructor to initialize the token with a name and symbol
    constructor() ERC20("AirdropToken", "ADT") {
        _mint(msg.sender, 1000000 * 10 ** decimals()); // Mint initial supply to contract owner
    }

    // Function to airdrop tokens to multiple addresses
    function airdrop(address[] calldata recipients, uint256 amount) external onlyOwner {
        require(recipients.length > 0, "Recipients required");
        require(amount > 0, "Amount should be greater than zero");

        for (uint256 i = 0; i < recipients.length; i++) {
            _transfer(msg.sender, recipients[i], amount);
        }
    }
}
