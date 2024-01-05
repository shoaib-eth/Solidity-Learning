// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract simpleStorage {
    uint myNumber;

    // Array of a Person
    struct Person {
        string name;
        uint age;
    }

    Person[] public listOfPeoples;

    mapping(string => uint) public nameToAge;

    function store(uint _myNumber) public virtual {
        myNumber = _myNumber;
    }

    function retrieveNumber() public view returns (uint) {
        return myNumber;
    }

    function addPerson(string memory _name, uint _age) public {
        listOfPeoples.push(Person(_name, _age));
        nameToAge[_name] = _age;
    }
}
