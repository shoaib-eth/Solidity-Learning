// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Operations {
    uint256 public a;
    uint256 public b;

    function set(uint256 _a, uint256 _b) public {
        a = _a;
        b = _b;
    }

    function add() public view returns (uint256) {
        return a + b;
    }

    function subtract() public view returns (uint256) {
        return a - b;
    }

    function multiply() public view returns (uint256) {
        return a * b;
    }

    function divide() public view returns (uint256) {
        return a / b;
    }

    function modulo() public view returns (uint256) {
        return a % b;
    }

    function power() public view returns (uint256) {
        return a ** b;
    }
}
