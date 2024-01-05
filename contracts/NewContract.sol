// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract NewContract {
<<<<<<< HEAD
    string public data;

    function sendData(string memory _data) public {
        data = _data;
    }

    function getData() public view returns (string memory) {
        return data;
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
=======
    mapping(uint256 => string) public myMap;     

    function addValue(uint256 key, string memory value) public {
        myMap[key] = value;
    }

    function getValue(uint256 key) public view returns (string memory) {
        return myMap[key];
    }

    function deleteValue(uint256 key) public {
        delete myMap[key];
>>>>>>> a36a43071ff3de4fd16c886a48cf70e98db1ce4a
    }
}
