// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

/**
 * @title PuppyNftRaffle
 * @dev A smart contract for conducting a raffle where participants can win an NFT.
 *      The contract owner can set up the raffle, allow participants to enter, and select a winner.
 *      The winner is chosen randomly from the list of participants.
 */
contract PuppyNftRaffle is Ownable {
    /**
     * @dev The NFT contract interface used for transferring the NFT to the winner.
     */
    IERC721 public puppyNft;

    /**
     * @dev Array to store the addresses of participants who entered the raffle.
     */
    address[] public participants;

    /**
     * @dev The timestamp indicating when the raffle ends.
     */
    uint256 public raffleEndTime;

    /**
     * @dev Boolean flag to indicate whether the raffle has ended and a winner has been selected.
     */
    bool public raffleEnded;

    /**
     * @dev Emitted when a participant enters the raffle.
     * @param participant The address of the participant who entered the raffle.
     */
    event EnterRaffle(address indexed participant);

    /**
     * @dev Emitted when a winner is selected.
     * @param winner The address of the winner.
     */
    event WinnerSelected(address indexed winner);

    /**
     * @notice Constructor to initialize the raffle contract.
     * @param _puppyNftAddress The address of the NFT contract.
     * @param _raffleDuration The duration of the raffle in seconds.
     */
    constructor(address _puppyNftAddress, uint256 _raffleDuration) {
        puppyNft = IERC721(_puppyNftAddress);
        raffleEndTime = block.timestamp + _raffleDuration;
    }

    /**
     * @notice Allows a user to enter the raffle.
     * @dev Adds the sender's address to the participants array.
     *      Emits the `EnterRaffle` event.
     * @require The raffle must not have ended.
     */
    function enterRaffle() external;

    /**
     * @notice Allows the owner to select a winner after the raffle ends.
     * @dev Selects a random winner from the participants array and transfers the NFT to the winner.
     *      Emits the `WinnerSelected` event.
     * @param _tokenId The ID of the NFT to be transferred to the winner.
     * @require The raffle must have ended.
     * @require The winner must not have already been selected.
     * @require There must be at least one participant in the raffle.
     */
    function selectWinner(uint256 _tokenId) external onlyOwner;

    /**
     * @notice Retrieves the list of participants in the raffle.
     * @return An array of addresses of participants.
     */
    function getParticipants() external view returns (address[] memory);

    /**
     * @notice Checks if the raffle has ended.
     * @return A boolean indicating whether the raffle has ended.
     */
    function isRaffleEnded() external view returns (bool);

    /**
     * @notice Retrieves the timestamp when the raffle ends.
     * @return The raffle end time as a UNIX timestamp.
     */
    function getRaffleEndTime() external view returns (uint256);

    /**
     * @notice Retrieves the address of the NFT contract used in the raffle.
     * @return The address of the NFT contract.
     */
    function getPuppyNftAddress() external view returns (address);

    /**
     * @notice Fallback function to prevent accidental ETH transfers to the contract.
     * @dev Reverts any direct ETH transfers to the contract.
     */
    receive() external payable;
}
