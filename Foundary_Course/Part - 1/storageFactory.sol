// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {simpleStorage} from "./simpleStorage.sol";

contract storageFactory {
    simpleStorage[] public listOfSimpleStorageContract;

    function createSimpleStorageContract() public {
        simpleStorage simpleStorageContractVariable = new simpleStorage();
        listOfSimpleStorageContract.push(simpleStorageContractVariable);
    }

    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber)
        public
    {
        listOfSimpleStorageContract[_simpleStorageIndex].store(
            _simpleStorageNumber
        );
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns (uint256) {
        return
            listOfSimpleStorageContract[_simpleStorageIndex].retrieveNumber();
    }
}
