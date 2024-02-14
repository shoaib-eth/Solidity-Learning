// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract login {
    event logString(string);
    event logInt(uint);
    event logAddress(address);
    
    function emitString(string memory _str) public {
        emit logString(_str);
    }
    
    function emitInt(uint _int) public {
        emit logInt(_int);
    }
    
    function emitAddress(address _address) public {
        emit logAddress(_address);
    }
    
    function emitAll(string memory _str, uint _int, address _address) public {
        emit logString(_str);
        emit logInt(_int);
        emit logAddress(_address);
    }
}