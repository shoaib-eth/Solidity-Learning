// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract Mapping {
    mapping(uint => string) public names;
    mapping(uint => Book) public books;

    struct Book {
        string title;
        string author;
    }

    constructor() {
        names[1] = "Alice";
        names[2] = "Bob";
        names[3] = "Charlie";

        books[1] = Book("Book 1", "Author 1");
        books[2] = Book("Book 2", "Author 2");
        books[3] = Book("Book 3", "Author 3");
    }

    function addName(uint _id, string memory _name) public {
        names[_id] = _name;
    }

    function addBook(uint _id, string memory _title, string memory _author) public {
        books[_id] = Book(_title, _author);
    }

    function getBook(uint _id) public view returns (string memory, string memory) {
        Book memory book = books[_id];
        return (book.title, book.author);
    }
}

contract Student {
    mapping(uint => string) public students;

    constructor() {
        students[1] = "Alice";
        students[2] = "Bob";
        students[3] = "Charlie";
    }

    function addStudent(uint _id, string memory _name) public {
        students[_id] = _name;
    }

    function getStudent(uint _id) public view returns (string memory) {
        return students[_id];
    }
}

contract NestedMapping {
    mapping(uint => mapping(uint => bool)) public nestedMapping;

    function updateNestedMapping(uint _id1, uint _id2, bool _value) public {
        nestedMapping[_id1][_id2] = _value;
    }

    function getNestedMapping(uint _id1, uint _id2) public view returns (bool) {
        return nestedMapping[_id1][_id2];
    }
}

contract NestedMapping2 {
    mapping(uint => mapping(uint => mapping(uint => bool))) public nestedMapping;

    function updateNestedMapping(uint _id1, uint _id2, uint _id3, bool _value) public {
        nestedMapping[_id1][_id2][_id3] = _value;
    }

    function getNestedMapping(uint _id1, uint _id2, uint _id3) public view returns (bool) {
        return nestedMapping[_id1][_id2][_id3];
    }
}

contract NestedMapping3 {
    mapping(uint => mapping(uint => mapping(uint => mapping(uint => bool)))) public nestedMapping;

    function updateNestedMapping(uint _id1, uint _id2, uint _id3, uint _id4, bool _value) public {
        nestedMapping[_id1][_id2][_id3][_id4] = _value;
    }

    function getNestedMapping(uint _id1, uint _id2, uint _id3, uint _id4) public view returns (bool) {
        return nestedMapping[_id1][_id2][_id3][_id4];
    }
}