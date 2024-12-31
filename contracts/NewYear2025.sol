// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract NewYear2025 {
    string public name;

    function enterName(string memory _name) public {
        name = _name;
    }

    function wishHappyNewYear() public view returns (string memory) {
        return string(abi.encodePacked(name, " wishes you a Happy New Year 2025!"));
    }
}
