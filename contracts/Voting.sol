// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Voting {
    mapping(bytes32 => uint8) public votesReceived;
    bytes32[] public candidateList;

    constructor(bytes32[] memory candidateNames) {
        candidateList = candidateNames;
    }

    function totalVotesFor(bytes32 candidate) public view returns (uint8) {
        require(validCandidate(candidate));
        return votesReceived[candidate];
    }

    function voteForCandidate(bytes32 candidate) public {
        require(validCandidate(candidate));
        votesReceived[candidate] += 1;
    }

    function validCandidate(bytes32 candidate) public view returns (bool) {
        for (uint i = 0; i < candidateList.length; i++) {
            if (candidateList[i] == candidate) {
                return true;
            }
        }
        return false;
    }

    function getCandidateList() public view returns (bytes32[] memory) {
        return candidateList;
    }

    function getVotesReceived() public view returns (uint8[] memory) {
        uint8[] memory votes = new uint8[](candidateList.length);
        for (uint i = 0; i < candidateList.length; i++) {
            votes[i] = votesReceived[candidateList[i]];
        }
        return votes;
    }

    function getVotesReceivedFor(bytes32 candidate) public view returns (uint8) {
        return votesReceived[candidate];
    }
    
}