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

    function increment() public {
        a++;
    }

    function decrement() public {
        a--;
    }

    function negate() public {
        a = -a;
    }

    function factorial() public view returns (uint256) {
        uint256 result = 1;
        for (uint256 i = 1; i <= a; i++) {
            result *= i;
        }
        return result;
    }

    function isPrime() public view returns (bool) {
        if (a <= 1) {
            return false;
        }
        for (uint256 i = 2; i * i <= a; i++) {
            if (a % i == 0) {
                return false;
            }
        }
        return true;
    }

    function isEven() public view returns (bool) {
        return a % 2 == 0;
    }

    function isOdd() public view returns (bool) {
        return a % 2 != 0;
    }

    function isPerfectSquare() public view returns (bool) {
        uint256 sqrt = uint256(0);
        uint256 x = a;
        uint256 y = (x + 1) / 2;
        while (y < x) {
            x = y;
            y = (x + a / x) / 2;
        }
        sqrt = x;
        return sqrt * sqrt == a;
    }
}
