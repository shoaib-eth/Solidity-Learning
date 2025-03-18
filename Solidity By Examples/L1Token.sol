// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/// @title L1Token Contract
/// @author shoaib.eth
/// @notice This contract implements an ERC20 token named "L1Token".
/// @dev This contract inherits from OpenZeppelin's ERC20 implementation.
contract L1Token is ERC20 {
    /// @notice Constructor to initialize the token with an initial supply.
    /// @param initialSupply The total supply of tokens to mint initially.
    constructor(uint256 initialSupply) ERC20("L1Token", "L1T") {
        _mint(msg.sender, initialSupply);
    }
}
