// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

/*
    * Fibonacchi
    * A simple smart contract that calculates the nth Fibonacci number.
    * The contract is implemented using Solidity version 0.8.24.
    * The contract uses a recursive function to calculate the Fibonacci number.
*/

contract Fibonacchi {
    /// @notice Calculates the nth Fibonacci number
    /// @param n The index of the Fibonacci number to calculate
    /// @return The nth Fibonacci number
    function fibonacci(uint256 n) public pure returns (uint256) {
        if (n == 0) {
            return 0;
        } else if (n == 1) {
            return 1;
        } else {
            return fibonacci(n - 1) + fibonacci(n - 2);
        }
    }
}
