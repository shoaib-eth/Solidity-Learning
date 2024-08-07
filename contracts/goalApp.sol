// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract GoalApp {
    struct Goal {
        string name;
        uint256 target;
        uint256 current;
        uint256 deadline;
        address owner;
    }

    Goal[] public goals;

    function createGoal(string memory _name, uint256 _target, uint256 _deadline) public {
        goals.push(Goal(_name, _target, 0, _deadline, msg.sender));
    }

    function getGoals() public view returns (Goal[] memory) {
        return goals;
    }

    function contribute(uint256 _goalId, uint256 _amount) public {
        require(goals[_goalId].deadline > block.timestamp, "Goal has expired");
        require(goals[_goalId].owner != msg.sender, "Owner cannot contribute to own goal");
        require(goals[_goalId].current + _amount <= goals[_goalId].target, "Contribution exceeds target");
        goals[_goalId].current += _amount;
    }

    function withdraw(uint256 _goalId) public {
        require(goals[_goalId].deadline < block.timestamp, "Goal has not expired");
        require(goals[_goalId].owner == msg.sender, "Only owner can withdraw");
        payable(msg.sender).transfer(goals[_goalId].current);
        goals[_goalId].current = 0;
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function getGoalBalance(uint256 _goalId) public view returns (uint256) {
        return goals[_goalId].current;
    }
}