// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DataTypes {
    // Define variables of different types
    uint256 myUint = 21;
    bool myBool = true;
    string myString = "hello!";
    address payable myAddress =
        payable(0x376902114964B34A88E5fdD7eC34113178A14fa2);
    bytes myBytes = "hello!";

    // Define arrays of diffrent types
    uint256[] myUintArray = [1, 2, 3, 4, 5];
    bool[] myBoolArray = [true, false, true];
    string[] myStringArray = ["Apple", "Mango", "Banana"];
    address payable[] myAddressArray = [
        payable(0x376902114964B34A88E5fdD7eC34113178A14fa2),
        payable(0x38a5729B9382E913d26B8de9D9b40428c89BE7B7)
    ];

    // Define a struct of different types
    struct Person {
        string name;
        uint256 age;
        bool hasDrivingLicense;
    }

    Person myPerson = Person("Shoaib", 21, true);
}
