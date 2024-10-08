// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/access/Ownable.sol";

contract DefiStableCoin is Ownable {
    mapping(address => uint256) public balances;
    address[] private holders;

    event Minted(address indexed recipient, uint256 amount);
    event Burned(address indexed from, uint256 amount);

    function mint(address recipient, uint256 amount) external onlyOwner {
        balances[recipient] += amount;
        emit Minted(recipient, amount);
    }

    function burn(address from, uint256 amount) external onlyOwner {
        require(balances[from] >= amount, "Not enough balance to burn");
        balances[from] -= amount;
        emit Burned(from, amount);
    }

    function transfer(address to, uint256 amount) external {
        require(
            balances[msg.sender] >= amount,
            "Not enough balance to transfer"
        );
        balances[msg.sender] -= amount;
        balances[to] += amount;
    }

    function balanceOf(address account) external view returns (uint256) {
        return balances[account];
    }

    function totalSupply() external view returns (uint256) {
        uint256 supply = 0;
        for (uint256 i = 0; i < holders.length; i++) {
            supply += balances[holders[i]];
        }
        return supply;
    }

    function _addHolder(address account) internal {
        if (balances[account] == 0) {
            holders.push(account);
        }
    }
}
