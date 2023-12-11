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
    
    function submitSubjectMarks(uint256 subject1, uint256 subject2, uint256 subject3) public {
        subjectResults[msg.sender] = SubjectMarks(subject1, subject2, subject3);
    }
    
    function getSubjectMarks(address student) public view returns (uint256, uint256, uint256) {
        return (
            subjectResults[student].subject1,
            subjectResults[student].subject2,
            subjectResults[student].subject3
        );
    }
}
