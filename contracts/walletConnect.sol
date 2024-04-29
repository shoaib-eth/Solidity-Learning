// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract walletConnect {
    address public owner;
    uint256 public balance;

    constructor() {
        owner = msg.sender;
    }

    function deposit() public payable {
        balance += msg.value;
    }

    function withdraw(uint256 _amount) public {
        require(msg.sender == owner, "You are not the owner");
        require(_amount <= balance, "Insufficient balance");
        payable(owner).transfer(_amount);
        balance -= _amount;
    }

    function getBalance() public view returns (uint256) {
        return balance;
    }

    function transfer(address _to, uint256 _amount) public {
        require(_amount <= balance, "Insufficient balance");
        balance -= _amount;
        payable(_to).transfer(_amount);
    }

    function getOwner() public view returns (address) {
        return owner;
    }

    function setOwner(address _owner) public {
        require(msg.sender == owner, "You are not the owner");
        owner = _owner;
    }

    function destroy() public {
        require(msg.sender == owner, "You are not the owner");
        selfdestruct(payable(owner));
    }

    receive() external payable {}

    fallback() external payable {}

    function getContractAddress() public view returns (address) {
        return address(this);
    }
}
