pragma solidity ^0.5.2;

import "./Character.sol";

contract NonPlayableCharacter is Character {
    constructor(string memory name, Class class) public Character(name, class) {}
}