// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

// Import the IERC20 interface from OpenZeppelin
/**
 * @dev This file imports the IERC20 interface from the OpenZeppelin library.
 * The IERC20 interface defines the standard functions for ERC20 tokens,
 * such as transferring tokens, checking balances, and approving allowances.
 *
 * Note:
 * - Ensure that the OpenZeppelin contracts library is installed in your project.
 * - If you encounter a "File not found" error, verify that the library is properly installed
 *   and the import path is correct.
 *
 * Installation:
 * To install OpenZeppelin contracts, use the following command:
 * `npm install @openzeppelin/contracts`
 *
 * Documentation:
 * For more details on the IERC20 interface, refer to the official OpenZeppelin documentation:
 * https://docs.openzeppelin.com/contracts
 */
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TokenSwap {
    IERC20 public token1;
    IERC20 public token2;
    address public owner;

    constructor(address _token1, address _token2) {
        token1 = IERC20(_token1);
        token2 = IERC20(_token2);
        owner = msg.sender;
    }

    function swap(address fromToken, address toToken, uint256 amount) external {
        require(fromToken == address(token1) || fromToken == address(token2), "Invalid fromToken address");
        require(toToken == address(token1) || toToken == address(token2), "Invalid toToken address");
        require(fromToken != toToken, "Cannot swap the same token");

        IERC20 from = IERC20(fromToken);
        IERC20 to = IERC20(toToken);

        require(from.allowance(msg.sender, address(this)) >= amount, "Insufficient allowance");

        // Transfer `amount` of `fromToken` from the sender to this contract
        from.transferFrom(msg.sender, address(this), amount);

        // Transfer `amount` of `toToken` from this contract to the sender
        to.transfer(msg.sender, amount);
    }
}
