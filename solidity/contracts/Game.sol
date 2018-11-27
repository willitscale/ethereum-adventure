pragma solidity ^0.4.0;

import "./Character.sol";

contract Game {
    
    mapping(address => Character) private _characters;

    function createCharacter(string memory name) public {
        _characters[msg.sender] = new Character(name);
    }

    function getCharacter() public view returns (Character) {
        return _characters[msg.sender];
    }

}