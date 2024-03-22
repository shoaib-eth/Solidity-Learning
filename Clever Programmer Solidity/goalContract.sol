// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

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

    function getDetails()
        public
        view
        returns (address, string memory, uint, uint, uint, bool, bool)
    {
        return (
            owner,
            goal,
            deadline,
            completionDate,
            address(this).balance,
            completed,
            paidOut
        );
    }
}
