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