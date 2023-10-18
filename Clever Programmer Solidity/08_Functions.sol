// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Modifiers {
    uint256 myNumber = 5; // Declaring an unsigned integer state variable 'myNumber' with an initial value of 5.

    // Function to add a value to 'myNumber'
    function addTwoValues(uint256 _value) public {
        myNumber += _value; // Increment 'myNumber' by the value passed as a parameter.
    }

    // Function to get the current value of 'myNumber'
    function getTheValue() public view returns (uint256) {
        return myNumber; // Return the current value of 'myNumber' as an unsigned integer.
    }
}
