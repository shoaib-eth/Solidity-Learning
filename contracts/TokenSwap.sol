// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TokenSwap is Ownable {
    IERC20 public token1;
    IERC20 public token2;
    uint256 public rate; // Number of token2 units per token1 unit

    event Swap(address indexed user, uint256 amount1, uint256 amount2);

    constructor(IERC20 _token1, IERC20 _token2, uint256 _rate) {
        token1 = _token1;
        token2 = _token2;
        rate = _rate;
    }

    function swap(uint256 amount1) external {
        require(amount1 > 0, "Amount must be greater than zero");
        uint256 amount2 = amount1 * rate;
        require(token2.balanceOf(address(this)) >= amount2, "Insufficient token2 balance in contract");

        token1.transferFrom(msg.sender, address(this), amount1);
        token2.transfer(msg.sender, amount2);

        emit Swap(msg.sender, amount1, amount2);
    }

    function setRate(uint256 _rate) external onlyOwner {
        rate = _rate;
    }

    function withdrawToken1(uint256 amount) external onlyOwner {
        token1.transfer(owner(), amount);
    }

    function withdrawToken2(uint256 amount) external onlyOwner {
        token2.transfer(owner(), amount);
    }
}
