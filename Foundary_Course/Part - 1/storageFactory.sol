// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {simpleStorage} from "./simpleStorage.sol";

contract storageFactory {
    // List of simpleStorage contracts
    simpleStorage[] public listOfSimpleStorageContract;

    // Create a new simpleStorage contract and store it in the list
    function createSimpleStorageContract() public {
        simpleStorage simpleStorageContractVariable = new simpleStorage();
        listOfSimpleStorageContract.push(simpleStorageContractVariable);
    }

    // Store a number in a simpleStorage contract
    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
        listOfSimpleStorageContract[_simpleStorageIndex].store(_simpleStorageNumber);
    }

    // Retrieve a number from a simpleStorage contract
    function sfGet(uint256 _simpleStorageIndex) public view returns (uint256) {
        return listOfSimpleStorageContract[_simpleStorageIndex].retrieveNumber();
    }
}
