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

    /// @notice Withdraws tokens from the contract
    /// @param amount The amount of tokens to withdraw
    function withdraw(uint256 amount) public onlyOwner {
        token.transfer(msg.sender, amount);
    }

    /// @notice Returns the balance of the contract
    /// @return The balance of the contract
    function balance() public view returns (uint256) {
        return token.balanceOf(address(this));
    }

    /// @notice Returns the balance of the owner
    /// @return The balance of the owner
    function ownerBalance() public view returns (uint256) {
        return token.balanceOf(owner());
    }
}
