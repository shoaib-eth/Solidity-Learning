// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract MerkleTree {
    bytes32[] public hashes;

    // Constructor to initialize the Merkle Tree with some data
    constructor() {
        // Example data
        string[4] memory transactions = ["TX1", "TX2", "TX3", "TX4"];

        // Hash the transactions and store them in the hashes array
        for (uint256 i = 0; i < transactions.length; i++) {
            hashes.push(keccak256(abi.encodePacked(transactions[i])));
        }

        // Build the Merkle Tree
        uint256 n = transactions.length;
        uint256 offset = 0;
        while (n > 1) {
            for (uint256 i = 0; i < n - 1; i += 2) {
                hashes.push(keccak256(abi.encodePacked(hashes[offset + i], hashes[offset + i + 1])));
            }
            offset += n;
            n = n / 2;
        }
    }

    // Function to get the root of the Merkle Tree
    function getRoot() public view returns (bytes32) {
        return hashes[hashes.length - 1];
    }
}
