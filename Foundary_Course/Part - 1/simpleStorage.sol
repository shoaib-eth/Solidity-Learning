// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract simpleStorage {
    uint myNumber;

    // Array of a Person
    struct Person {
        string name;
        uint age;
    }

    // Array of Person struct type 
    Person[] public listOfPeoples;

    // Mapping of name to age 
    mapping(string => uint) public nameToAge;

    // Store a number
    function store(uint _myNumber) public virtual {
        myNumber = _myNumber;
    }

    // Retrieve the stored number
    function retrieveNumber() public view returns (uint) {
        return myNumber;
    }

    // Add a person to the list of people and store their name and age in the mapping 
    function addPerson(string memory _name, uint _age) public {
        listOfPeoples.push(Person(_name, _age));
        nameToAge[_name] = _age;
    }
}
