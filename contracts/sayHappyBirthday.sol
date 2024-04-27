// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Birthday {
    uint256 BirthMonth;
    uint256 BirthDate;

    function set(uint256 _BirthMonth, uint256 _BirthDate) public {
        BirthMonth = _BirthMonth;
        BirthDate = _BirthDate;
    }

    function sayHappyBirthday() public view returns (string memory) {
        if (BirthMonth == 4 && BirthDate == 27) {
            return "Happy birthday to you!";
        } else {
            return "It's not your birthday.";
        }
    }
}
