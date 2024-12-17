// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract simpleStorage {
    uint256 myNumber;

    // Array of a Person
    struct Person {
        string name;
        uint256 age;
    }

    // Array of Person struct type
    Person[] public listOfPeoples;

    // Mapping of name to age
    mapping(string => uint256) public nameToAge;

    // Mapping of age to name
    mapping(uint256 => string) public ageToName;

    // Store a number
    function store(uint256 _myNumber) public virtual {
        myNumber = _myNumber;
    }

    // Retrieve the stored number
    function retrieveNumber() public view returns (uint256) {
        return myNumber;
    }

    // Add a person to the list of people and store their name and age in the mapping
    function addPerson(string memory _name, uint256 _age) public {
        listOfPeoples.push(Person(_name, _age));
        nameToAge[_name] = _age;
        ageToName[_age] = _name;
    }
}
