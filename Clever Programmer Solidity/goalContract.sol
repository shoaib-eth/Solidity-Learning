// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.4;

contract GoalContract {
    address public owner;
    string public goal;
    uint public deadline;
    uint public completionDate;
    bool public completed;
    bool public paidOut;

    constructor(address _owner, string memory _goal, uint _deadline) {
        owner = _owner;
        goal = _goal;
        deadline = _deadline;
    }

    function complete() public {
        require(msg.sender == owner, "You are not the owner");
        require(!completed, "Goal already completed");
        require(block.timestamp <= deadline, "Deadline has passed");

        completed = true;
        completionDate = block.timestamp;
    }

    function payout() public {
        require(msg.sender == owner, "You are not the owner");
        require(completed, "Goal not completed");
        require(!paidOut, "Already paid out");

        paidOut = true;
        payable(owner).transfer(address(this).balance);
    }
}