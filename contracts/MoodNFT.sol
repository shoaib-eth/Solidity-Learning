// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MoodNFT is ERC721, Ownable {
    enum Mood { Happy, Sad }
    mapping(uint256 => Mood) private _tokenMoods;

    constructor() ERC721("MoodNFT", "MOOD") {}

    function mint(address to, uint256 tokenId, Mood mood) public onlyOwner {
        _mint(to, tokenId);
        _tokenMoods[tokenId] = mood;
    }

    function getMood(uint256 tokenId) public view returns (Mood) {
        require(_exists(tokenId), "Token does not exist");
        return _tokenMoods[tokenId];
    }

    function setMood(uint256 tokenId, Mood mood) public {
        require(ownerOf(tokenId) == msg.sender, "Only the owner can set the mood");
        _tokenMoods[tokenId] = mood;
    }
}