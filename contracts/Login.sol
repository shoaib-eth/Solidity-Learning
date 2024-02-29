// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract Login {
    function login(
        string memory _username,
        string memory _password
    ) public pure returns (bool) {
        return
            keccak256(abi.encodePacked(_username, _password)) ==
            keccak256(abi.encodePacked("admin", "admin"));
    }
}
