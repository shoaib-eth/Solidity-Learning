// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Transaction {
    address public owner;
    
    constructor() {
        owner = msg.sender;
    }
    
    function transferOwnership(address newOwner) public {
        require(msg.sender == owner, "Only the owner can transfer ownership");
        owner = newOwner;
    }
    
    function getOwner() public view returns (address) {
        return owner;
    }
    
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}

contract TransactionDetails {
    Transaction private transactionContract;

    constructor(address transactionContractAddress) {
        transactionContract = Transaction(transactionContractAddress);
    }

    function getTransactionOwner() public view returns (address) {
        return transactionContract.getOwner();
    }

    function getContractBalance() public view returns (uint256) {
        return transactionContract.getBalance();
    }
<<<<<<< HEAD
}
=======
}
>>>>>>> a36a43071ff3de4fd16c886a48cf70e98db1ce4a
