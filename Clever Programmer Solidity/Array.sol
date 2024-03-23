// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract Array {
    uint[] public numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

    function getNumber(uint _index) public view returns (uint) {
        return numbers[_index];
    }

    function getNumbers() public view returns (uint[] memory) {
        return numbers;
    }

    function pushNumber(uint _number) public {
        numbers.push(_number);
    }

    function popNumber() public {
        numbers.pop();
    }

    function getLength() public view returns (uint) {
        return numbers.length;
    }
}

contract AnotherArray {
    string[] public names;

    function addName(string memory _name) public {
        names.push(_name);
    }

    function getName(uint _index) public view returns (string memory) {
        require(_index < names.length, "Invalid index");
        return names[_index];
    }

    function getNames() public view returns (string[] memory) {
        return names;
    }

    function removeName(uint _index) public {
        require(_index < names.length, "Invalid index");
        for (uint i = _index; i < names.length - 1; i++) {
            names[i] = names[i + 1];
        }
        names.pop();
    }

    function getLength() public view returns (uint) {
        return names.length;
    }
}

contract NestedArray {
    uint[][] public array2D = [[1, 2], [3, 4], [5, 6]];

    function getArray2D() public view returns (uint[][] memory) {
        return array2D;
    }

    function getArray2DLength() public view returns (uint) {
        return array2D.length;
    }

    function getArray2DItem(
        uint _index1,
        uint _index2
    ) public view returns (uint) {
        return array2D[_index1][_index2];
    }

    function pushArray2D(uint[] memory _array) public {
        array2D.push(_array);
    }

    function popArray2D() public {
        array2D.pop();
    }
}

contract DynamicArray {
    uint[] public dynamicArray;

    function getDynamicArray() public view returns (uint[] memory) {
        return dynamicArray;
    }

    function getDynamicArrayLength() public view returns (uint) {
        return dynamicArray.length;
    }

    function pushDynamicArray(uint _number) public {
        dynamicArray.push(_number);
    }

    function popDynamicArray() public {
        dynamicArray.pop();
    }
}

contract DynamicArray2 {
    uint[][] public dynamicArray2;

    function getDynamicArray2() public view returns (uint[][] memory) {
        return dynamicArray2;
    }

    function getDynamicArray2Length() public view returns (uint) {
        return dynamicArray2.length;
    }

    function pushDynamicArray2(uint[] memory _array) public {
        dynamicArray2.push(_array);
    }

    function popDynamicArray2() public {
        dynamicArray2.pop();
    }
}
