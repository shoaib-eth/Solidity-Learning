// SPDX-License-Identifier: MIT

pragma solidity 0.8.19; 

import {SimpleStorage, SimpleStorage1, SimpleStorage2, SimpleStorage3} from "./simpleStorage.sol";  // import the contract SimpleStorage from the file simpleStorage.sol 

contract storageFactory {
    SimpleStorage public mySimpleStorageContract; // create a variable of type SimpleStorage and call it mySimpleStorageContract 

    function createSimpleStorage() public {
        mySimpleStorageContract = new SimpleStorage(); // create an instance of SimpleStorage and assign it to the variable mySimpleStorageContract 
    }
}
