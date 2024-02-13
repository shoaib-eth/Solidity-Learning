// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.24;

contract AreaOfCircle {
    function area(uint256 _radius) public pure returns (uint256) {
        return 3.14 * _radius * _radius;
    }
}