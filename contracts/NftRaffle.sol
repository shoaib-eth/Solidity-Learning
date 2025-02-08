// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

/**
 * @title NftRaffle
 * @dev A contract for conducting an NFT raffle using Merkle Proof for whitelist verification.
 */
contract NftRaffle is Ownable {
    IERC721 public nft;
    uint256 public raffleEndTime;
    uint256 public ticketPrice;
    address[] public participants;
    bytes32 public merkleRoot;
    address public feesAddress;
    uint256 public feesCollected;

    event RaffleEntered(address indexed participant);
    event WinnerSelected(address indexed winner);

    /**
     * @dev Constructor to initialize the NFT raffle contract.
     * @param _nftAddress Address of the NFT contract.
     * @param _raffleDuration Duration of the raffle in seconds.
     * @param _ticketPrice Price of a single raffle ticket.
     * @param _merkleRoot Root of the Merkle Tree for whitelist verification.
     * @param _feesAddress Address where the fees will be collected.
     */
    constructor(
        address _nftAddress,
        uint256 _raffleDuration,
        uint256 _ticketPrice,
        bytes32 _merkleRoot,
        address _feesAddress
    ) {
        nft = IERC721(_nftAddress);
        raffleEndTime = block.timestamp + _raffleDuration;
        ticketPrice = _ticketPrice;
        merkleRoot = _merkleRoot;
        feesAddress = _feesAddress;
    }

    /**
     * @dev Function to enter the raffle.
     * @param _merkleProof Merkle Proof to verify the participant is whitelisted.
     */
    function enterRaffle(bytes32[] calldata _merkleProof) external payable {
        require(block.timestamp < raffleEndTime, "Raffle has ended");
        require(msg.value == ticketPrice, "Incorrect ticket price");

        bytes32 leaf = keccak256(abi.encodePacked(msg.sender));
        require(MerkleProof.verify(_merkleProof, merkleRoot, leaf), "Invalid proof");

        participants.push(msg.sender);
        emit RaffleEntered(msg.sender);

        // Collect fees
        uint256 fees = (msg.value * 20) / 100;
        feesCollected += fees;
    }

    /**
     * @dev Function to select a winner randomly from the participants.
     * Can only be called by the owner.
     */
    function selectWinner() external onlyOwner {
        require(block.timestamp >= raffleEndTime, "Raffle is still ongoing");
        require(participants.length > 0, "No participants in the raffle");

        uint256 randomIndex =
            uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty))) % participants.length;
        address winner = participants[randomIndex];

        nft.transferFrom(owner(), winner, 1); // Assuming tokenId is 1
        emit WinnerSelected(winner);

        // Transfer prize to winner
        uint256 prizeAmount = (address(this).balance - feesCollected) * 80 / 100;
        payable(winner).transfer(prizeAmount);

        // Reset the raffle
        delete participants;
        raffleEndTime = block.timestamp + (raffleEndTime - block.timestamp);
    }

    /**
     * @dev Function to withdraw collected fees.
     * Can only be called by the owner.
     */
    function withdrawFees() external onlyOwner {
        uint256 amount = feesCollected;
        feesCollected = 0;
        payable(feesAddress).transfer(amount);
    }
}
