pragma solidity ^0.4.0;

import "./Class.sol";

contract Character {
    
    string private _name;
    Class private _class;

    constructor(string memory name, Class class) public {
        _name = name;
        _class = class;
    }

    function getName() public view returns(string memory) {
        return _name;
    }

    function getClass() public view returns(Class) {
        return _class;
    }

}