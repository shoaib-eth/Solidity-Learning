// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import "@openzeppelin/contracts/utils/cryptography/Random.sol";

contract NftRaffle is Ownable {
    IERC721 public nft;
    uint256 public raffleEndTime;
    uint256 public ticketPrice;
    address[] public participants;
    bytes32 public merkleRoot;

    event RaffleEntered(address indexed participant);
    event WinnerSelected(address indexed winner);

    constructor(address _nftAddress, uint256 _raffleDuration, uint256 _ticketPrice, bytes32 _merkleRoot) {
        nft = IERC721(_nftAddress);
        raffleEndTime = block.timestamp + _raffleDuration;
        ticketPrice = _ticketPrice;
        merkleRoot = _merkleRoot;
    }

    function enterRaffle(bytes32[] calldata _merkleProof) external payable {
        require(block.timestamp < raffleEndTime, "Raffle has ended");
        require(msg.value == ticketPrice, "Incorrect ticket price");

        bytes32 leaf = keccak256(abi.encodePacked(msg.sender));
        require(MerkleProof.verify(_merkleProof, merkleRoot, leaf), "Invalid proof");

        participants.push(msg.sender);
        emit RaffleEntered(msg.sender);
    }

    function selectWinner() external onlyOwner {
        require(block.timestamp >= raffleEndTime, "Raffle is still ongoing");
        require(participants.length > 0, "No participants in the raffle");

        uint256 randomIndex = Random.random() % participants.length;
        address winner = participants[randomIndex];

        nft.transferFrom(owner(), winner, 1); // Assuming tokenId is 1
        emit WinnerSelected(winner);

        // Reset the raffle
        delete participants;
        raffleEndTime = block.timestamp + (raffleEndTime - block.timestamp);
    }

    function transferPrizeToWinner(address winner) external onlyOwner {
        require(block.timestamp >= raffleEndTime, "Raffle is still ongoing");
        require(participants.length > 0, "No participants in the raffle");

        uint256 prizeAmount = address(this).balance;
        payable(winner).transfer(prizeAmount);
    }
}
