// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract fallbackExample {
    uint256 public result;

    receive() external payable {
        result = 1;
    }

    fallback() external payable {
        result = 2;
    }
}

// Explain by https://solidity-by-example.org/fallback/

// Ether is sent to contract
//        is msg.data empty
//            /   \
//          Yes    No
//           /      \
//    recieve()?   fallback()
//         /          \
//       Yes           No
//       /              \
//  recieve()         fallback()

//\\//\\//\\//\\// Explanation \\//\\//\\//\\//\\//\\//

/* This is a simple Ethereum smart contract written in Solidity language. The contract is called `fallbackExample`. The contract has a public state variable `result` of type `uint256` which will hold either 1 or 2 depending on whether a function is called or Ether is sent to this contract.

Here's a brief explanation of this contract:

- `receive() external payable`: This function is triggered when Ether is sent directly to this contract without data. It can also receive Ether if no function in this contract matches the call data (function signature and arguments). The `payable` keyword allows this function to receive Ether. The `external` keyword means this function can only be called outside of this contract (it cannot be called from other contracts or from inside this contract). The `receive()` function is special because it can receive Ether without data (function signature). When Ether is sent without data, EVM will look for `receive()` function in the contract's bytecode. If it exists, EVM will execute this function when Ether is received. If `receive()` function does not exist or it fails for some reason (for example due to out-of-gas), Ether will be returned to the sender. 

- `fallback() external payable`: This function is triggered when Ether is sent directly to this contract with data (function signature and arguments). It can also receive Ether if no `receive()` function is found in this contract's bytecode. The `payable` keyword allows this function to receive Ether. The `external` keyword means this function can only be called outside of this contract (it cannot be called from other contracts or from inside this contract). 

In summary, if you send Ether directly to this contract (without data), `receive()` function will be called (if it exists). If you send Ether directly to this contract (with data), `fallback()` function will be called (if it exists). If neither `receive()` nor `fallback()` functions exist or they fail for some reason, Ether will be returned to the sender. */
