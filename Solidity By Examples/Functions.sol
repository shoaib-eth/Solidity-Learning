// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FunctionsExample {
    // State variable
    uint256 public stateVariable;

    // Constructor
    constructor(uint256 _initialValue) {
        stateVariable = _initialValue;
    }

    // Public function
    function setStateVariable(uint256 _value) public {
        stateVariable = _value;
    }

    // View function
    function getStateVariable() public view returns (uint256) {
        return stateVariable;
    }

    // Pure function
    function add(uint256 a, uint256 b) public pure returns (uint256) {
        return a + b;
    }

    // Internal function
    function _multiply(uint256 a, uint256 b) internal pure returns (uint256) {
        return a * b;
    }

    // Private function
    function _subtract(uint256 a, uint256 b) private pure returns (uint256) {
        return a - b;
    }

    // Function that uses internal function
    function multiplyAndAdd(uint256 a, uint256 b, uint256 c) public pure returns (uint256) {
        return _multiply(a, b) + c;
    }

    // Function that uses private function
    function subtractAndAdd(uint256 a, uint256 b, uint256 c) public pure returns (uint256) {
        return _subtract(a, b) + c;
    }

    // Function that uses internal and private functions
    function multiplyAndSubtract(uint256 a, uint256 b, uint256 c) public pure returns (uint256) {
        return _multiply(a, b) - _subtract(b, c);
    }
}
