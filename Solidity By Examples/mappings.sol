// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract Mappings {
    uint256 myNumber;

    mapping(address => uint256) public myAddressMapping;

    function setMyNumber(uint256 _myNumber) public {
        myNumber = _myNumber;
    }

    function getMyNumber() public view returns (uint256) {
        return myNumber;
    }

    function setMyAddressMapping(uint256 _myNumber) public {
        myAddressMapping[msg.sender] = _myNumber;
    }

    function getMyAddressMapping() public view returns (uint256) {
        return myAddressMapping[msg.sender];
    }

    function getMyAddressMapping(address _address) public view returns (uint256) {
        return myAddressMapping[_address];
    }
}
