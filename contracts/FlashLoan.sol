// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/*
    * FlashLoan
    * A simple smart contract that demonstrates the use of flash loans.
    * The contract is implemented using Solidity version 0.8.24.
    * The contract uses the Aave flash loan feature to borrow tokens and repay them in the same transaction.
*/

contract FlashLoan is Ownable {
    IERC20 public token;

    constructor(address _token) {
        token = IERC20(_token);
    }

    /// @notice Initiates a flash loan
    /// @param amount The amount of tokens to borrow
    function flashLoan(uint256 amount) public onlyOwner {
        // Borrow the tokens
        token.transferFrom(msg.sender, address(this), amount);

        // Repay the tokens
        token.transfer(msg.sender, amount);
    }
}
