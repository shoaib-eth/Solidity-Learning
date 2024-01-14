// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract CrowdFunding {
    struct Investor {
        address payable addr;
        uint256 amount;
    }

    address public owner;
    uint256 public numInvestors;
    uint256 public deadline;
    string public status;
    bool public ended;
    uint256 public goalAmount;
    uint256 public totalAmount;
    mapping(uint256 => Investor) public investors;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    constructor(uint256 _duration, uint256 _goalAmount) {
        owner = msg.sender;
        deadline = block.timestamp + _duration;
        goalAmount = _goalAmount;
        status = "Funding";
        ended = false;
        numInvestors = 0;
        totalAmount = 0;
    }

    function fund() public payable {
        require(!ended);
        Investor storage inv = investors[numInvestors++];
        inv.addr = payable(msg.sender);
        inv.amount = msg.value;
        totalAmount += inv.amount;
    }

    function checkGoalReached() public onlyOwner {
        require(!ended);
        require(block.timestamp >= deadline);
        ended = true;
        if (totalAmount >= goalAmount) {
            status = "Campaign Succeeded";
            if (!owner.send(address(this).balance)) {
                revert();
            }
        } else {
            uint256 i = 0;
            status = "Campaign Failed";
            while (i <= numInvestors) {
                if (!investors[i].addr.send(investors[i].amount)) {
                    revert();
                }
                i++;
            }
        }
    }

    function kill() public onlyOwner {
        selfdestruct(payable(owner));
    }
}
