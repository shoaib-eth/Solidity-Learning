// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract counter {
    uint256 public count;

    function increment() public {
        count += 1;
    }

    function decrement() public {
        count -= 1;
    }

    function getCounterValue() public view returns (uint256) {
        return count;
    }

    function resetCounter() public {
        count = 0;
    }

    function setCounterValue(uint256 _count) public {
        count = _count;
    }
}
