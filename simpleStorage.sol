// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0; // Use the caret (^) to indicate compatibility with 0.8.x versions

contract SimpleStorage {

    uint256 favoriteNumber; // A simple unsigned integer variable to store a favorite number

    struct People {
        uint256 favoriteNumber;
        string name;
    }

    People[] public people; // An array of People structs that will store people's information

    mapping(string => uint256) public nameToFavoriteNumber; // A mapping to associate names with favorite numbers

    // Function to store a favorite number
    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }
    
    // Function to retrieve the stored favorite number
    function retrieve() public view returns (uint256) {
        return favoriteNumber;
    }

    // Function to add a person with their name and favorite number to the people array and the mapping
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        people.push(People(_favoriteNumber, _name)); // Add a new person to the people array
        nameToFavoriteNumber[_name] = _favoriteNumber; // Map the person's name to their favorite number
    }
}
