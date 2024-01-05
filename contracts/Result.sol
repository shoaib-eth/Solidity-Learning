// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Result {
    struct ExamResult {
        uint256 marks;
        bool isPublished;
    }

    mapping(address => ExamResult) public results;

    function publishResult(address student, uint256 marks) public {
        require(
            !results[student].isPublished,
            "Result already published for this student"
        );
        results[student] = ExamResult(marks, true);
    }

    function getMarks(address student) public view returns (uint256) {
        require(
            results[student].isPublished,
            "Result not published for this student"
        );
        return results[student].marks;
    }

    struct SubjectMarks {
        uint256 subject1;
        uint256 subject2;
        uint256 subject3;
    }

    mapping(address => SubjectMarks) public subjectResults;

    function submitSubjectMarks(
        uint256 subject1,
        uint256 subject2,
        uint256 subject3
    ) public {
        subjectResults[msg.sender] = SubjectMarks(subject1, subject2, subject3);
    }

    function getSubjectMarks(
        address student
    ) public view returns (uint256, uint256, uint256) {
        return (
            subjectResults[student].subject1,
            subjectResults[student].subject2,
            subjectResults[student].subject3
        );
    }
}

// Contract for calculating percentage and division based on marks
contract ResultCalculator {
    function calculatePercentage(
        uint256 totalMarks,
        uint256 obtainedMarks
    ) public pure returns (uint256) {
        require(totalMarks > 0, "Total marks should be greater than zero");
        require(
            obtainedMarks >= 0 && obtainedMarks <= totalMarks,
            "Obtained marks should be between 0 and total marks"
        );

        uint256 percentage = (obtainedMarks * 100) / totalMarks;
        return percentage;
    }

    function calculateDivision(
        uint256 percentage
    ) public pure returns (string memory) {
        require(
            percentage >= 0 && percentage <= 100,
            "Percentage should be between 0 and 100"
        );

        if (percentage >= 90) {
            return "Distinction";
        } else if (percentage >= 80) {
            return "First Division";
        } else if (percentage >= 60) {
            return "Second Division";
        } else if (percentage >= 40) {
            return "Third Division";
        } else {
            return "Fail";
        }
    }

    function calculateResult(
        uint256 totalMarks,
        uint256 obtainedMarks
    ) public pure returns (string memory) {
        uint256 percentage = calculatePercentage(totalMarks, obtainedMarks);
        string memory division = calculateDivision(percentage);
        return division;
    }
}
