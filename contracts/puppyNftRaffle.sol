// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract PuppyNftRaffle is Ownable {
    IERC721 public puppyNft;
    address[] public participants;
    uint256 public raffleEndTime;
    bool public raffleEnded;

    event EnterRaffle(address indexed participant);
    event WinnerSelected(address indexed winner);

    constructor(address _puppyNftAddress, uint256 _raffleDuration) {
        puppyNft = IERC721(_puppyNftAddress);
        raffleEndTime = block.timestamp + _raffleDuration;
    }

    function enterRaffle() external {
        require(block.timestamp < raffleEndTime, "Raffle has ended");
        participants.push(msg.sender);
        emit EnterRaffle(msg.sender);
    }

    function selectWinner(uint256 _tokenId) external onlyOwner {
        require(block.timestamp >= raffleEndTime, "Raffle is still ongoing");
        require(!raffleEnded, "Winner already selected");
        require(participants.length > 0, "No participants in the raffle");

        uint256 winnerIndex =
            uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty, participants))) % participants.length;
        address winner = participants[winnerIndex];

        puppyNft.safeTransferFrom(owner(), winner, _tokenId);
        raffleEnded = true;

        emit WinnerSelected(winner);
    }

    /**
     * Getter Functions
     */
    function getParticipants() external view returns (address[] memory) {
        return participants;
    }

    function isRaffleEnded() external view returns (bool) {
        return raffleEnded;
    }
}
