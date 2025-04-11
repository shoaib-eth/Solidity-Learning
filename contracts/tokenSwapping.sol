// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

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