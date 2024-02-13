// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.24;

contract NamePrinter {
    string public name;

    constructor(string memory _name) {
        name = _name;
    }

    function printName() public view returns (string memory) {
        return name;
    }
}