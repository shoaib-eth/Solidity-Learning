// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract crowdFunding {
    address public owner;
    uint public goal;
    uint public endTime;
    mapping(address => uint) public contributions;
    uint public totalContributors;
    uint public totalContributions;

    constructor(uint _goal, uint _timeLimit) {
        owner = msg.sender;
        goal = _goal;
        endTime = block.timestamp + _timeLimit;
    }

    function contribute() public payable {
        require(block.timestamp < endTime, "The campaign has ended");
        contributions[msg.sender] += msg.value;
        totalContributors++;
        totalContributions += msg.value;
    }

    function withdraw() public {
        require(block.timestamp > endTime, "The campaign is still ongoing");
        require(
            totalContributions >= goal,
            "The campaign did not reach its goal"
        );
        require(msg.sender == owner, "You are not the owner");
        payable(owner).transfer(address(this).balance);
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    function getRefund() public {
        require(block.timestamp > endTime, "The campaign is still ongoing");
        require(totalContributions < goal, "The campaign reached its goal");
        require(contributions[msg.sender] > 0, "You did not contribute");
        payable(msg.sender).transfer(contributions[msg.sender]);
        contributions[msg.sender] = 0;
    }
}
