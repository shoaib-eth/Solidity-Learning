// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFT is ERC721, Ownable {
    using SafeMath for uint256;

    uint256 public constant MAX_NFT_SUPPLY = 10000;
    uint256 public constant MAX_MINT_AMOUNT = 20;
    uint256 public constant PRICE = 0.05 ether;

    uint256 public startingIndexBlock;
    uint256 public startingIndex;
    uint256 public saleStartTimestamp;
    uint256 public revealTimestamp;

    string public baseTokenURI;

    bool public paused = false;
    bool public onlyWhitelisted = true;
    bool public revealed = false;

    mapping(address => bool) public whitelisted;

    constructor(string memory _name, string memory _symbol, string memory _baseTokenURI) ERC721(_name, _symbol) {
        baseTokenURI = _baseTokenURI;
    }

    function mint(uint256 _mintAmount) public payable {
        uint256 supply = totalSupply();
        require(!paused, "The contract is paused");
        require(_mintAmount > 0, "You cannot mint 0 NFTs");
        require(_mintAmount <= MAX_MINT_AMOUNT, "You are minting too many NFTs");
        require(supply + _mintAmount <= MAX_NFT_SUPPLY, "Exceeds maximum NFT supply");
        require(msg.value >= PRICE.mul(_mintAmount), "Ether sent is not correct");

        if (onlyWhitelisted) {
            require(whitelisted[msg.sender], "You are not whitelisted");
        }

        for (uint256 i = 0; i < _mintAmount; i++) {
            _safeMint(msg.sender, supply + i);
        }
    }

    function setBaseTokenURI(string memory _baseTokenURI) public onlyOwner {
        baseTokenURI = _baseTokenURI;
    }

    function pause(bool _paused) public onlyOwner {
        paused = _paused;
    }

    function setRevealTimestamp(uint256 _revealTimestamp) public onlyOwner {
        revealTimestamp = _revealTimestamp;
    }

    function setOnlyWhitelisted(bool _onlyWhitelisted) public onlyOwner {
        onlyWhitelisted = _onlyWhitelisted;
    }

    function setWhitelisted(address[] memory _addresses, bool _whitelisted) public onlyOwner {
        for (uint256 i = 0; i < _addresses.length; i++) {
            whitelisted[_addresses[i]] = _whitelisted;
        }
    }

    function withdraw() public onlyOwner {
        uint256 balance = address(this).balance;
        payable(msg.sender).transfer(balance);
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        return bytes(baseTokenURI).length > 0 ? string(abi.encodePacked(baseTokenURI, tokenId.toString())) : "";
    }

    function reveal() public onlyOwner {
        require(block.timestamp >= revealTimestamp, "The reveal time has not come yet");
        revealed = true;
    }

    function startSale(uint256 _saleStartTimestamp) public onlyOwner {
        saleStartTimestamp = _saleStartTimestamp;
    }

    function setStartingIndex() public {
        require(startingIndex == 0, "Starting index is already set");
        require(startingIndexBlock != 0, "Starting index block must be set");

        startingIndex = uint256(blockhash(startingIndexBlock)) % MAX_NFT_SUPPLY;

        if (block.number.sub(startingIndexBlock) > 255) {
            startingIndex = uint256(blockhash(block.number - 1)) % MAX_NFT_SUPPLY;
        }

        if (startingIndex == 0) {
            startingIndex = startingIndex.add(1);
        }
    }

    function setStartingIndexBlock() public {
        require(startingIndexBlock == 0, "Starting index block is already set");
        startingIndexBlock = block.number;
    }

    function emergencySetStartingIndexBlock() public onlyOwner {
        require(startingIndexBlock == 0, "Starting index block is already set");
        startingIndexBlock = block.number;
    }

    function emergencySetStartingIndex() public onlyOwner {
        require(startingIndex == 0, "Starting index is already set");
        startingIndex = uint256(blockhash(block.number - 1)) % MAX_NFT_SUPPLY;
        if (startingIndex == 0) {
            startingIndex = startingIndex.add(1);
        }
    }

    function emergencySetRevealTimestamp() public onlyOwner {
        require(revealTimestamp == 0, "Reveal timestamp is already set");
        revealTimestamp = block.timestamp;
    }

    function emergencySetSaleStartTimestamp() public onlyOwner {
        require(saleStartTimestamp == 0, "Sale start timestamp is already set");
        saleStartTimestamp = block.timestamp;
    }

    function emergencySetBaseTokenURI(string memory _baseTokenURI) public onlyOwner {
        baseTokenURI = _baseTokenURI;
    }

    function emergencySetPaused(bool _paused) public onlyOwner {
        paused = _paused;
    }

    function emergencySetOnlyWhitelisted(bool _onlyWhitelisted) public onlyOwner {
        onlyWhitelisted = _onlyWhitelisted;
    }

    function emergencySetWhitelisted(address[] memory _addresses, bool _whitelisted) public onlyOwner {
        for (uint256 i = 0; i < _addresses.length; i++) {
            whitelisted[_addresses[i]] = _whitelisted;
        }
    }

    function emergencyWithdraw() public onlyOwner {
        uint256 balance = address(this).balance;
        payable(msg.sender).transfer(balance);
    }

    function emergencyMint(uint256 _mintAmount, address _to) public onlyOwner {
        uint256 supply = totalSupply();
        require(_mintAmount > 0, "You cannot mint 0 NFTs");
        require(_mintAmount <= MAX_MINT_AMOUNT, "You are minting too many NFTs");
        require(supply + _mintAmount <= MAX_NFT_SUPPLY, "Exceeds maximum NFT supply");

        for (uint256 i = 0; i < _mintAmount; i++) {
            _safeMint(_to, supply + i);
        }
    }

    function emergencyMintToAddresses(uint256 _mintAmount, address[] memory _to) public onlyOwner {
        require(_mintAmount > 0, "You cannot mint 0 NFTs");
        require(_mintAmount <= MAX_MINT_AMOUNT, "You are minting too many NFTs");
        require(_to.length <= _mintAmount, "Not enough addresses");

        for (uint256 i = 0; i < _to.length; i++) {
            _safeMint(_to[i], totalSupply() + i);
        }
    }

    function emergencyBurn(uint256 _tokenId) public onlyOwner {
        _burn(_tokenId);
    }

    function emergencyBurnBatch(uint256[] memory _tokenIds) public onlyOwner {
        for (uint256 i = 0; i < _tokenIds.length; i++) {
            _burn(_tokenIds[i]);
        }
    }

    function emergencyPause() public onlyOwner {
        paused = true;
    }

    function emergencyUnpause() public onlyOwner {
        paused = false;
    }

    function emergencyReveal() public onlyOwner {
        revealed = true;
    }

    function emergencySetRevealTimestamp(uint256 _revealTimestamp) public onlyOwner {
        revealTimestamp = _revealTimestamp;
    }

    function emergencyStartSale(uint256 _saleStartTimestamp) public onlyOwner {
        saleStartTimestamp = _saleStartTimestamp;
    }

    function emergencySetWhitelisted(address _address, bool _whitelisted) public onlyOwner {
        whitelisted[_address] = _whitelisted;
    }

    function emergencySetOnlyWhitelisted(bool _onlyWhitelisted) public onlyOwner {
        onlyWhitelisted = _onlyWhitelisted;
    }

    function emergencySetBaseTokenURI(string memory _baseTokenURI) public onlyOwner {
        baseTokenURI = _baseTokenURI;
    }

    function emergencyWithdraw() public onlyOwner {
        uint256 balance = address(this).balance;
        payable(msg.sender).transfer(balance);
    }

    function emergencyWithdrawAmount(uint256 _amount) public onlyOwner {
        uint256 balance = address(this).balance;
        require(_amount <= balance, "Amount exceeds balance");
        payable(msg.sender).transfer(_amount);
    }

    function emergencyWithdrawToken(address _token, uint256 _amount) public onlyOwner {
        IERC20(_token).transfer(msg.sender, _amount);
    }

    function emergencyWithdrawToken(address _token) public onlyOwner {
        IERC20 token = IERC20(_token);
        uint256 balance = token.balanceOf(address(this));
        token.transfer(msg.sender, balance);
    }

    function emergencyWithdrawAllTokens(address[] memory _tokens) public onlyOwner {
        for (uint256 i = 0; i < _tokens.length; i++) {
            IERC20 token = IERC20(_tokens[i]);
            uint256 balance = token.balanceOf(address(this));
            token.transfer(msg.sender, balance);
        }
    }

    function emergencyWithdrawAllTokens() public onlyOwner {
        for (uint256 i = 0; i < 32; i++) {
            address token = address(0x

);

            if (token == address(0)) {
                continue;
            }

            IERC20 erc20 = IERC20(token);
            uint256 balance = erc20.balanceOf(address(this));
            erc20.transfer(msg.sender, balance);
        }
    }
}


