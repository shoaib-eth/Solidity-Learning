// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract MerkleAirdrop is Ownable {
    bytes32 public merkleRoot;
    IERC20 public token;
    mapping(address => bool) public claimed;

    event Claimed(address indexed account, uint256 amount);

    constructor(bytes32 _merkleRoot, address _token) {
        merkleRoot = _merkleRoot;
        token = IERC20(_token);
    }

    function claim(uint256 amount, bytes32[] calldata merkleProof) external {
        require(!claimed[msg.sender], "Airdrop already claimed.");

        bytes32 leaf = keccak256(abi.encodePacked(msg.sender, amount));
        require(MerkleProof.verify(merkleProof, merkleRoot, leaf), "Invalid proof.");

        claimed[msg.sender] = true;
        require(token.transfer(msg.sender, amount), "Token transfer failed.");

        emit Claimed(msg.sender, amount);
    }

    function updateMerkleRoot(bytes32 _merkleRoot) external onlyOwner {
        merkleRoot = _merkleRoot;
    }
}
