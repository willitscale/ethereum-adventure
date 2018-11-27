pragma solidity ^0.4.0;

contract Character {
    
    string private _name;

    constructor(string memory name) public {
        _name = name;
    }

    function getName() public view returns(string memory) {
        return _name;
    }

}