// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {SimpleStorage, SimpleStorage1, SimpleStorage2, SimpleStorage3} from "./simpleStorage.sol";

contract storageFactory {
    SimpleStorage public mySimpleStorageContract;

    function createSimpleStorage() public {
        mySimpleStorageContract = new SimpleStorage();
    }
}