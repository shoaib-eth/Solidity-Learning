// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract NFT is ERC721 {
    uint256 public tokenCounter;
    mapping(uint256 => string) public _tokenURIs;

    constructor() ERC721("NFT", "NFT") {
        tokenCounter = 0;
    }

    function createNFT(
        address owner,
        string memory tokenURI
    ) public returns (uint256) {
        uint256 newItemId = tokenCounter;
        _safeMint(owner, newItemId);
        _setTokenURI(newItemId, tokenURI);
        tokenCounter = tokenCounter + 1;
        return newItemId;
    }

    function _setTokenURI(
        uint256 tokenId,
        string memory _tokenURI
    ) internal virtual {
        _tokenURIs[tokenId] = _tokenURI;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "https://nft-api-123.herokuapp.com/api/token/";
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        return string(abi.encodePacked(_baseURI(), _tokenURIs[tokenId]));
    }

    function getOwnerNFTs(
        address owner
    ) public view returns (uint256[] memory) {
        uint256[] memory result = new uint256[](balanceOf(owner));
        for (uint256 i = 0; i < balanceOf(owner); i++) {
            result[i] = tokenOfOwnerByIndex(owner, i);
        }
        return result;
    }
}
